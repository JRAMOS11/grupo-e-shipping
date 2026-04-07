<h2>Carretilla de Compra</h2>

{{if checkout_msg}}
<p><strong>{{checkout_msg}}</strong></p>
{{endif checkout_msg}}

<table>
    <tr>
        <th>Producto</th>
        <th>Precio</th>
        <th>Cantidad</th>
        <th>Total Línea</th>
        <th>Acciones</th>
    </tr>

    {{foreach cart}}
    <tr>
        <td>{{productName}}</td>
        <td>{{crrprc}}</td>
        <td>
            <form action="index.php?page=Checkout_Checkout&action=update" method="post">
                <input type="hidden" name="productId" value="{{productId}}">
                <input type="number" name="cantidad" value="{{crrctd}}" min="1">
                <button type="submit">Actualizar</button>
            </form>
        </td>
        <td>{{lineTotal}}</td>
        <td>
            <a href="index.php?page=Checkout_Checkout&action=remove&productId={{productId}}">
                Quitar
            </a>
        </td>
    </tr>
    {{endfor cart}}
</table>

<h3>Total: L. {{total}}</h3>

<a href="index.php?page=Checkout_Checkout&action=pay">Pagar</a>