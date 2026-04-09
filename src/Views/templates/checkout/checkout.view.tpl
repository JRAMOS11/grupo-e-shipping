<div class="checkout-container">
    <div class="checkout-header">
        <h2>🛍️ Mi Carrito de Compras</h2>
    </div>

    {{if checkout_msg}}
    <div class="alert-success">
        ✔️ {{checkout_msg}}
    </div>
    {{endif checkout_msg}}

    <table class="checkout-table">
        <thead>
            <tr>
                <th>Producto</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Subtotal</th>
                <th style="text-align: right;">Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach cart}}
            <tr>
                <td data-label="Producto">
                    <div class="product-info">
                        <img src="{{~BASE_DIR}}/public/imgs/products/{{productImgUrl}}" alt="Img" style="width: 50px; height: 50px; border-radius: 8px; object-fit: cover;">
                        <span class="product-name">{{productName}}</span>
                    </div>
                </td>
                <td data-label="Precio" class="price-col">L. {{crrprc}}</td>
                <td data-label="Cantidad">
                    <form class="qty-form" action="index.php?page=Checkout_Checkout&action=update" method="post">
                        <input type="hidden" name="productId" value="{{productId}}">
                        <input type="number" class="qty-input" name="cantidad" value="{{crrctd}}" min="1">
                        <button class="btn-update" type="submit">Actualizar</button>
                    </form>
                </td>
                <td data-label="Subtotal" class="price-col">L. {{lineTotal}}</td>
                <td data-label="Acciones" style="text-align: right;">
                    <a class="btn-remove" href="index.php?page=Checkout_Checkout&action=remove&productId={{productId}}">
                        <i class="fas fa-trash"></i> Quitar
                    </a>
                </td>
            </tr>
            {{endfor cart}}
        </tbody>
    </table>

    <div class="checkout-footer">
        <div class="total-row" style="margin-bottom: 2rem;">
            Total General: <span>L. {{total}}</span>
        </div>
        <div style="display:flex; gap: 1.5rem; flex-wrap: wrap; justify-content: flex-end; width: 100%;">
            <a href="index.php?page=HomeController" onmouseover="this.style.opacity='0.8'" onmouseout="this.style.opacity='1'" style="background: #6c757d; color: white; padding: 1rem 2.5rem; border-radius: 8px; text-decoration: none; font-size: 1.2rem; font-weight: bold; box-shadow: 0 4px 10px rgba(108, 117, 125, 0.3); display: flex; align-items: center; gap: 10px; transition: all 0.3s ease;">
                <i class="fas fa-store"></i> Seguir Comprando
            </a>
            {{if cart}}
                <a class="btn-pay" href="index.php?page=Checkout_Checkout&action=payment_form" style="display: flex; align-items: center; gap: 10px;">
                    Proceder al Pago <i class="fas fa-arrow-right"></i>
                </a>
            {{endif cart}}
        </div>
    </div>
</div>