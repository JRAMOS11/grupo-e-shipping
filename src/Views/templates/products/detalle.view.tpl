<style>
/* Premium Detail CSS */
.detail-bg {
    background: #fdfdfd;
    min-height: 100vh;
    padding: 3rem 1rem;
}
.detail-container {
    max-width: 1000px;
    margin: 0 auto;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    display: flex;
    flex-wrap: wrap;
    overflow: hidden;
}
.detail-image-section {
    flex: 1 1 50%;
    min-width: 300px;
    background: #f4f4f4;
    display: flex;
    align-items: center;
    justify-content: center;
}
.detail-image-section img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    max-height: 500px;
}
.detail-info-section {
    flex: 1 1 50%;
    padding: 3rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
}
.detail-title {
    font-size: 2.2rem;
    color: #333;
    margin-bottom: 1rem;
    font-weight: 700;
}
.detail-price {
    font-size: 2rem;
    color: #e74c3c;
    font-weight: bold;
    margin-bottom: 1.5rem;
}
.detail-status {
    display: inline-block;
    padding: 5px 15px;
    border-radius: 20px;
    background: #e8f5e9;
    color: #2e7d32;
    font-size: 0.85rem;
    font-weight: bold;
    margin-bottom: 1.5rem;
}
.detail-description {
    font-size: 1.1rem;
    line-height: 1.6;
    color: #555;
    margin-bottom: 2rem;
}
.detail-actions {
    display: flex;
    gap: 1rem;
}
.btn-buy {
    background: linear-gradient(135deg, #27ae60, #2ecc71);
    color: white;
    padding: 1rem 2rem;
    border-radius: 30px;
    font-size: 1.1rem;
    font-weight: bold;
    text-decoration: none;
    border: none;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(46, 204, 113, 0.4);
    transition: all 0.3s ease;
    text-align: center;
    flex-grow: 1;
}
.btn-buy:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 20px rgba(46, 204, 113, 0.6);
    color: #fff;
    text-decoration: none;
}
.btn-back {
    background: #f1f2f6;
    color: #333;
    padding: 1rem 2rem;
    border-radius: 30px;
    font-size: 1.1rem;
    font-weight: bold;
    text-decoration: none;
    text-align: center;
    transition: all 0.3s ease;
}
.btn-back:hover {
    background: #dfe4ea;
    color: #000;
    text-decoration: none;
}
</style>

<div class="detail-bg">
    {{with producto}}
    <div class="detail-container">
        <div class="detail-image-section">
            <img src="public/imgs/products/{{productImgUrl}}" alt="{{productName}}" onerror="this.src='{{productImgUrl}}'; this.onerror=null;" style="mix-blend-mode: multiply;">
        </div>
        <div class="detail-info-section">
            <span class="detail-status">Stock Disponible: {{productStock}}</span>
            <h1 class="detail-title">{{productName}}</h1>
            <div class="detail-price">L. {{productPrice}}</div>
            <p class="detail-description">
                {{productDescription}}
            </p>
            <div class="detail-actions">
                <a href="index.php?page=Products_ProductoController&action=listarProductos" class="btn-back">Regresar</a>
                <a href="index.php?page=Checkout_Checkout&action=add&productId={{productId}}" class="btn-buy">
                    <i class="fas fa-shopping-cart"></i> Agregar al Carrito
                </a>
            </div>
        </div>
    </div>
    {{endwith producto}}
</div>
