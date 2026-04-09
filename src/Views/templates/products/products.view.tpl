<style>
/* Estilos modernos y premium replicados del Home */
.catalog-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    background-color: #f7f9fa;
}
.catalog-header {
    background: #232f3e;
    color: white;
    padding: 20px 20px;
    border-radius: 8px;
    margin: 20px 0 30px;
    font-size: 1.6rem;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    text-align: center;
}
.products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 25px;
}
.product-card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    position: relative;
    overflow: hidden;
    cursor: pointer;
    border: 1px solid #eaeaea;
}
.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 28px rgba(0,0,0,0.12);
}
.product-img-wrapper {
    width: 100%;
    height: 240px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
    background: transparent;
}
.product-img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
    mix-blend-mode: multiply;
}
.product-card:hover .product-img {
    transform: scale(1.08); /* Slight zoom on hover */
}
.product-title {
    font-size: 1.1rem;
    font-weight: 600;
    color: #111;
    margin: 0 0 8px;
    line-height: 1.4;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    height: 48px;
}
.product-title:hover {
    color: #007bff;
}
.product-rating {
    color: #f39c12;
    font-size: 16px;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
    gap: 6px;
}
.rating-count {
    color: #7f8c8d;
    font-size: 13px;
}
.product-price {
    font-size: 1.8rem;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 8px;
    display: flex;
    align-items: flex-start;
}
.price-symbol {
    font-size: 1rem;
    margin-top: 5px;
    margin-right: 4px;
    color: #7f8c8d;
}
.product-desc {
    font-size: 13.5px;
    color: #7f8c8d;
    margin-bottom: 15px;
    flex-grow: 1;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
    line-height: 1.5;
}
.btn-primary-custom {
    background-color: #f1c40f;
    border: 1px solid #f39c12;
    color: #111;
    text-align: center;
    padding: 12px;
    border-radius: 30px;
    text-decoration: none;
    font-size: 1rem;
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    width: 100%;
    box-sizing: border-box;
    transition: all 0.2s ease;
    cursor: pointer;
    box-shadow: 0 4px 6px rgba(241, 196, 15, 0.2);
}
.btn-primary-custom:hover {
    background-color: #f39c12;
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(243, 156, 18, 0.3);
}
.prime-badge {
    color: #2980b9;
    font-weight: bold;
    font-size: 14px;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 5px;
}
.stock-status {
    color: #27ae60;
    font-size: 13px;
    margin-bottom: 15px;
    font-weight: 600;
}
</style>

<div class="catalog-container">
    <div class="catalog-header">
        <h1><i class="fas fa-boxes"></i> Catálogo de Productos Completo</h1>
    </div>

    <div class="products-grid">
        {{foreach products}}
        <div class="product-card" onclick="window.location.href='index.php?page=Products_ProductoController&action=verDetalle&id={{productId}}'">
            <div class="product-img-wrapper">
                <img src="{{~BASE_DIR}}/public/imgs/products/{{productImgUrl}}" alt="{{productName}}" class="product-img" onerror="this.src='{{~BASE_DIR}}/public/imgs/products/carrito.png';">
            </div>
            
            <h3 class="product-title">{{productName}}</h3>
            
            <div class="product-rating">
                &#9733;&#9733;&#9733;&#9733;&#9733; <span class="rating-count">(+150 Comentarios)</span>
            </div>
            
            <div class="product-price">
                <span class="price-symbol">L.</span>{{productPrice}}
            </div>
            
            <div class="prime-badge">
                <i class="fas fa-check-circle"></i> Suministro <span style="color: #f39c12;">Premium</span>
            </div>
            
            <p class="product-desc">{{productDescription}}</p>
            
            <div class="stock-status">
                <i class="fas fa-box-open"></i> En Stock Disponible
            </div>
            
            <form action="index.php?page=Checkout_Checkout&action=add" method="POST" style="margin:0; padding:0; width: 100%;" onclick="event.stopPropagation();">
                <input type="hidden" name="productId" value="{{productId}}">
                <button type="submit" class="btn-primary-custom">
                     Agregar al carrito
                </button>
            </form>
        </div>
        {{endfor products}}
    </div>
</div>