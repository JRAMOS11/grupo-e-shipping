<section class="container-m row px-4 py-4">
    <h1>Catálogo de Productos</h1>
</section>

<section class="container-m row px-4 py-4">
    {{foreach products}}
    <div class="col-12 col-m-4 col-l-3 px-2 py-2">
        <div class="card">
            <img src="{{productImgUrl}}" alt="{{productName}}" style="width:100%; height:200px; object-fit:cover;">
            <div class="px-2 py-2">
                <h3>{{productName}}</h3>
                <p>{{productDescription}}</p>
                <p><strong>Precio:</strong> L. {{productPrice}}</p>
                <p><strong>Stock:</strong> {{productStock}}</p>

                <a href="index.php?page=Checkout_Checkout&action=add&productId={{productId}}">
                    Agregar al carrito
                </a>
            </div>
        </div>
    </div>
    {{endfor products}}
</section>