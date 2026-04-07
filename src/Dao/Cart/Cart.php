<?php

namespace Dao\Cart;

use Dao\Table;

class Cart extends Table
{
    public static function getCartByUser(int $usercod)
    {
        $sqlstr = "SELECT 
            c.usercod,
            c.productId,
            c.crrctd,
            c.crrprc,
            p.productName,
            p.productDescription,
            p.productImgUrl,
            p.productPrice,
            (c.crrctd * c.crrprc) as lineTotal
        FROM carretilla c
        INNER JOIN products p ON c.productId = p.productId
        WHERE c.usercod = :usercod;";

        return self::obtenerRegistros($sqlstr, ["usercod" => $usercod]);
    }

    public static function getCartByAnon(string $anoncod)
    {
        $sqlstr = "SELECT 
            c.anoncod,
            c.productId,
            c.crrctd,
            c.crrprc,
            p.productName,
            p.productDescription,
            p.productImgUrl,
            p.productPrice,
            (c.crrctd * c.crrprc) as lineTotal
        FROM carretillaanon c
        INNER JOIN products p ON c.productId = p.productId
        WHERE c.anoncod = :anoncod;";

        return self::obtenerRegistros($sqlstr, ["anoncod" => $anoncod]);
    }

    public static function getCartLineByUser(int $usercod, int $productId)
    {
        $sqlstr = "SELECT * 
                   FROM carretilla
                   WHERE usercod = :usercod AND productId = :productId;";

        return self::obtenerUnRegistro($sqlstr, [
            "usercod" => $usercod,
            "productId" => $productId
        ]);
    }

    public static function getCartLineByAnon(string $anoncod, int $productId)
    {
        $sqlstr = "SELECT * 
                   FROM carretillaanon
                   WHERE anoncod = :anoncod AND productId = :productId;";

        return self::obtenerUnRegistro($sqlstr, [
            "anoncod" => $anoncod,
            "productId" => $productId
        ]);
    }

    public static function addToCartUser(int $usercod, int $productId, int $cantidad, float $precio)
    {
        $line = self::getCartLineByUser($usercod, $productId);

        if ($line) {
            $sqlstr = "UPDATE carretilla
                       SET crrctd = crrctd + :cantidad
                       WHERE usercod = :usercod AND productId = :productId;";

            return self::executeNonQuery($sqlstr, [
                "cantidad" => $cantidad,
                "usercod" => $usercod,
                "productId" => $productId
            ]);
        }

        $sqlstr = "INSERT INTO carretilla
                   (usercod, productId, crrctd, crrfching, crrprc)
                   VALUES
                   (:usercod, :productId, :crrctd, NOW(), :crrprc);";

        return self::executeNonQuery($sqlstr, [
            "usercod" => $usercod,
            "productId" => $productId,
            "crrctd" => $cantidad,
            "crrprc" => $precio
        ]);
    }

    public static function addToCartAnon(string $anoncod, int $productId, int $cantidad, float $precio)
    {
        $line = self::getCartLineByAnon($anoncod, $productId);

        if ($line) {
            $sqlstr = "UPDATE carretillaanon
                       SET crrctd = crrctd + :cantidad
                       WHERE anoncod = :anoncod AND productId = :productId;";

            return self::executeNonQuery($sqlstr, [
                "cantidad" => $cantidad,
                "anoncod" => $anoncod,
                "productId" => $productId
            ]);
        }

        $sqlstr = "INSERT INTO carretillaanon
                   (anoncod, productId, crrctd, crrfching, crrprc)
                   VALUES
                   (:anoncod, :productId, :crrctd, NOW(), :crrprc);";

        return self::executeNonQuery($sqlstr, [
            "anoncod" => $anoncod,
            "productId" => $productId,
            "crrctd" => $cantidad,
            "crrprc" => $precio
        ]);
    }

    public static function updateCartUser(int $usercod, int $productId, int $cantidad)
    {
        $sqlstr = "UPDATE carretilla
                   SET crrctd = :cantidad
                   WHERE usercod = :usercod AND productId = :productId;";

        return self::executeNonQuery($sqlstr, [
            "cantidad" => $cantidad,
            "usercod" => $usercod,
            "productId" => $productId
        ]);
    }

    public static function updateCartAnon(string $anoncod, int $productId, int $cantidad)
    {
        $sqlstr = "UPDATE carretillaanon
                   SET crrctd = :cantidad
                   WHERE anoncod = :anoncod AND productId = :productId;";

        return self::executeNonQuery($sqlstr, [
            "cantidad" => $cantidad,
            "anoncod" => $anoncod,
            "productId" => $productId
        ]);
    }

    public static function removeFromCartUser(int $usercod, int $productId)
    {
        $sqlstr = "DELETE FROM carretilla
                   WHERE usercod = :usercod AND productId = :productId;";

        return self::executeNonQuery($sqlstr, [
            "usercod" => $usercod,
            "productId" => $productId
        ]);
    }

    public static function removeFromCartAnon(string $anoncod, int $productId)
    {
        $sqlstr = "DELETE FROM carretillaanon
                   WHERE anoncod = :anoncod AND productId = :productId;";

        return self::executeNonQuery($sqlstr, [
            "anoncod" => $anoncod,
            "productId" => $productId
        ]);
    }

    public static function getCartTotalByUser(int $usercod)
    {
        $sqlstr = "SELECT IFNULL(SUM(crrctd * crrprc), 0) as total
                   FROM carretilla
                   WHERE usercod = :usercod;";

        return self::obtenerUnRegistro($sqlstr, ["usercod" => $usercod]);
    }

    public static function getCartTotalByAnon(string $anoncod)
    {
        $sqlstr = "SELECT IFNULL(SUM(crrctd * crrprc), 0) as total
                   FROM carretillaanon
                   WHERE anoncod = :anoncod;";

        return self::obtenerUnRegistro($sqlstr, ["anoncod" => $anoncod]);
    }

    public static function clearCartUser(int $usercod)
    {
        $sqlstr = "DELETE FROM carretilla WHERE usercod = :usercod;";
        return self::executeNonQuery($sqlstr, ["usercod" => $usercod]);
    }

    public static function clearCartAnon(string $anoncod)
    {
        $sqlstr = "DELETE FROM carretillaanon WHERE anoncod = :anoncod;";
        return self::executeNonQuery($sqlstr, ["anoncod" => $anoncod]);
    }
}
?>