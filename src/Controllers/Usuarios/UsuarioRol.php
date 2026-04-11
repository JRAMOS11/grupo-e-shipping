<?php

namespace Controllers\Usuarios;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Usuarios\UsuarioRol as DaoUsuarioRol;

class UsuarioRol extends PublicController
{
    private array $viewData = [];

    public function run(): void
    {
        $this->viewData["usuarios"] = DaoUsuarioRol::obtenerUsuarios();
        $this->viewData["roles"] = DaoUsuarioRol::obtenerRoles();
        $this->viewData["relaciones"] = DaoUsuarioRol::obtenerRolesUsuario();
        $this->viewData["mensaje"] = "";

        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $usercod = intval($_POST["usercod"] ?? 0);
            $rolescod = $_POST["rolescod"] ?? "";
            $accion = $_POST["accion"] ?? "";

            if ($usercod > 0 && $rolescod !== "") {
                if ($accion === "asignar") {
                    $existe = DaoUsuarioRol::obtenerRelacion($usercod, $rolescod);

                    if ($existe) {
                        DaoUsuarioRol::actualizarEstado($usercod, $rolescod, "ACT");
                        $this->viewData["mensaje"] = "Relación reactivada correctamente.";
                    } else {
                        DaoUsuarioRol::insertar($usercod, $rolescod);
                        $this->viewData["mensaje"] = "Rol asignado correctamente.";
                    }
                }

                if ($accion === "inactivar") {
                    DaoUsuarioRol::actualizarEstado($usercod, $rolescod, "INA");
                    $this->viewData["mensaje"] = "Relación inactivada correctamente.";
                }
            }

            $this->viewData["relaciones"] = DaoUsuarioRol::obtenerRolesUsuario();
        }

        Renderer::render("usuarios/usuariorol", $this->viewData);
    }
}