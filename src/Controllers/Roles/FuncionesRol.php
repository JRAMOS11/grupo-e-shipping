<?php

namespace Controllers\Roles;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Roles\FuncionesRol as DaoFuncionesRol;

class FuncionesRol extends PublicController
{
    private array $viewData = [];

    public function run(): void
    {
        $this->viewData["roles"] = DaoFuncionesRol::obtenerRoles();
        $this->viewData["funciones"] = DaoFuncionesRol::obtenerFunciones();
        $this->viewData["relaciones"] = DaoFuncionesRol::obtenerRelaciones();
        $this->viewData["mensaje"] = "";

        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $rolescod = $_POST["rolescod"] ?? "";
            $fncod = $_POST["fncod"] ?? "";
            $accion = $_POST["accion"] ?? "";

            if ($rolescod !== "" && $fncod !== "") {
                if ($accion === "asignar") {
                    $existe = DaoFuncionesRol::obtenerRelacion($rolescod, $fncod);

                    if ($existe) {
                        DaoFuncionesRol::activar($rolescod, $fncod);
                        $this->viewData["mensaje"] = "Relación reactivada correctamente.";
                    } else {
                        DaoFuncionesRol::insertar($rolescod, $fncod);
                        $this->viewData["mensaje"] = "Función asignada correctamente al rol.";
                    }
                }

                if ($accion === "inactivar") {
                    DaoFuncionesRol::desactivar($rolescod, $fncod);
                    $this->viewData["mensaje"] = "Relación inactivada correctamente.";
                }
            }

            $this->viewData["relaciones"] = DaoFuncionesRol::obtenerRelaciones();
        }

        Renderer::render("roles/funcionesrol", $this->viewData);
    }
}