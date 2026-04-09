<?php

namespace Dao\Checkout;

use Dao\Table;

class Orders extends Table
{
    public static function createOrder(int $usercod, string $anoncod, float $total)
    {
        $sqlstr = "INSERT INTO ordenes (usercod, anoncod, ordenfching, ordensubtotal, ordenimpuesto, ordentotal, ordenest) 
                   VALUES (:usercod, :anoncod, NOW(), :subtotal, :impuesto, :total, 'COM');";
        
        $params = [
            "usercod" => $usercod > 0 ? $usercod : null,
            "anoncod" => $anoncod !== "" ? $anoncod : null,
            "subtotal" => $total,
            "impuesto" => 0,
            "total" => $total
        ];
        
        self::executeNonQuery($sqlstr, $params);
        return self::getConn()->lastInsertId();
    }

    public static function createOrderDetail(int $ordencod, int $productId, int $cantidad, float $precio, float $total)
    {
        $sqlstr = "INSERT INTO orden_detalle (ordencod, productId, ordetcantidad, ordetprecio, ordettotal)
                   VALUES (:ordencod, :productId, :cantidad, :precio, :total);";
        
        return self::executeNonQuery($sqlstr, [
            "ordencod" => $ordencod,
            "productId" => $productId,
            "cantidad" => $cantidad,
            "precio" => $precio,
            "total" => $total
        ]);
    }
}
?>
