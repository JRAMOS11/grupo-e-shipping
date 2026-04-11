<section class="container-m row px-4 py-4">
    <h1>Asignación de Funciones a Roles</h1>
</section>

<section class="container-m row px-4 py-4">
    <div class="col-12 col-m-6">
        {{if mensaje}}
        <div class="alert alert-primary">
            {{mensaje}}
        </div>
        {{endif mensaje}}

        <div class="form-container">
            <form action="index.php?page=Roles_FuncionesRol" method="POST">
                <div class="form-group row">
                    <label for="rolescod" class="col-12 col-m-3">Rol</label>
                    <div class="col-12 col-m-9">
                        <select name="rolescod" id="rolescod" class="form-control" required>
                            <option value="">Seleccione un rol</option>
                            {{foreach roles}}
                            <option value="{{rolescod}}">{{rolesdsc}} ({{rolescod}})</option>
                            {{endfor roles}}
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="fncod" class="col-12 col-m-3">Función</label>
                    <div class="col-12 col-m-9">
                        <select name="fncod" id="fncod" class="form-control" required>
                            <option value="">Seleccione una función</option>
                            {{foreach funciones}}
                            <option value="{{fncod}}">{{fndsc}} ({{fncod}})</option>
                            {{endfor funciones}}
                        </select>
                    </div>
                </div>

                <div class="form-group row mt-4">
                    <div class="col-12 d-flex justify-content-between">
                        <button type="submit" name="accion" value="asignar" class="btn btn-primary">Asignar</button>
                        <button type="submit" name="accion" value="inactivar" class="btn btn-danger">Inactivar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

<section class="container-m row px-4 py-4">
    <div class="col-12">
        <h2>Relaciones Registradas</h2>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>Rol</th>
                    <th>Descripción Rol</th>
                    <th>Función</th>
                    <th>Descripción Función</th>
                    <th>Estado</th>
                    <th>Fecha Exp.</th>
                </tr>
            </thead>
            <tbody>
                {{foreach relaciones}}
                <tr>
                    <td>{{rolescod}}</td>
                    <td>{{rolesdsc}}</td>
                    <td>{{fncod}}</td>
                    <td>{{fndsc}}</td>
                    <td>{{fnrolest}}</td>
                    <td>{{fnexp}}</td>
                </tr>
                {{endfor relaciones}}
            </tbody>
        </table>
    </div>
</section>