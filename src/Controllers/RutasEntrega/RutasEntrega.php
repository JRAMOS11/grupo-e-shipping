<?php

namespace Controllers\RutasEntrega;

use Controllers\PublicController;
use Views\Renderer;
use Dao\RutasEntrega\RutasEntrega as RutasEntregaDAO;

class RutasEntrega extends PublicController
{
    public function run(): void
    {
        $viewData = [];
        $resultado = RutasEntregaDAO::getRutasEntrega();
        $viewData["rutas"] = $resultado["rutas"];
        Renderer::render("rutasentrega/rutasentrega", $viewData);
    }
}
?>
