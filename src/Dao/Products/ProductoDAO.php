<?php

namespace Dao\Products;

use Dao\Table;

class ProductoDAO extends Table
{
    public static function obtenerTodos()
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
        FROM products;";

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerPorId(int $id)
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
        WHERE productId = :id;";

        return self::obtenerUnRegistro($sqlstr, ["id" => $id]);
    }

    public static function insertar(array $producto)
    {
        $sqlstr = "INSERT INTO products (
            categoryId,
            productName,
            productDescription,
            productImgUrl,
            productPrice,
            productStock,
            productStatus
        ) VALUES (
            :categoryId,
            :productName,
            :productDescription,
            :productImgUrl,
            :productPrice,
            :productStock,
            :productStatus
        );";

        return self::executeNonQuery($sqlstr, $producto);
    }

    public static function actualizar(array $producto)
    {
        $sqlstr = "UPDATE products SET
            categoryId = :categoryId,
            productName = :productName,
            productDescription = :productDescription,
            productImgUrl = :productImgUrl,
            productPrice = :productPrice,
            productStock = :productStock,
            productStatus = :productStatus
        WHERE productId = :productId;";

        return self::executeNonQuery($sqlstr, $producto);
    }

    public static function eliminar(int $id)
    {
        // En muchos sistemas es mejor cambiar el estado a 'INA' en vez de hacer un borrado físico,
        // pero la instrucción pedía `eliminar`, lo haremos físico.
        $sqlstr = "DELETE FROM products WHERE productId = :id;";
        return self::executeNonQuery($sqlstr, ["id" => $id]);
    }
}
?>
