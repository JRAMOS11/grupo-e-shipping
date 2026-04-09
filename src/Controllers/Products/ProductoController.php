<?php

namespace Controllers\Products;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Products\ProductoDAO;

class ProductoController extends PublicController
{
    private array $viewData = [];

    public function run(): void
    {
        $action = $_GET["action"] ?? "listarProductos";
        
        switch ($action) {
            case "listarProductos":
                $this->listarProductos();
                break;
            case "verDetalle":
                $id = intval($_GET["id"] ?? 0);
                $this->verDetalle($id);
                break;
            case "mantenimiento":
                $this->checkAuth();
                $this->mantenimiento();
                break;
            case "crearProducto":
                $this->checkAuth();
                $this->crearProducto();
                break;
            case "editarProducto":
                $this->checkAuth();
                $id = intval($_GET["id"] ?? 0);
                $this->editarProducto($id);
                break;
            case "eliminarProducto":
                $this->checkAuth();
                $id = intval($_GET["id"] ?? 0);
                $this->eliminarProducto($id);
                break;
            default:
                $this->listarProductos();
                break;
        }
    }

    private function checkAuth()
    {
        if (!\Utilities\Security::isLogged()) {
            \Utilities\Site::redirectTo("index.php?page=sec_login");
        }
    }

    private function listarProductos()
    {
        $this->viewData["productos"] = ProductoDAO::obtenerTodos();
        Renderer::render("products/catalogo", $this->viewData);
    }

    private function verDetalle(int $id)
    {
        if ($id <= 0) {
            \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=listarProductos");
        }
        $producto = ProductoDAO::obtenerPorId($id);
        if (!$producto) {
            \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=listarProductos");
        }
        $this->viewData["producto"] = $producto;
        Renderer::render("products/detalle", $this->viewData);
    }

    private function mantenimiento()
    {
        $this->viewData["productos"] = ProductoDAO::obtenerTodos();
        Renderer::render("products/mantenimiento", $this->viewData);
    }

    private function crearProducto()
    {
        $this->viewData["mode"] = "INS";
        $this->viewData["modo_desc"] = "Crear Nuevo Producto";
        $this->viewData["readonly"] = "";
        $this->viewData["showBtn"] = true;
        
        $this->viewData["producto"] = [
            "productId" => 0,
            "categoryId" => 1,
            "productName" => "",
            "productDescription" => "",
            "productImgUrl" => "",
            "productPrice" => 0.00,
            "productStock" => 0,
            "productStatus" => "ACT"
        ];

        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $this->viewData["producto"]["productName"] = $_POST["productName"] ?? "";
            $this->viewData["producto"]["productDescription"] = $_POST["productDescription"] ?? "";
            $this->viewData["producto"]["productImgUrl"] = $_POST["productImgUrl"] ?? "";
            $this->viewData["producto"]["productPrice"] = floatval($_POST["productPrice"] ?? 0);
            $this->viewData["producto"]["productStock"] = intval($_POST["productStock"] ?? 0);
            $this->viewData["producto"]["categoryId"] = intval($_POST["categoryId"] ?? 1);
            $this->viewData["producto"]["productStatus"] = $_POST["productStatus"] ?? "ACT";

            if (empty(trim($this->viewData["producto"]["productName"])) || $this->viewData["producto"]["productPrice"] <= 0) {
                $this->viewData["error"] = "El nombre es requerido y el precio debe ser mayor a 0.";
            } else {
                ProductoDAO::insertar($this->viewData["producto"]);
                \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=mantenimiento");
            }
        }
        $this->viewData["producto"]["productStatus_ACT"] = ($this->viewData["producto"]["productStatus"] === "ACT");
        $this->viewData["producto"]["productStatus_INA"] = ($this->viewData["producto"]["productStatus"] === "INA");
        Renderer::render("products/mantenimiento_form", $this->viewData);
    }

    private function editarProducto(int $id)
    {
        if ($id <= 0) {
            \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=mantenimiento");
        }
        
        $this->viewData["mode"] = "UPD";
        $this->viewData["modo_desc"] = "Editar Producto";
        $this->viewData["readonly"] = "";
        $this->viewData["showBtn"] = true;

        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $this->viewData["producto"] = [
                "productId" => $id,
                "categoryId" => intval($_POST["categoryId"] ?? 1),
                "productName" => $_POST["productName"] ?? "",
                "productDescription" => $_POST["productDescription"] ?? "",
                "productImgUrl" => $_POST["productImgUrl"] ?? "",
                "productPrice" => floatval($_POST["productPrice"] ?? 0),
                "productStock" => intval($_POST["productStock"] ?? 0),
                "productStatus" => $_POST["productStatus"] ?? "ACT"
            ];

            if (empty(trim($this->viewData["producto"]["productName"])) || $this->viewData["producto"]["productPrice"] <= 0) {
                $this->viewData["error"] = "El nombre es requerido y el precio debe ser mayor a 0.";
            } else {
                ProductoDAO::actualizar($this->viewData["producto"]);
                \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=mantenimiento");
            }
        } else {
            $this->viewData["producto"] = ProductoDAO::obtenerPorId($id);
            if (!$this->viewData["producto"]) {
                \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=mantenimiento");
            }
        }
        $this->viewData["producto"]["productStatus_ACT"] = ($this->viewData["producto"]["productStatus"] === "ACT");
        $this->viewData["producto"]["productStatus_INA"] = ($this->viewData["producto"]["productStatus"] === "INA");

        Renderer::render("products/mantenimiento_form", $this->viewData);
    }

    private function eliminarProducto(int $id)
    {
        if ($id <= 0) {
            \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=mantenimiento");
        }
        
        $this->viewData["mode"] = "DEL";
        $this->viewData["modo_desc"] = "Eliminar Producto";
        $this->viewData["readonly"] = "readonly";
        $this->viewData["showBtn"] = true;

        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            ProductoDAO::eliminar($id);
            \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=mantenimiento");
        } else {
            $this->viewData["producto"] = ProductoDAO::obtenerPorId($id);
            if (!$this->viewData["producto"]) {
                \Utilities\Site::redirectTo("index.php?page=Products_ProductoController&action=mantenimiento");
            }
        }
        $this->viewData["producto"]["productStatus_ACT"] = ($this->viewData["producto"]["productStatus"] === "ACT");
        $this->viewData["producto"]["productStatus_INA"] = ($this->viewData["producto"]["productStatus"] === "INA");

        Renderer::render("products/mantenimiento_form", $this->viewData);
    }
}
?>
