<?php

namespace Dao\Roles;

use Dao\Table;

class FuncionesRol extends Table
{
    public static function obtenerRoles()
    {
        $sqlstr = "SELECT
                        rolescod,
                        rolesdsc,
                        rolesest
                   FROM roles;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerFunciones()
    {
        $sqlstr = "SELECT
                        fncod,
                        fndsc,
                        fnest,
                        fntyp
                   FROM funciones;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerRelaciones()
    {
        $sqlstr = "SELECT
                        fr.rolescod,
                        fr.fncod,
                        fr.fnrolest,
                        fr.fnexp,
                        r.rolesdsc,
                        f.fndsc
                   FROM funciones_roles fr
                   INNER JOIN roles r
                        ON fr.rolescod = r.rolescod
                   INNER JOIN funciones f
                        ON fr.fncod = f.fncod;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerRelacion(string $rolescod, string $fncod)
    {
        $sqlstr = "SELECT
                        rolescod,
                        fncod,
                        fnrolest,
                        fnexp
                   FROM funciones_roles
                   WHERE rolescod = :rolescod
                     AND fncod = :fncod;";
        return self::obtenerUnRegistro($sqlstr, [
            "rolescod" => $rolescod,
            "fncod" => $fncod
        ]);
    }

    public static function insertar(string $rolescod, string $fncod)
    {
        $sqlstr = "INSERT INTO funciones_roles
                        (rolescod, fncod, fnrolest)
                   VALUES
                        (:rolescod, :fncod, 'ACT');";
        return self::executeNonQuery($sqlstr, [
            "rolescod" => $rolescod,
            "fncod" => $fncod
        ]);
    }

    public static function activar(string $rolescod, string $fncod)
    {
        $sqlstr = "UPDATE funciones_roles
                   SET fnrolest = 'ACT'
                   WHERE rolescod = :rolescod
                     AND fncod = :fncod;";
        return self::executeNonQuery($sqlstr, [
            "rolescod" => $rolescod,
            "fncod" => $fncod
        ]);
    }

    public static function desactivar(string $rolescod, string $fncod)
    {
        $sqlstr = "UPDATE funciones_roles
                   SET fnrolest = 'INA'
                   WHERE rolescod = :rolescod
                     AND fncod = :fncod;";
        return self::executeNonQuery($sqlstr, [
            "rolescod" => $rolescod,
            "fncod" => $fncod
        ]);
    }
}