<?php

namespace Controllers\Checkout;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Cart\Cart as CartDAO;
use Dao\Products\Products as ProductsDAO;

class Checkout extends PublicController
{
    private array $viewData = [];

    private function getUserCod(): int
    {
        if (isset($_SESSION["login"]["usercod"])) {
            return intval($_SESSION["login"]["usercod"]);
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
        }

        // 👉 CARGAR CARRITO DESDE DB
        $this->loadCart();

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

        if ($usercod > 0) {
            $totalData = CartDAO::getCartTotalByUser($usercod);
            $total = floatval($totalData["total"] ?? 0);

            if ($total > 0) {
                $_SESSION["checkout_msg"] = "Compra realizada con éxito.";
                CartDAO::clearCartUser($usercod);
            }
        } else {
            $anoncod = $this->getAnonCod();
            $totalData = CartDAO::getCartTotalByAnon($anoncod);
            $total = floatval($totalData["total"] ?? 0);

            if ($total > 0) {
                $_SESSION["checkout_msg"] = "Compra simulada con éxito. Inicie sesión para guardar historial.";
                CartDAO::clearCartAnon($anoncod);
            }
        }

        header("Location: index.php?page=Checkout_Checkout");
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