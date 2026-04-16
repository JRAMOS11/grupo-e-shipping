<section class="container-m row px-4 py-4">
    <h1>{{modeDsc}}</h1>
</section>

<section class="container-m row px-4 py-4">
    <form action="index.php?page=RutasEntrega-RutaEntrega&mode={{mode}}&id_ruta={{id_ruta}}" method="POST" class="col-12 col-m-8 offset-m-2">
        
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="id_ruta">Código</label>
            <input class="col-12 col-m-9" type="text" name="id_ruta_show" id="id_ruta" value="{{id_ruta}}" readonly disabled />
            <input type="hidden" name="id_ruta" value="{{id_ruta}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="origen">Origen</label>
            <input class="col-12 col-m-9" {{readonly}} type="text" name="origen" id="origen" value="{{origen}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="destino">Destino</label>
            <input class="col-12 col-m-9" {{readonlydes}} type="text" name="destino" id="destino" value="{{destino}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="distancia_km">Distancia KM</label>
            <input class="col-12 col-m-9" {{readonly}} type="number" step="0.01" name="distancia_km" id="distancia_km" value="{{distancia_km}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="duracion_min">Duración Min</label>
            <input class="col-12 col-m-9" {{readonly}} type="number" name="duracion_min" id="duracion_min" value="{{duracion_min}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="rutaest">Estado</label>
            <select class="col-12 col-m-9" name="rutaest" id="rutaest" {{readonly}}>
                <option value="ACT" {{if isACT}}selected{{endif isACT}}>Activo</option>
                <option value="FIN" {{if isFIN}}selected{{endif isFIN}}>Finalizada</option>
                <option value="PEN" {{if isPEN}}selected{{endif isPEN}}>Pendiente</option>
            </select>
        </div>

        <div class="row my-4 align-center flex-end">
            {{if showCommitBtn}}
            <button class="primary col-12 col-m-2" type="submit" name="btnConfirmar">Confirmar</button>
            &nbsp;
            {{endif showCommitBtn}}
            <button class="col-12 col-m-2" type="button" id="btnCancelar">
                {{if showCommitBtn}}
                Cancelar
                {{endif showCommitBtn}}
                {{ifnot showCommitBtn}}
                Regresar
                {{endifnot showCommitBtn}}
            </button>
        </div>
    </form>
</section>

<script>
document.addEventListener("DOMContentLoaded", ()=>{
    const btnCancelar = document.getElementById("btnCancelar");
    btnCancelar.addEventListener("click", (e)=>{
        e.preventDefault();
        e.stopPropagation();
        window.location.assign("index.php?page=RutasEntrega-RutasEntrega");
    });
});
</script>