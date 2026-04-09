<section class="container-m row px-4 py-4">
    <h1>{{modo_desc}}</h1>
</section>

<section class="container-m row px-4 py-4">
    <div class="form-container">
        {{if error}}
        <div class="alert alert-danger">
            {{error}}
        </div>
        {{endif error}}

        <form action="index.php?page=Products_ProductoController&action={{if mode.INS}}crearProducto{{endif mode.INS}}{{if mode.UPD}}editarProducto&id={{producto.productId}}{{endif mode.UPD}}{{if mode.DEL}}eliminarProducto&id={{producto.productId}}{{endif mode.DEL}}" method="POST">
            
            <div class="form-group row">
                <label for="productId" class="col-12 col-m-3">Módelo ID (Automático)</label>
                <div class="col-12 col-m-9">
                    <input type="text" id="productId" name="productId" value="{{producto.productId}}" readonly class="form-control">
                </div>
            </div>

            <div class="form-group row">
                <label for="productName" class="col-12 col-m-3">Nombre del Producto *</label>
                <div class="col-12 col-m-9">
                    <input type="text" id="productName" name="productName" value="{{producto.productName}}" {{readonly}} class="form-control" placeholder="Ej: Café de Palo Alta Calidad" required>
                </div>
            </div>

            <div class="form-group row">
                <label for="productPrice" class="col-12 col-m-3">Precio (Lempiras) *</label>
                <div class="col-12 col-m-9">
                    <input type="number" step="0.01" id="productPrice" name="productPrice" value="{{producto.productPrice}}" {{readonly}} class="form-control" required>
                </div>
            </div>

            <div class="form-group row">
                <label for="productStock" class="col-12 col-m-3">Cantidad en Stock</label>
                <div class="col-12 col-m-9">
                    <input type="number" id="productStock" name="productStock" value="{{producto.productStock}}" {{readonly}} class="form-control">
                </div>
            </div>

            <div class="form-group row">
                <label for="productImgUrl" class="col-12 col-m-3">URL de la Imagen</label>
                <div class="col-12 col-m-9">
                    <input type="text" id="productImgUrl" name="productImgUrl" value="{{producto.productImgUrl}}" {{readonly}} class="form-control" placeholder="Ej: /public/imgs/products/cafe.png">
                </div>
            </div>

            <div class="form-group row">
                <label for="categoryId" class="col-12 col-m-3">Categoría ID</label>
                <div class="col-12 col-m-9">
                    <input type="number" id="categoryId" name="categoryId" value="{{producto.categoryId}}" {{readonly}} class="form-control">
                </div>
            </div>

            <div class="form-group row">
                <label for="productStatus" class="col-12 col-m-3">Estado</label>
                <div class="col-12 col-m-9">
                    <select id="productStatus" name="productStatus" {{readonly}} class="form-control">
                        <option value="ACT" {{if producto.productStatus_ACT}}selected{{endif producto.productStatus_ACT}}>Activo (ACT)</option>
                        <option value="INA" {{if producto.productStatus_INA}}selected{{endif producto.productStatus_INA}}>Inactivo (INA)</option>
                    </select>
                </div>
            </div>

            <div class="form-group row">
                <label for="productDescription" class="col-12 col-m-3">Descripción</label>
                <div class="col-12 col-m-9">
                    <textarea id="productDescription" name="productDescription" {{readonly}} class="form-control" rows="4">{{producto.productDescription}}</textarea>
                </div>
            </div>

            <div class="form-group row mt-4">
                <div class="col-12 d-flex justify-between">
                    <a href="index.php?page=Products_ProductoController&action=mantenimiento" class="btn btn-secondary">Cancelar</a>
                    {{if showBtn}}
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    {{endif showBtn}}
                </div>
            </div>
        </form>
    </div>
</section>

<style>
.form-container {
    background: #fff;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
}
.form-group {
    margin-bottom: 1.5rem;
    align-items: center;
}
.form-control {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1rem;
    /* In case of read-only style */
}
.form-control[readonly] {
    background-color: #f1f2f6;
    color: #777;
}
.alert {
    padding: 1rem;
    margin-bottom: 1.5rem;
    border-radius: 5px;
    color: #fff;
}
.alert-danger {
    background-color: #e74c3c;
}
.mt-4 { margin-top: 2rem; }
.d-flex { display: flex; }
.justify-between { justify-content: space-between; }
.btn { text-decoration: none; padding: 0.75rem 1.5rem; border-radius: 5px; font-weight: bold; color: #fff; display: inline-block; cursor: pointer; border:none; font-size:1rem;}
.btn-primary { background: #3498db; }
.btn-primary:hover { background: #2980b9; }
.btn-secondary { background: #95a5a6; }
.btn-secondary:hover { background: #7f8c8d; }
</style>
