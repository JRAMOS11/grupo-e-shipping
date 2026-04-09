<?php

namespace Dao\Products;

use Dao\Table;

class Products extends Table
{
    public static function getProducts()
    {
        $sqlstr = "SELECT
            productId,
            categoryId,
            productName,
            productDescription,
            productImgUrl,
            productPrice,
            productStock,
            productStatus
        FROM products
        WHERE productStatus = 'ACT';";

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getProductById(int $productId)
    {
        $sqlstr = "SELECT
            productId,
            categoryId,
            productName,
            productDescription,
            productImgUrl,
            productPrice,
            productStock,
            productStatus
        FROM products
        WHERE productId = :productId;";

        return self::obtenerUnRegistro($sqlstr, [
            "productId" => $productId
        ]);
    }

    public static function getDailyDeals()
    {
        $sqlstr = "SELECT
            productId,
            categoryId,
            productName,
            productDescription,
            productImgUrl,
            productPrice,
            productStock,
            productStatus
        FROM products
        WHERE productStatus = 'ACT'
        LIMIT 7 OFFSET 0;";

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getFeaturedProducts()
    {
        $sqlstr = "SELECT
            productId,
            categoryId,
            productName,
            productDescription,
            productImgUrl,
            productPrice,
            productStock,
            productStatus
        FROM products
        WHERE productStatus = 'ACT'
        LIMIT 6 OFFSET 7;";

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getNewProducts()
    {
        $sqlstr = "SELECT
            productId,
            categoryId,
            productName,
            productDescription,
            productImgUrl,
            productPrice,
            productStock,
            productStatus
        FROM products
        WHERE productStatus = 'ACT'
        ORDER BY productId DESC
        LIMIT 6 OFFSET 13;";

        return self::obtenerRegistros($sqlstr, []);
    }
}
?>