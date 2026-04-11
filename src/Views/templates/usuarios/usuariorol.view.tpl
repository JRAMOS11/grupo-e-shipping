<section class="container-m row px-4 py-4">
    <h1>Asignación de Roles a Usuarios</h1>
</section>

<section class="container-m row px-4 py-4">
    <div class="col-12 col-m-6">
        {{if mensaje}}
        <div class="alert alert-primary">
            {{mensaje}}
        </div>
        {{endif mensaje}}

        <div class="form-container">
            <form action="index.php?page=Usuarios_UsuarioRol" method="POST">
                <div class="form-group row">
                    <label for="usercod" class="col-12 col-m-3">Usuario</label>
                    <div class="col-12 col-m-9">
                        <select name="usercod" id="usercod" class="form-control" required>
                            <option value="">Seleccione un usuario</option>
                            {{foreach usuarios}}
                            <option value="{{usercod}}">{{username}} - {{useremail}}</option>
                            {{endfor usuarios}}
                        </select>
                    </div>
                </div>

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
                    <th>Usuario ID</th>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Rol</th>
                    <th>Descripción Rol</th>
                    <th>Estado</th>
                    <th>Fecha</th>
                </tr>
            </thead>
            <tbody>
                {{foreach relaciones}}
                <tr>
                    <td>{{usercod}}</td>
                    <td>{{username}}</td>
                    <td>{{useremail}}</td>
                    <td>{{rolescod}}</td>
                    <td>{{rolesdsc}}</td>
                    <td>{{roleuserest}}</td>
                    <td>{{roleuserfch}}</td>
                </tr>
                {{endfor relaciones}}
            </tbody>
        </table>
    </div>
</section>