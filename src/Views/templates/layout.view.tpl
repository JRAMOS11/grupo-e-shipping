<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{BASE_DIR}}/public/css/appstyle.css" />
  <script src="https://kit.fontawesome.com/{{FONT_AWESOME_KIT}}.js" crossorigin="anonymous"></script>
  {{foreach SiteLinks}}
    <link rel="stylesheet" href="{{~BASE_DIR}}/{{this}}" />
  {{endfor SiteLinks}}
  {{foreach BeginScripts}}
    <script src="{{~BASE_DIR}}/{{this}}"></script>
  {{endfor BeginScripts}}
  <style>
    .floating-cart {
        position: fixed;
        bottom: 30px;
        right: 30px;
        background: #28a745;
        color: white;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        z-index: 1000;
        transition: transform 0.3s;
    }
    .floating-cart:hover {
        transform: scale(1.1);
    }
    .floating-cart img {
        width: 28px !important;
        height: 28px !important;
        filter: invert(1);
    }
  </style>
</head>
<body>
  <header>
    <input type="checkbox" class="menu_toggle" id="menu_toggle" />
    <label for="menu_toggle" class="menu_toggle_icon" >
      <div class="hmb dgn pt-1"></div>
      <div class="hmb hrz"></div>
      <div class="hmb dgn pt-2"></div>
    </label>
    <h1>{{SITE_TITLE}}</h1>
    <nav id="menu">
      <ul>
        <li><a href="index.php?page={{PUBLIC_DEFAULT_CONTROLLER}}"><i class="fas fa-home"></i>&nbsp;Inicio</a></li>
        <li><a href="index.php?page=Checkout_Checkout"><img src="{{~BASE_DIR}}/public/imgs/products/carrito.png" alt="Cart" style="height: 18px; vertical-align: text-bottom; margin-right: 4px; filter: invert(1);"> Carrito</a></li>
        {{foreach PUBLIC_NAVIGATION}}
            <li><a href="{{nav_url}}">{{nav_label}}</a></li>
        {{endfor PUBLIC_NAVIGATION}}
      </ul>
    </nav>
  </header>
  <main>
  {{{page_content}}}
  </main>
  <footer>
    <div>Todo los Derechos Reservados {{~CURRENT_YEAR}} &copy;</div>
  </footer>
  {{foreach EndScripts}}
    <script src="{{~BASE_DIR}}/{{this}}"></script>
  {{endfor EndScripts}}
  
  <a href="index.php?page=Checkout_Checkout" class="floating-cart">
      <img src="{{~BASE_DIR}}/public/imgs/products/carrito.png" alt="Ver Carrito">
  </a>
</body>
</html>
