<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Cart\Cart as CartDAO;
use Dao\Products\Products as ProductsDAO;
use Dao\Checkout\Orders as OrdersDAO;
use Dao\RutasEntrega\RutasEntrega as RutasEntregaDAO;
use Dao\Transacciones\Transacciones as TransaccionesDAO;
use Utilities\Site as Site;

class Checkout extends PublicController
{
    private array $viewData = [];

    private function getUserCod(): int
    {
        if (isset($_SESSION["login"]["userId"])) {
            return intval($_SESSION["login"]["userId"]);
        }
        return 0;
    }

    private function getAnonCod(): string
    {
        if (!isset($_SESSION["anoncod"]) || $_SESSION["anoncod"] === "") {
            $_SESSION["anoncod"] = session_id();
        }
        return $_SESSION["anoncod"];
    }

    public function run(): void
    {
        $action = $_GET["action"] ?? "";
        $productId = intval($_GET["productId"] ?? $_POST["productId"] ?? 0);

        switch ($action) {
            case "add":
                $this->addProduct($productId);
                return;

            case "remove":
                $this->removeProduct($productId);
                return;

            case "update":
                $this->updateProduct($productId);
                return;

            case "pay":
                $this->payCart();
                return;

            case "payment_form":
                $this->loadCart();
                Site::addLink("public/css/checkout.css");
                Renderer::render("checkout/payment", $this->viewData);
                return;

            case "success":
                $this->viewData["checkout_msg"] = $_SESSION["checkout_msg"] ?? "PAGO EXITOSO";
                $this->viewData["receipt_items"] = $_SESSION["receipt_items"] ?? [];
                $this->viewData["receipt_total"] = $_SESSION["receipt_total"] ?? 0;
                $this->viewData["receipt_order"] = $_SESSION["receipt_order"] ?? 0;
                unset($_SESSION["checkout_msg"], $_SESSION["receipt_items"], $_SESSION["receipt_total"], $_SESSION["receipt_order"]);
                Site::addLink("public/css/checkout.css");
                Renderer::render("checkout/success", $this->viewData);
                return;
        }

        // 👉 CARGAR CARRITO DESDE DB
        $this->loadCart();

        Site::addLink("public/css/checkout.css");
        Renderer::render("checkout/checkout", $this->viewData);
    }

    private function addProduct(int $productId): void
    {
        if ($productId <= 0) {
            header("Location: index.php?page=Products_Products");
            exit();
        }

        $product = ProductsDAO::getProductById($productId);

        if (!$product) {
            header("Location: index.php?page=Products_Products");
            exit();
        }

        $price = floatval($product["productPrice"]);
        $usercod = $this->getUserCod();

        if ($usercod > 0) {
            // usuario logeado
            CartDAO::addToCartUser($usercod, $productId, 1, $price);
        } else {
            // usuario anónimo
            CartDAO::addToCartAnon($this->getAnonCod(), $productId, 1, $price);
        }

        header("Location: index.php?page=Checkout_Checkout");
        exit();
    }

    private function removeProduct(int $productId): void
    {
        $usercod = $this->getUserCod();

        if ($usercod > 0) {
            CartDAO::removeFromCartUser($usercod, $productId);
        } else {
            CartDAO::removeFromCartAnon($this->getAnonCod(), $productId);
        }

        header("Location: index.php?page=Checkout_Checkout");
        exit();
    }

    private function updateProduct(int $productId): void
    {
        $cantidad = intval($_POST["cantidad"] ?? 1);

        if ($cantidad < 1) {
            $cantidad = 1;
        }

        $usercod = $this->getUserCod();

        if ($usercod > 0) {
            CartDAO::updateCartUser($usercod, $productId, $cantidad);
        } else {
            CartDAO::updateCartAnon($this->getAnonCod(), $productId, $cantidad);
        }

        header("Location: index.php?page=Checkout_Checkout");
        exit();
    }

    private function payCart(): void
    {
        $usercod = $this->getUserCod();
        $anoncod = $this->getAnonCod();
        //Crear Ruta de entrega segun la dirección ingresada 
        $direccion = "";
        $rutacod = 0;
        $metodoPago = $_POST["metodoPago"] ?? "";
        if ($metodoPago === "tarjeta") {
            $direccion = $_POST["cc_direccion"] ?? "";
        } else {
            $direccion = $_POST["ef_direccion"] ?? "";
        }
        if ($direccion !== "") {
            $rutacod = RutasEntregaDAO::insertDestinoEntrega($direccion);
        }

        if ($usercod > 0) {
            $totalData = CartDAO::getCartTotalByUser($usercod);
            $total = floatval($totalData["total"] ?? 0);

            if ($total > 0) {
                // Registrar orden
                $cartItems = CartDAO::getCartByUser($usercod);
                $ordencod = OrdersDAO::createOrder($usercod, "", $total, $rutacod);

                foreach ($cartItems as $item) {
                    OrdersDAO::createOrderDetail($ordencod, $item["productId"], $item["crrctd"], $item["crrprc"], floatval($item["lineTotal"]));
                }
                $metodoTrans = ($metodoPago === "tarjeta") ? "PIXELPAY" : "LOCAL";
                TransaccionesDAO::createTransaccion(
                    $ordencod,
                    $usercod,
                    $total,
                    $metodoTrans,
                    "",
                    "COM"
                );

                $_SESSION["receipt_items"] = $cartItems;
                $_SESSION["receipt_total"] = $total;
                $_SESSION["receipt_order"] = $ordencod;
                $_SESSION["checkout_msg"] = "COMPRA REALIZADA CORRECTAMENTE";
                CartDAO::clearCartUser($usercod);
            }
        } else {
            $totalData = CartDAO::getCartTotalByAnon($anoncod);
            $total = floatval($totalData["total"] ?? 0);

            if ($total > 0) {
                // Registrar orden para anónimo
                $cartItems = CartDAO::getCartByAnon($anoncod);
                $ordencod = OrdersDAO::createOrder(0, $anoncod, $total, $rutacod);

                foreach ($cartItems as $item) {
                    OrdersDAO::createOrderDetail($ordencod, $item["productId"], $item["crrctd"], $item["crrprc"], floatval($item["lineTotal"]));
                }
                $metodoTrans = ($metodoPago === "tarjeta") ? "PIXELPAY" : "LOCAL";

                TransaccionesDAO::createTransaccion(
                    $ordencod,
                    0,
                    $total,
                    $metodoTrans,
                    "",
                    "COM"
                );
                $_SESSION["receipt_items"] = $cartItems;
                $_SESSION["receipt_total"] = $total;
                $_SESSION["receipt_order"] = $ordencod;
                $_SESSION["checkout_msg"] = "COMPRA REALIZADA CORRECTAMENTE";
                CartDAO::clearCartAnon($anoncod);
            }
        }

        header("Location: index.php?page=Checkout_Checkout&action=success");
        exit();
    }

    private function loadCart(): void
    {
        $usercod = $this->getUserCod();

        if ($usercod > 0) {
            $this->viewData["cart"] = CartDAO::getCartByUser($usercod);
            $this->viewData["total"] = CartDAO::getCartTotalByUser($usercod)["total"] ?? 0;
        } else {
            $this->viewData["cart"] = CartDAO::getCartByAnon($this->getAnonCod());
            $this->viewData["total"] = CartDAO::getCartTotalByAnon($this->getAnonCod())["total"] ?? 0;
        }

        $this->viewData["checkout_msg"] = $_SESSION["checkout_msg"] ?? "";
        unset($_SESSION["checkout_msg"]);
    }
}
