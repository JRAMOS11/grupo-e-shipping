<?php

namespace Dao\RutasEntrega;

use Dao\Table;

class RutasEntrega extends Table
{
    public static function getRutasEntrega(
        string $partialName = "",
        string $status = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT 
            r.id_ruta,
            r.origen,
            r.destino,
            r.distancia_km,
            r.duracion_min,
            r.rutaest
        FROM rutasentrega r";

        $sqlstrCount = "SELECT COUNT(*) as count FROM rutasentrega r";

        $conditions = [];
        $params = [];

        if ($partialName != "") {
            $conditions[] = "(r.origen LIKE :partialName OR r.destino LIKE :partialName)";
            $params["partialName"] = "%" . $partialName . "%";
        }

        if (count($conditions) > 0) {
            $sqlstr .= " WHERE " . implode(" AND ", $conditions);
            $sqlstrCount .= " WHERE " . implode(" AND ", $conditions);
        }

        $validOrderBy = ["id_ruta", "origen", "destino", "distancia_km", "duracion_min"];
        if (!in_array($orderBy, $validOrderBy) && $orderBy != "") {
            throw new \Exception("Error Processing Request OrderBy has invalid value");
        }

        if ($orderBy != "") {
            $sqlstr .= " ORDER BY " . $orderBy;
            if ($orderDescending) {
                $sqlstr .= " DESC";
            }
        }

        $numeroDeRegistros = self::obtenerUnRegistro($sqlstrCount, $params)["count"];
        $pagesCount = ceil($numeroDeRegistros / $itemsPerPage);

        if ($pagesCount < 1) {
            $pagesCount = 1;
        }

        if ($page < 0) {
            $page = 0;
        }

        if ($page > $pagesCount - 1) {
            $page = $pagesCount - 1;
        }

        $sqlstr .= " LIMIT " . ($page * $itemsPerPage) . ", " . $itemsPerPage;

        $registros = self::obtenerRegistros($sqlstr, $params);

        return [
            "rutas" => $registros,
            "total" => $numeroDeRegistros,
            "page" => $page,
            "itemsPerPage" => $itemsPerPage
        ];
    }

    public static function getRutaEntregaById(int $id_ruta)
    {
        $sqlstr = "SELECT 
            r.id_ruta,
            r.origen,
            r.destino,
            r.distancia_km,
            r.duracion_min,
            r.rutaest
        FROM rutasentrega r
        WHERE r.id_ruta = :id_ruta";

        $params = ["id_ruta" => $id_ruta];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertRutaEntrega(
        string $origen,
        string $destino,
        float $distancia_km,
        int $duracion_min
    ) {
        $sqlstr = "INSERT INTO rutasentrega
            (origen, destino, distancia_km, duracion_min)
            VALUES
            (:origen, :destino, :distancia_km, :duracion_min)";

        $params = [
            "origen" => $origen,
            "destino" => $destino,
            "distancia_km" => $distancia_km,
            "duracion_min" => $duracion_min
        ];

        return self::executeNonQuery($sqlstr, $params);
    }

    public static function insertDestinoEntrega(
        string $destino
    ): int {
        $sqlstr = "INSERT INTO rutasentrega
            (origen, destino, distancia_km, duracion_min, rutaest)
            VALUES
            (:origen, :destino, :distancia_km, :duracion_min, :rutaest)";

        $params = [
            "origen" => "Por definir",
            "destino" => $destino,
            "distancia_km" => 0,
            "duracion_min" => 0,
            "rutaest" => "PEN"
        ];

        self::executeNonQuery($sqlstr, $params);
        $row = self::obtenerUnRegistro(
            "SELECT LAST_INSERT_ID() AS id_ruta;",
            []
        );
        return intval($row["id_ruta"] ?? 0);
    }


    public static function updateRutaEntrega(
        int $id_ruta,
        string $origen,
        string $destino,
        float $distancia_km,
        int $duracion_min,
        string $rutaest
    ) {
        $sqlstr = "UPDATE rutasentrega SET
            origen = :origen,
            destino = :destino,
            distancia_km = :distancia_km,
            duracion_min = :duracion_min,
            rutaest = :rutaest
        WHERE id_ruta = :id_ruta";

        $params = [
            "id_ruta" => $id_ruta,
            "origen" => $origen,
            "destino" => $destino,
            "distancia_km" => $distancia_km,
            "duracion_min" => $duracion_min,
            "rutaest" => $rutaest
        ];

        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteRutaEntrega(int $id_ruta)
    {
        $sqlstr = "DELETE FROM rutasentrega WHERE id_ruta = :id_ruta";
        $params = ["id_ruta" => $id_ruta];
        return self::executeNonQuery($sqlstr, $params);
    }
}
