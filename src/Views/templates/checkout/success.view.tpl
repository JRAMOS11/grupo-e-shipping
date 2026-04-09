<div class="checkout-container" style="padding: 3rem 2rem;">
    <div style="text-align: center;">
        <div style="font-size: 5rem; color: #28a745; margin-bottom: 1rem;">
            <i class="fas fa-check-circle"></i>
        </div>
        <h1 style="color: #28a745; margin-bottom: 2rem; font-size: 2.5rem;">{{checkout_msg}}</h1>
        <p style="font-size: 1.2rem; color: #555;">La orden #{{receipt_order}} ha sido recibida y confirmada.</p>
    </div>

    <!-- Factura -->
    <div class="payment-section" style="max-width: 800px; margin: 3rem auto; background: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid #eaeaea;">
        <h3 style="border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-top: 0;"><i class="fas fa-file-invoice-dollar"></i> Recibo / Factura de Pago</h3>
        
        <table style="width: 100%; margin-top: 2rem; border-collapse: collapse;">
            <thead>
                <tr style="background: #f8f9fa;">
                    <th style="padding: 1rem; text-align: left; border-bottom: 2px solid #ddd;">Producto</th>
                    <th style="padding: 1rem; text-align: center; border-bottom: 2px solid #ddd;">Cant.</th>
                    <th style="padding: 1rem; text-align: right; border-bottom: 2px solid #ddd;">Subtotal</th>
                </tr>
            </thead>
            <tbody>
                {{foreach receipt_items}}
                <tr>
                    <td style="padding: 1rem; border-bottom: 1px solid #eee;"><strong>{{productName}}</strong></td>
                    <td style="padding: 1rem; border-bottom: 1px solid #eee; text-align: center;">{{crrctd}}</td>
                    <td style="padding: 1rem; border-bottom: 1px solid #eee; text-align: right;">L. {{lineTotal}}</td>
                </tr>
                {{endfor receipt_items}}
            </tbody>
        </table>

        <div style="text-align: right; margin-top: 2rem; font-size: 1.3rem;">
            Cobro Total: <strong style="color: #e63946;">L. {{receipt_total}}</strong>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 3rem;">
        <a href="index.php?page=HomeController" onmouseover="this.style.opacity='0.8'" onmouseout="this.style.opacity='1'" style="background: #17a2b8; color: white; padding: 1rem 3rem; border-radius: 8px; text-decoration: none; font-size: 1.2rem; font-weight: bold; box-shadow: 0 4px 10px rgba(23, 162, 184, 0.3); display: inline-flex; align-items: center; gap: 10px; transition: all 0.3s ease;">
            <i class="fas fa-arrow-left"></i> Volver a los Productos para Seguir Comprando
        </a>
    </div>
</div>
