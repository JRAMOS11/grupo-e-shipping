<?php

namespace Controllers\Products;

use Controllers\PublicController;
use Dao\Products\Products as ProductsDAO;
use Views\Renderer;

class Products extends PublicController
{
    private array $viewData = [];

    public function run(): void
    {
        $this->viewData["products"] = ProductsDAO::getProducts();
        Renderer::render("products/products", $this->viewData);
    }
}
?>