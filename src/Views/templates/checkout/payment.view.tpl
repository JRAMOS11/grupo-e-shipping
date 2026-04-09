<div class="checkout-container">
    <div class="checkout-header">
        <h2>Pasarela de Pago</h2>
    </div>

    <!-- Product Summary -->
    <div class="payment-section" style="margin-top: 0; margin-bottom: 2rem;">
        <h3 style="margin-top: 0; color: #333;"><i class="fas fa-shopping-basket"></i> Resumen de Compra</h3>
        <table class="checkout-table" style="margin-bottom: 1rem;">
            <thead>
                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th style="text-align: right;">Subtotal</th>
                </tr>
            </thead>
            <tbody>
                {{foreach cart}}
                <tr>
                    <td data-label="Producto">
                        <div class="product-info">
                            <span class="product-name">{{productName}}</span>
                        </div>
                    </td>
                    <td data-label="Cantidad">{{crrctd}}</td>
                    <td data-label="Subtotal" class="price-col" style="text-align: right;">L. {{lineTotal}}</td>
                </tr>
                {{endfor cart}}
            </tbody>
        </table>
        <div class="total-row" style="text-align: right; margin-bottom: 0;">
            Cobro Total: <span>L. {{total}}</span>
        </div>
    </div>

    <!-- Payment Setup -->
    <div class="payment-section">
        <h3 style="margin-top: 0; color: #333;"><i class="fas fa-credit-card"></i> Método de Pago</h3>
        <p>Seleccione cómo desea facturar y pagar su pedido:</p>
        
        <form action="index.php?page=Checkout_Checkout&action=pay" method="post" id="formPago">
            <div style="display: flex; gap: 2rem; margin-bottom: 1.5rem; flex-wrap: wrap;">
                <label style="cursor: pointer; background: #fff; padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="radio" name="metodoPago" value="tarjeta" onclick="togglePaymentMethod()" checked>
                    💳 Tarjeta de Crédito/Débito
                </label>
                <label style="cursor: pointer; background: #fff; padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="radio" name="metodoPago" value="efectivo" onclick="togglePaymentMethod()">
                    💵 Efectivo (Pagar al Recibir)
                </label>
            </div>

            <!-- FORMA DE TARJETA -->
            <div id="section-tarjeta" style="display: block;">
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <div class="form-group" style="flex:1; min-width: 250px;">
                        <label>Nombre del Titular de la Tarjeta</label>
                        <input type="text" name="cc_nombre" id="cc_nombre" placeholder="Ej. Juan Perez" required>
                    </div>
                    <div class="form-group" style="flex:1; min-width: 250px;">
                        <label>Número de Tarjeta</label>
                        <input type="text" name="cc_numero" id="cc_numero" placeholder="Ej. 4000 1234 5678 9010" required>
                    </div>
                </div>
                
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <div class="form-group" style="flex:1; min-width: 150px;">
                        <label>Fecha Venc. (MM/AA)</label>
                        <input style="width: auto;" type="text" name="cc_venc" id="cc_venc" placeholder="12/26" required>
                    </div>
                    <div class="form-group" style="flex:1; min-width: 150px;">
                        <label>CVV</label>
                        <input style="width: auto;" type="text" name="cc_cvv" id="cc_cvv" placeholder="123" required>
                    </div>
                </div>
                
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <div class="form-group" style="flex:1; min-width: 250px;">
                        <label>Correo Electrónico</label>
                        <input type="email" name="cc_email" id="cc_email" placeholder="correo@ejemplo.com" required>
                    </div>
                    <div class="form-group" style="flex:1; min-width: 250px;">
                        <label>Número de Teléfono</label>
                        <input type="tel" name="cc_telefono" id="cc_telefono" placeholder="Ej. +504 9999-9999" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Lugar de Entrega Local</label>
                    <input type="text" name="cc_direccion" id="cc_direccion" placeholder="Dirección exacta para la entrega del paquete" required>
                </div>
            </div>

            <!-- FORMA DE EFECTIVO -->
            <div id="section-efectivo" style="display: none;">
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <div class="form-group" style="flex:1; min-width: 250px;">
                        <label>Nombre Completo del Cliente</label>
                        <input type="text" name="ef_nombre" id="ef_nombre" placeholder="Ej. Juan Perez">
                    </div>
                    <div class="form-group" style="flex:1; min-width: 250px;">
                        <label>Número de Teléfono</label>
                        <input type="tel" name="ef_telefono" id="ef_telefono" placeholder="Ej. +504 9999-9999">
                    </div>
                </div>

                <div class="form-group">
                    <label>Dirección Exacta de Entrega (Requerido)</label>
                    <input type="text" name="ef_direccion" id="ef_direccion" placeholder="Ej. Col. Centro, Bloque 4, Casa 12">
                </div>
            </div>

            <div class="checkout-footer" style="flex-direction: row; justify-content: space-between; align-items: center; margin-top: 2rem; border-top: 2px solid #eee; padding-top: 2rem; flex-wrap: wrap; gap: 1rem;">
                <a href="index.php?page=Checkout_Checkout" onmouseover="this.style.opacity='0.8'" onmouseout="this.style.opacity='1'" style="background: #17a2b8; color: white; padding: 1rem 2rem; border-radius: 8px; text-decoration: none; font-size: 1.2rem; font-weight: bold; box-shadow: 0 4px 10px rgba(23, 162, 184, 0.3); display: flex; align-items: center; gap: 10px; transition: all 0.3s ease;">
                    <i class="fas fa-arrow-left"></i> Volver al Carrito
                </a>
                <button type="submit" class="btn-pay" onmouseover="this.style.opacity='0.8'" onmouseout="this.style.opacity='1'" style="border: none; cursor: pointer; display: flex; align-items: center; gap: 10px; font-size: 1.2rem; padding: 1rem 3rem; transition: all 0.3s ease;">
                    <i class="fas fa-lock"></i> Finalizar y Pagar Orden
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function togglePaymentMethod() {
        try {
            var metodos = document.getElementsByName('metodoPago');
            var method = 'tarjeta';
            for (var i = 0; i < metodos.length; i++) {
                if (metodos[i].checked) {
                    method = metodos[i].value;
                }
            }
            
            var secTarjeta = document.getElementById('section-tarjeta');
            var secEfectivo = document.getElementById('section-efectivo');
            
            if (method === 'tarjeta') {
                secTarjeta.style.display = 'block';
                secEfectivo.style.display = 'none';
                
                document.getElementById('cc_nombre').required = true;
                document.getElementById('cc_numero').required = true;
                document.getElementById('cc_venc').required = true;
                document.getElementById('cc_cvv').required = true;
                document.getElementById('cc_email').required = true;
                document.getElementById('cc_telefono').required = true;
                document.getElementById('cc_direccion').required = true;
                
                document.getElementById('ef_nombre').required = false;
                document.getElementById('ef_telefono').required = false;
                document.getElementById('ef_direccion').required = false;
            } else {
                secTarjeta.style.display = 'none';
                secEfectivo.style.display = 'block';
                
                document.getElementById('ef_nombre').required = true;
                document.getElementById('ef_telefono').required = true;
                document.getElementById('ef_direccion').required = true;
                
                document.getElementById('cc_nombre').required = false;
                document.getElementById('cc_numero').required = false;
                document.getElementById('cc_venc').required = false;
                document.getElementById('cc_cvv').required = false;
                document.getElementById('cc_email').required = false;
                document.getElementById('cc_telefono').required = false;
                document.getElementById('cc_direccion').required = false;
            }
        } catch (e) {
            console.log("Error hiding/showing: ", e);
        }
    }
    window.onload = togglePaymentMethod;
</script>
