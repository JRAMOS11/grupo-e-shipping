<style>
.detalle-wrap {
    max-width: 800px;
    margin: 2.5rem auto;
    padding: 0 1.5rem;
}
.detalle-wrap h2 {
    font-size: 1.7rem;
    color: #1a1a2e;
    margin-bottom: 0.4rem;
}
.detalle-card {
    background: #fff;
    border-radius: 14px;
    box-shadow: 0 2px 14px rgba(0,0,0,0.07);
    overflow: hidden;
    margin-top: 1.5rem;
}
.detalle-card table {
    width: 100%;
    border-collapse: collapse;
}
.detalle-card thead tr {
    background: #1a1a2e;
    color: #fff;
}
.detalle-card th {
    padding: 0.9rem 1.2rem;
    text-align: left;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}
.detalle-card td {
    padding: 0.85rem 1.2rem;
    border-bottom: 1px solid #f0f0f0;
    vertical-align: middle;
}
.detalle-card tbody tr:last-child td { border-bottom: none; }
.detalle-card tbody tr:hover { background: #f8faff; }

.prod-thumb {
    width: 48px;
    height: 48px;
    object-fit: cover;
    border-radius: 8px;
    margin-right: 0.7rem;
    vertical-align: middle;
}

.total-row-det {
    text-align: right;
    padding: 1.2rem 1.5rem;
    font-size: 1.2rem;
    font-weight: 700;
    color: #e63946;
    background: #fafafa;
    border-top: 2px solid #eee;
}
</style>

<div class="detalle-wrap">
    <h2><i class="fas fa-file-invoice"></i> Detalle de la Orden #{{ordencod}}</h2>
    <p style="color:#6c757d; font-size:0.95rem;">Productos incluidos en esta compra.</p>

    <div class="detalle-card">
        <table>
            <thead>
                <tr>
                    <th>Producto</th>
                    <th style="text-align:center;">Cantidad</th>
                    <th style="text-align:right;">Precio Unit.</th>
                    <th style="text-align:right;">Subtotal</th>
                </tr>
            </thead>
            <tbody>
                {{foreach detalle}}
                <tr>
                    <td>
                        <img class="prod-thumb" src="{{~BASE_DIR}}/public/imgs/products/{{productImgUrl}}" alt="img">
                        <strong>{{productName}}</strong>
                    </td>
                    <td style="text-align:center;">{{ordetcantidad}}</td>
                    <td style="text-align:right;">L. {{ordetprecio}}</td>
                    <td style="text-align:right; font-weight:600;">L. {{ordettotal}}</td>
                </tr>
                {{endfor detalle}}
            </tbody>
        </table>
        <div class="total-row-det">
            Total Pagado: L. {{subtotal}}
        </div>
    </div>

    <div style="margin-top:2rem; display:flex; gap:1rem; flex-wrap:wrap;">
        <a href="index.php?page=Transacciones_Historial"
           style="background:#17a2b8; color:#fff; padding:0.7rem 1.8rem; border-radius:8px; text-decoration:none; font-weight:600;">
            <i class="fas fa-arrow-left"></i> Volver al Historial
        </a>
        <a href="index.php?page=HomeController"
           style="background:#6c757d; color:#fff; padding:0.7rem 1.8rem; border-radius:8px; text-decoration:none; font-weight:600;">
            <i class="fas fa-store"></i> Ir a la Tienda
        </a>
    </div>
</div>
