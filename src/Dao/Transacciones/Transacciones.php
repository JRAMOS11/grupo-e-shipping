<?php

namespace Dao\Transacciones;

use Dao\Table;

class Transacciones extends Table
{
    /**
     * Guarda una nueva transacción vinculada a una orden.
     *
     * @param int    $ordencod   ID de la orden recién creada
     * @param int    $usercod    ID del usuario (0 si es anónimo)
     * @param float  $amount     Monto total de la transacción
     * @param string $method     Método de pago: 'LOCAL', 'PAYPAL', 'PIXELPAY', etc.
     * @param string $reference  Referencia externa (token PayPal, etc.) — opcional
     * @param string $status     Estado inicial: 'COM' (completado), 'PEN' (pendiente)
     * @return int   ID de la transacción creada
     */
    public static function createTransaccion(
        int    $ordencod,
        int    $usercod,
        float  $amount,
        string $method    = 'LOCAL',
        string $reference = '',
        string $status    = 'COM'
    ): int {
        $sqlstr = "INSERT INTO transacciones
                       (ordencod, usercod, transfching, transamount, transmethod, transreference, transstatus)
                   VALUES
                       (:ordencod, :usercod, NOW(), :amount, :method, :reference, :status);";

        $params = [
            'ordencod'  => $ordencod,
            'usercod'   => $usercod > 0 ? $usercod : null,
            'amount'    => $amount,
            'method'    => $method,
            'reference' => $reference !== '' ? $reference : null,
            'status'    => $status,
        ];

        self::executeNonQuery($sqlstr, $params);
        return intval(self::getConn()->lastInsertId());
    }

    /**
     * Devuelve el historial de transacciones de un usuario con el detalle
     * de la orden (productos comprados).
     *
     * @param int $usercod  ID del usuario
     * @return array
     */
    public static function getHistorialByUser(int $usercod): array
    {
        $sqlstr = "SELECT
                       t.transcod,
                       t.ordencod,
                       t.transfching,
                       t.transamount,
                       t.transmethod,
                       t.transreference,
                       t.transstatus,
                       o.ordenest,
                       o.ordentotal,
                       o.ordenfching
                   FROM transacciones t
                   INNER JOIN ordenes o ON t.ordencod = o.ordencod
                   WHERE t.usercod = :usercod
                   ORDER BY t.transfching DESC;";

        return self::obtenerRegistros($sqlstr, ['usercod' => $usercod]);
    }

    /**
     * Devuelve el detalle (productos) de una orden específica,
     * pero solo si pertenece al usuario que la solicita (seguridad).
     *
     * @param int $ordencod  ID de la orden
     * @param int $usercod   ID del usuario que hace la consulta
     * @return array
     */
    public static function getDetalleOrden(int $ordencod, int $usercod): array
    {
        $sqlstr = "SELECT
                       od.ordendetcod,
                       od.ordetcantidad,
                       od.ordetprecio,
                       od.ordettotal,
                       p.productName,
                       p.productImgUrl
                   FROM orden_detalle od
                   INNER JOIN products p  ON od.productId  = p.productId
                   INNER JOIN ordenes  o  ON od.ordencod   = o.ordencod
                   WHERE od.ordencod = :ordencod
                     AND o.usercod   = :usercod;";

        return self::obtenerRegistros($sqlstr, [
            'ordencod' => $ordencod,
            'usercod'  => $usercod,
        ]);
    }

    /**
     * Resumen estadístico del usuario: total gastado, número de compras,
     * promedio por compra y fecha de la última transacción.
     *
     * @param int $usercod
     * @return array|false
     */
    public static function getResumenByUser(int $usercod)
    {
        $sqlstr = "SELECT
                       COUNT(*)          AS total_compras,
                       SUM(transamount)  AS total_gastado,
                       AVG(transamount)  AS promedio_compra,
                       MAX(transfching)  AS ultima_compra
                   FROM transacciones
                   WHERE usercod   = :usercod
                     AND transstatus = 'COM';";

        return self::obtenerUnRegistro($sqlstr, ['usercod' => $usercod]);
    }
}
?>
