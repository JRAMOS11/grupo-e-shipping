<?php

namespace Dao\Usuarios;

use Dao\Table;

class UsuarioRol extends Table
{
    public static function obtenerUsuarios()
    {
        $sqlstr = "SELECT 
                        usercod,
                        username,
                        useremail,
                        userest
                   FROM usuario;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerRoles()
    {
        $sqlstr = "SELECT 
                        rolescod,
                        rolesdsc,
                        rolesest
                   FROM roles;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerRolesUsuario()
    {
        $sqlstr = "SELECT 
                        ru.usercod,
                        u.username,
                        u.useremail,
                        ru.rolescod,
                        r.rolesdsc,
                        ru.roleuserest,
                        ru.roleuserfch,
                        ru.roleuserexp
                   FROM roles_usuarios ru
                   INNER JOIN usuario u ON ru.usercod = u.usercod
                   INNER JOIN roles r ON ru.rolescod = r.rolescod;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerRelacion($usercod, $rolescod)
    {
        $sqlstr = "SELECT 
                        usercod,
                        rolescod,
                        roleuserest,
                        roleuserfch,
                        roleuserexp
                   FROM roles_usuarios
                   WHERE usercod = :usercod
                     AND rolescod = :rolescod;";
        return self::obtenerUnRegistro($sqlstr, ["usercod" => $usercod, "rolescod" => $rolescod]);
    }

    public static function insertar($usercod, $rolescod)
    {
        $sqlstr = "INSERT INTO roles_usuarios
                        (usercod, rolescod, roleuserest, roleuserfch)
                   VALUES
                        (:usercod, :rolescod, 'ACT', NOW());";
        return self::executeNonQuery($sqlstr, ["usercod" => $usercod, "rolescod" => $rolescod]);
    }

    public static function actualizarEstado($usercod, $rolescod, $estado)
    {
        $sqlstr = "UPDATE roles_usuarios
                   SET roleuserest = :estado
                   WHERE usercod = :usercod
                     AND rolescod = :rolescod;";
        return self::executeNonQuery(
            $sqlstr,
            [
                "estado" => $estado,
                "usercod" => $usercod,
                "rolescod" => $rolescod
            ]
        );
    }
}