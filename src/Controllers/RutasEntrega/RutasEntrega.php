<?php

namespace Controllers\RutasEntrega;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\RutasEntrega\RutasEntrega as RutasEntregaDAO;

class RutasEntrega extends PrivateController
{
    public function run(): void
    {
        $viewData = [];
        $resultado = RutasEntregaDAO::getRutasEntrega();
        $viewData["rutas"] = $resultado["rutas"];
        Renderer::render("rutasentrega/rutasentrega", $viewData);
    }
}
