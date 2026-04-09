<section class="container-m row px-4 py-4">
    <h1>Gestión de Productos</h1>
    <div class="row my-4">
        <a href="index.php?page=Products_ProductoController&action=crearProducto" class="btn btn-primary">
            + Nuevo Producto
        </a>
    </div>

    <table class="table table-striped table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Precio (L.)</th>
                <th>Stock</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
            <tr>
                <td>{{productId}}</td>
                <td>{{productName}}</td>
                <td>{{productPrice}}</td>
                <td>{{productStock}}</td>
                <td>{{productStatus}}</td>
                <td>
                    <a href="index.php?page=Products_ProductoController&action=editarProducto&id={{productId}}" class="btn btn-secondary btn-sm">
                        Editar
                    </a>
                    <a href="index.php?page=Products_ProductoController&action=eliminarProducto&id={{productId}}" class="btn btn-danger btn-sm">
                        Eliminar
                    </a>
                </td>
            </tr>
            {{endfor productos}}
        </tbody>
    </table>
</section>
<style>
/* Basic Table styles adapted to match a clean look */
.table { width: 100%; border-collapse: collapse; background: #fff; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-radius: 8px; overflow: hidden; }
.table th, .table td { padding: 1rem; text-align: left; border-bottom: 1px solid #eaeaea; }
.table th { background: #f8f9fa; font-weight: bold; color: #333; }
.table tbody tr:hover { background: #fdfdfd; }
.btn { text-decoration: none; padding: 0.5rem 1rem; border-radius: 5px; font-weight: bold; color: #fff; display: inline-block; text-align: center; cursor: pointer; border:none; }
.btn-primary { background: #3498db; }
.btn-primary:hover { background: #2980b9; }
.btn-secondary { background: #95a5a6; }
.btn-secondary:hover { background: #7f8c8d; }
.btn-danger { background: #e74c3c; }
.btn-danger:hover { background: #c0392b; }
.btn-sm { padding: 0.25rem 0.6rem; font-size: 0.85rem; margin-right: 5px;}
.my-4 { margin: 1.5rem 0; }
</style>
