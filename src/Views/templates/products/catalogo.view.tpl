<style>
/* Amazon-style Premium Catalog CSS */
body {
    background-color: #eaeded; /* Amazon background grey */
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
}
.catalog-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px;
}
.catalog-header {
    background: #232f3e; /* Dark Amazon header color */
    color: white;
    padding: 35px 20px;
    text-align: center;
    border-radius: 8px;
    margin-bottom: 30px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
.catalog-logo {
    max-height: 90px;
    margin-bottom: 20px;
    background-color: white; /* Contrast for the logo */
    padding: 10px 20px;
    border-radius: 6px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}
.catalog-header h1 {
    margin: 0;
    font-size: 2.2rem;
    font-weight: 500;
}
.catalog-header p {
    margin: 10px 0 0;
    color: #e6e6e6;
    font-size: 1.1rem;
}
.products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 25px;
}
.product-card {
    background: white;
    border-radius: 10px;
    padding: 20px;
    display: flex;
    flex-direction: column;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    position: relative;
    overflow: hidden;
    cursor: pointer;
    border: 1px solid #f0f2f2;
}
.product-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}
.product-img-wrapper {
    width: 100%;
    height: 240px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
    background: #ffffff;
}
.product-img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
}
.product-card:hover .product-img {
    transform: scale(1.05); /* Slight zoom on hover */
}
.product-title {
    font-size: 16px;
    font-weight: 400;
    color: #0f1111;
    margin: 0 0 8px;
    line-height: 1.4;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    height: 44px; /* Ensure 2 lines */
}
.product-title:hover {
    color: #c45500;
}
.product-rating {
    color: #ffa41c;
    font-size: 16px;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 6px;
}
.rating-count {
    color: #007185;
    font-size: 13px;
}
.product-price {
    font-size: 28px;
    font-weight: 500;
    color: #0f1111;
    margin-bottom: 8px;
    display: flex;
    align-items: flex-start;
}
.price-symbol {
    font-size: 14px;
    margin-top: 5px;
    margin-right: 3px;
}
.product-desc {
    font-size: 13.5px;
    color: #565959;
    margin-bottom: 15px;
    flex-grow: 1;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
    line-height: 1.5;
}
.btn-primary-custom {
    background-color: #ffd814;
    border-color: #fcd200;
    color: #0f1111;
    text-align: center;
    padding: 12px;
    border-radius: 100px; /* Pill shape like Amazon */
    text-decoration: none;
    font-size: 15px;
    display: block;
    width: 100%;
    box-sizing: border-box;
    transition: background-color 0.2s, box-shadow 0.2s;
    box-shadow: 0 2px 5px 0 rgba(213,217,217,.5);
}
.btn-primary-custom:hover {
    background-color: #f7ca00;
    border-color: #f2c200;
    color: #0f1111;
    text-decoration: none;
}
.prime-badge {
    color: #00a8e1;
    font-weight: bold;
    font-style: italic;
    font-size: 14px;
    margin-bottom: 12px;
}
.stock-status {
    color: #007600;
    font-size: 13px;
    margin-bottom: 15px;
    font-weight: 500;
}
</style>

<div class="catalog-container">
    <div class="catalog-header">
        <img src="public/imgs/logo.png" alt="Sunzena Shipping Logo" class="catalog-logo" onerror="this.style.display='none'">
        <h1>Catálogo de Productos</h1>
        <p>Los mejores productos nostálgicos hondureños, entregados con calidad Premium.</p>
    </div>

    <div class="products-grid">
        {{foreach productos}}
        <div class="product-card" onclick="window.location.href='index.php?page=Products_ProductoController&action=verDetalle&id={{productId}}'">
            <div class="product-img-wrapper">
                <img src="public/imgs/products/{{productImgUrl}}" alt="{{productName}}" class="product-img" onerror="this.src='{{productImgUrl}}'; this.onerror=null;">
            </div>
            
            <h3 class="product-title">{{productName}}</h3>
            
            <div class="product-rating">
                &#9733;&#9733;&#9733;&#9733;&#9734; <span class="rating-count">(+100)</span>
            </div>
            
            <div class="product-price">
                <span class="price-symbol">L.</span>
                {{productPrice}}
            </div>
            
            <div class="prime-badge">
                &#10003; Sunzena <span style="color: #f90;">Premium</span>
            </div>
            
            <p class="product-desc">{{productDescription}}</p>
            
            <div class="stock-status">
                En Stock ({{productStock}})
            </div>
            
            <a href="index.php?page=Products_ProductoController&action=verDetalle&id={{productId}}" class="btn-primary-custom" onclick="event.stopPropagation();">
                Agregar al carrito
            </a>
        </div>
        {{endfor productos}}
    </div>
</div>
