<section class="container-m row px-4 py-4">
    <h1>Listado de Rutas de Entrega</h1>
</section>

<section class="container-m row px-4 py-4">
    <table class="col-12">
        <thead>
            <tr>
                <th>ID</th>
                <th>Origen</th>
                <th>Destino</th>
                <th>Distancia KM</th>
                <th>Duración Min</th>
                <th>
                    <a href="index.php?page=RutasEntrega-RutaEntrega&mode=INS&id_ruta=0">Nuevo</a>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach rutas}}
            <tr>
                <td>{{id_ruta}}</td>
                <td>{{origen}}</td>
                <td>{{destino}}</td>
                <td>{{distancia_km}}</td>
                <td>{{duracion_min}}</td>
                <td>
                    <a href="index.php?page=RutasEntrega-RutaEntrega&mode=DSP&id_ruta={{id_ruta}}">Mostrar</a>
                    &nbsp;
                    <a href="index.php?page=RutasEntrega-RutaEntrega&mode=UPD&id_ruta={{id_ruta}}">Actualizar</a>
                    &nbsp;
                    <a href="index.php?page=RutasEntrega-RutaEntrega&mode=DEL&id_ruta={{id_ruta}}">Eliminar</a>
                </td>
            </tr>
            {{endfor rutas}}
        </tbody>
    </table>
</section>