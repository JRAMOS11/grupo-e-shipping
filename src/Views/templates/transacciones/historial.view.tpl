<style>
/* ── Historial de Transacciones ───────────────────────────── */
.historial-wrap {
    max-width: 1100px;
    margin: 2.5rem auto;
    padding: 0 1.5rem;
}
.historial-wrap h2 {
    font-size: 1.9rem;
    margin-bottom: 0.4rem;
    color: #1a1a2e;
}
.historial-wrap .subtitle {
    color: #6c757d;
    margin-bottom: 2rem;
    font-size: 0.95rem;
}

/* Tarjetas de resumen */
.resumen-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1.2rem;
    margin-bottom: 2.5rem;
}
.resumen-card {
    background: #fff;
    border-radius: 12px;
    padding: 1.4rem 1.6rem;
    box-shadow: 0 2px 12px rgba(0,0,0,0.07);
    border-left: 4px solid #17a2b8;
    display: flex;
    flex-direction: column;
    gap: 0.3rem;
}
.resumen-card .rc-label {
    font-size: 0.8rem;
    color: #6c757d;
    text-transform: uppercase;
    letter-spacing: 0.06em;
}
.resumen-card .rc-value {
    font-size: 1.6rem;
    font-weight: 700;
    color: #1a1a2e;
}
.resumen-card.accent { border-left-color: #28a745; }
.resumen-card.accent .rc-value { color: #28a745; }

/* Tabla */
.hist-table-wrap {
    background: #fff;
    border-radius: 14px;
    box-shadow: 0 2px 14px rgba(0,0,0,0.07);
    overflow: hidden;
}
.hist-table-wrap table {
    width: 100%;
    border-collapse: collapse;
}
.hist-table-wrap thead tr {
    background: #1a1a2e;
    color: #fff;
}
.hist-table-wrap th {
    padding: 1rem 1.2rem;
    text-align: left;
    font-size: 0.85rem;
    font-weight: 600;
    letter-spacing: 0.04em;
    text-transform: uppercase;
}
.hist-table-wrap td {
    padding: 0.9rem 1.2rem;
    border-bottom: 1px solid #f0f0f0;
    font-size: 0.95rem;
    color: #333;
    vertical-align: middle;
}
.hist-table-wrap tbody tr:last-child td { border-bottom: none; }
.hist-table-wrap tbody tr:hover { background: #f8faff; }

/* Badges de estado */
.badge {
    display: inline-block;
    padding: 0.28rem 0.75rem;
    border-radius: 20px;
    font-size: 0.78rem;
    font-weight: 600;
    letter-spacing: 0.03em;
}
.status-com { background: #d4edda; color: #155724; }
.status-pen { background: #fff3cd; color: #856404; }
.status-can { background: #f8d7da; color: #721c24; }
.status-err { background: #f8d7da; color: #721c24; }

/* Botón detalle */
.btn-detalle {
    background: #17a2b8;
    color: #fff;
    padding: 0.4rem 1rem;
    border-radius: 6px;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 600;
    transition: background 0.2s;
    white-space: nowrap;
}
.btn-detalle:hover { background: #138496; }

/* Sin transacciones */
.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    color: #6c757d;
}
.empty-state i { font-size: 3.5rem; margin-bottom: 1rem; color: #ced4da; }
.empty-state p { font-size: 1.1rem; margin-bottom: 1.5rem; }

@media (max-width: 640px) {
    .hist-table-wrap th, .hist-table-wrap td { padding: 0.7rem 0.8rem; font-size: 0.85rem; }
}
</style>

<div class="historial-wrap">
    <h2><i class="fas fa-history"></i> Mi Historial de Transacciones</h2>
    <p class="subtitle">Aquí puedes consultar todas tus compras realizadas.</p>

    <!-- Resumen estadístico -->
    {{if resumen}}
    <div class="resumen-grid">
        <div class="resumen-card">
            <span class="rc-label">Total de Compras</span>
            <span class="rc-value">{{resumen.total_compras}}</span>
        </div>
        <div class="resumen-card accent">
            <span class="rc-label">Total Gastado</span>
            <span class="rc-value">L. {{resumen.total_gastado}}</span>
        </div>
        <div class="resumen-card">
            <span class="rc-label">Promedio por Compra</span>
            <span class="rc-value">L. {{resumen.promedio_compra}}</span>
        </div>
        <div class="resumen-card">
            <span class="rc-label">Última Compra</span>
            <span class="rc-value" style="font-size:1rem;">{{resumen.ultima_compra}}</span>
        </div>
    </div>
    {{endif resumen}}

    <!-- Tabla de transacciones -->
    {{if historial}}
    <div class="hist-table-wrap">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Fecha</th>
                    <th>Orden</th>
                    <th>Método de Pago</th>
                    <th>Referencia</th>
                    <th style="text-align:right;">Monto</th>
                    <th style="text-align:center;">Estado</th>
                    <th style="text-align:center;">Detalle</th>
                </tr>
            </thead>
            <tbody>
                {{foreach historial}}
                <tr>
                    <td><strong>#{{transcod}}</strong></td>
                    <td>{{transfching}}</td>
                    <td>Orden {{ordencod}}</td>
                    <td>{{method_label}}</td>
                    <td style="color:#999; font-size:0.85rem;">{{transreference}}</td>
                    <td style="text-align:right; font-weight:700; color:#e63946;">L. {{transamount}}</td>
                    <td style="text-align:center;">
                        <span class="badge {{status_class}}">{{status_label}}</span>
                    </td>
                    <td style="text-align:center;">
                        <a class="btn-detalle" href="index.php?page=Transacciones_Historial&action=detalle&ordencod={{ordencod}}">
                            <i class="fas fa-eye"></i> Ver
                        </a>
                    </td>
                </tr>
                {{endfor historial}}
            </tbody>
        </table>
    </div>

    {{else}}
    <div class="empty-state">
        <i class="fas fa-receipt"></i>
        <p>Todavía no tienes transacciones registradas.</p>
        <a href="index.php?page=HomeController" style="background:#28a745; color:#fff; padding:0.8rem 2rem; border-radius:8px; text-decoration:none; font-weight:bold;">
            <i class="fas fa-store"></i> Ir a la Tienda
        </a>
    </div>
    {{endif historial}}

    <div style="margin-top: 2rem;">
        <a href="index.php?page=HomeController" style="color:#17a2b8; text-decoration:none; font-size:0.95rem;">
            <i class="fas fa-arrow-left"></i> Volver al inicio
        </a>
    </div>
</div>
