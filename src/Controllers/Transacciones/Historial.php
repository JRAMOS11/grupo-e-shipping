<?php

namespace Controllers\Transacciones;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Transacciones\Transacciones as TransaccionesDAO;
use Utilities\Security;
use Utilities\Site;

class Historial extends PrivateController
{
    public function run(): void
    {
        $usercod = intval(Security::getUserId());
        $action  = $_GET['action'] ?? '';

        // Ver detalle de una orden específica
        if ($action === 'detalle') {
            $ordencod = intval($_GET['ordencod'] ?? 0);

            if ($ordencod <= 0) {
                header('Location: index.php?page=Transacciones_Historial');
                exit();
            }

            // Solo puede ver el detalle si la orden le pertenece (validado en el DAO)
            $detalle = TransaccionesDAO::getDetalleOrden($ordencod, $usercod);

            if (empty($detalle)) {
                header('Location: index.php?page=Transacciones_Historial');
                exit();
            }

            $viewData = [
                'ordencod' => $ordencod,
                'detalle'  => $detalle,
                'subtotal' => array_sum(array_column($detalle, 'ordettotal')),
            ];

            Site::addLink('public/css/checkout.css');
            Renderer::render('transacciones/detalle', $viewData);
            return;
        }

        // Vista principal: historial + resumen
        $historial = TransaccionesDAO::getHistorialByUser($usercod);
        $resumen   = TransaccionesDAO::getResumenByUser($usercod);

        // Etiquetas legibles para método de pago y estado
        foreach ($historial as &$row) {
            $row['method_label'] = self::methodLabel($row['transmethod']);
            $row['status_label'] = self::statusLabel($row['transstatus']);
            $row['status_class'] = self::statusClass($row['transstatus']);
        }
        unset($row);

        $viewData = [
            'historial' => $historial,
            'resumen'   => $resumen,
        ];

        Site::addLink('public/css/checkout.css');
        Renderer::render('transacciones/historial', $viewData);
    }

    // ---------------------------------------------------------------
    // Helpers de presentación
    // ---------------------------------------------------------------

    private static function methodLabel(string $method): string
    {
        $map = [
            'LOCAL'    => '💵 Pago Local',
            'PAYPAL'   => '🅿️ PayPal',
            'PIXELPAY' => '💳 PixelPay',
        ];
        return $map[$method] ?? $method;
    }

    private static function statusLabel(string $status): string
    {
        $map = [
            'COM' => 'Completado',
            'PEN' => 'Pendiente',
            'CAN' => 'Cancelado',
            'ERR' => 'Error',
        ];
        return $map[$status] ?? $status;
    }

    private static function statusClass(string $status): string
    {
        $map = [
            'COM' => 'status-com',
            'PEN' => 'status-pen',
            'CAN' => 'status-can',
            'ERR' => 'status-err',
        ];
        return $map[$status] ?? '';
    }
}
?>
