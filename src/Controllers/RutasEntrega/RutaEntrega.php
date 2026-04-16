<?php

namespace Controllers\RutasEntrega;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\RutasEntrega\RutasEntrega as RutasEntregaDAO;
use Utilities\Site;

class RutaEntrega extends PrivateController
{
    private array $viewData = [];
    private array $modes = [
        "INS" => "Nueva Ruta de Entrega",
        "UPD" => "Actualizar Ruta %s",
        "DSP" => "Detalle de Ruta %s",
        "DEL" => "Eliminar Ruta %s"
    ];

    private int $id_ruta = 0;
    private string $origen = "";
    private string $destino = "";
    private float $distancia_km = 0;
    private int $duracion_min = 0;
    private string $mode = "DSP";
    private string $rutaest = "ACT";

    public function run(): void
    {
        $this->loadPage();

        if ($this->isPostBack()) {
            $this->captureData();

            switch ($this->mode) {
                case "INS":
                    if (RutasEntregaDAO::insertRutaEntrega(
                        $this->origen,
                        $this->destino,
                        $this->distancia_km,
                        $this->duracion_min
                    ) > 0) {
                        Site::redirectToWithMsg("index.php?page=RutasEntrega-RutasEntrega", "Ruta creada satisfactoriamente");
                    }
                    break;

                case "UPD":
                    if (RutasEntregaDAO::updateRutaEntrega(
                        $this->id_ruta,
                        $this->origen,
                        $this->destino,
                        $this->distancia_km,
                        $this->duracion_min,
                        $this->rutaest
                    ) > 0) {
                        Site::redirectToWithMsg("index.php?page=RutasEntrega-RutasEntrega", "Ruta actualizada satisfactoriamente");
                    }
                    break;

                case "DEL":
                    if (RutasEntregaDAO::deleteRutaEntrega($this->id_ruta) > 0) {
                        Site::redirectToWithMsg("index.php?page=RutasEntrega-RutasEntrega", "Ruta eliminada satisfactoriamente");
                    }
                    break;
            }
        }

        $this->prepareViewData();
        Renderer::render("rutasentrega/rutaentrega", $this->viewData);
    }

    private function loadPage()
    {
        $this->mode = $_GET["mode"] ?? "DSP";
        $this->id_ruta = intval($_GET["id_ruta"] ?? 0);

        if (!isset($this->modes[$this->mode])) {
            Site::redirectToWithMsg("index.php?page=RutasEntrega-RutasEntrega", "Modo no válido");
        }

        if ($this->mode != "INS" && $this->id_ruta > 0) {
            $tmpRuta = RutasEntregaDAO::getRutaEntregaById($this->id_ruta);
            if ($tmpRuta) {
                $this->origen = $tmpRuta["origen"];
                $this->destino = $tmpRuta["destino"];
                $this->distancia_km = floatval($tmpRuta["distancia_km"]);
                $this->duracion_min = intval($tmpRuta["duracion_min"]);
                $this->rutaest = $tmpRuta["rutaest"];
            }
        }
    }

    private function captureData()
    {
        $this->id_ruta = intval($_POST["id_ruta"] ?? 0);
        $this->origen = strval($_POST["origen"] ?? "");
        $this->destino = strval($_POST["destino"] ?? "");
        $this->distancia_km = floatval($_POST["distancia_km"] ?? 0);
        $this->duracion_min = intval($_POST["duracion_min"] ?? 0);
        $this->rutaest = strval($_POST["rutaest"] ?? "ACT");
    }

    private function prepareViewData()
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["modeDsc"] = sprintf($this->modes[$this->mode], $this->id_ruta);
        $this->viewData["id_ruta"] = $this->id_ruta;
        $this->viewData["origen"] = $this->origen;
        $this->viewData["destino"] = $this->destino;
        $this->viewData["distancia_km"] = $this->distancia_km;
        $this->viewData["duracion_min"] = $this->duracion_min;
        $this->viewData["readonly"] = ($this->mode == "DSP" || $this->mode == "DEL") ? "readonly disabled" : "";
        $this->viewData["readonlydes"] = ($this->mode == "DSP" || $this->mode == "DEL" || $this->mode == "UPD") ? "readonly disabled" : "";
        $this->viewData["showCommitBtn"] = ($this->mode != "DSP");
        $this->viewData["rutaest"] = $this->rutaest;
        $this->viewData["isACT"] = $this->rutaest === "ACT";
        $this->viewData["isFIN"] = $this->rutaest === "FIN";
        $this->viewData["isPEN"] = $this->rutaest === "PEN";
    }
}
