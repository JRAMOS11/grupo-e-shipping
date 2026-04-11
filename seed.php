<?php
session_start();

$servername = "127.0.0.1";
$username = "root";
$password = "";
$dbname = "sunzena_shipping"; 

try {
    $conn = new PDO("mysql:host=$servername;dbname=sunzena_shipping", $username, $password);
} catch (PDOException $e) {
    try {
        $conn = new PDO("mysql:host=$servername;dbname=sunzena_shipping", $username, $password);
    } catch(PDOException $e2) {
        
    }
}

// Forma segura: inyectando mediante MVC local de utilidades:
require_once "vendor/autoload.php";
require_once "src/Dao/Table.php";

class DBSeed extends \Dao\Table {
    public static function clearAndSeed() {
        try {
            // Eliminar y reiniciar
            self::executeNonQuery("DELETE FROM products;", []);
            self::executeNonQuery("ALTER TABLE products AUTO_INCREMENT = 1;", []);

            $sql = "INSERT INTO products (categoryId, productName, productDescription, productImgUrl, productPrice, productStock, productStatus) VALUES 
            (1, 'Café de Palo', 'Café tradicional hondureño de grano seleccionado, tostado y molido. Aroma fuerte y sabor exquisito, 1lb.', 'cafe_palo.jpg', 120.00, 50, 'ACT'),
            (1, 'Café Copán', 'Café de las altas montañas de Copán, notas achocolatadas y cuerpo intenso, 1lb.', 'cafe_copan.jpg', 145.50, 30, 'ACT'),
            (1, 'Café Marcala Premium', 'Reconocido café de Marcala con denominación de origen. Tueste medio, acidez brillante, 1lb.', 'cafe_marcala.jpg', 180.00, 25, 'ACT'),
            (1, 'Rosquillas de Sabanagrande', 'Deliciosas rosquillas crujientes hechas de maíz y cuajada, ideales para el café de la tarde. Bolsa de 12 unidades.', 'rosquillas_sabanagrande.jpg', 60.00, 100, 'ACT'),
            (1, 'Tustacas Tradicionales', 'Tustacas hondureñas tradicionales, rellenas de dulce de rapadura y queso. Sabor auténtico de los pueblos.', 'tustacas.jpg', 65.00, 80, 'ACT'),
            (1, 'Alfeñiques Hondureños', 'Dulces tradicionales de forma trenzada a base de dulce de rapadura y en algunas regiones limón/jengibre.', 'alfeniques.jpg', 35.00, 150, 'ACT'),
            (1, 'Tabletas de Leche', 'Exquisitas tabletas de leche artesanales hondureñas, cocidas a fuego lento hasta alcanzar su cremosidad tradicional.', 'tabletas_leche.jpg', 85.00, 40, 'ACT'),
            (1, 'Tajadas de Plátano Fritas', 'Tajadas de plátano verde hondureñas fritas y crujientes, el snack perfecto tradicional y originario del corazón.', 'tajadas_platano.jpg', 25.00, 200, 'ACT'),
            (1, 'Artesanía Lenca - Vasija', 'Hermosa vasija decorativa de barro elaborada a mano con patrones tradicionales por artesanos Lencas de La Campa, Lempira.', 'artesania_lenca.jpg', 450.00, 10, 'ACT'),
            (1, 'Hamaca de Hilo Colorida', 'Hamaca grande tejida a mano con hilos de algodón en colores vivos, resistente y sumamente cómoda. Totalmente hecha en Honduras.', 'hamaca_hilo.jpg', 600.00, 15, 'ACT'),
            (1, 'Sombrero de Junco', 'Sombrero tradicional hondureño elaborado con fibra natural de junco originario del hermoso departamento de Santa Bárbara.', 'sombrero_junco.jpg', 250.00, 20, 'ACT'),
            (1, 'Camiseta Selección Honduras', 'Camiseta réplica oficial de la selección nacional de fútbol de Honduras, blanca y azul con la H en el pecho. Talla L.', 'camiseta_honduras.jpg', 950.00, 50, 'ACT'),
            (1, 'Frijoles Rojos Volteados', 'Auténticos frijoles colorados hondureños refritos, empacados listos para disfrutar con unas baleadas o plátanos machucados.', 'frijoles_volteados.jpg', 45.00, 300, 'ACT'),
            (1, 'Queso Semiseco Artesanal', 'Bloque de queso semiseco blanco hondureño salado, perfecto para combinar con frijoles o desayunos típicos completos.', 'queso_semiseco.jpg', 160.00, 40, 'ACT'),
            (1, 'Mantequilla Crema Rica', 'Auténtica mantequilla crema hondureña (sour cream), espesa e ideal para sus frijoles parados. Presentación de 1 litro.', 'mantequilla_crema.jpg', 110.00, 20, 'ACT'),
            (1, 'El Buen Café (Exclusivo)', 'Variedad de diseño visual de café cultivado y cosechado puramente de nuestras mejores laderas protegidas, tostado perfecto.', 'honduran_coffee_1775611678799.png', 170.00, 25, 'ACT'),
            (1, 'Combo Rosquillas Olanchonas', 'Combo artesanal de roquillas ilustradas 100% elaboradas con insumos lácteos de campo.', 'honduran_rosquillas_1775611692772.png', 90.00, 40, 'ACT'),
            (1, 'Artesanía Mágica Lenca', 'Decoración rústica de artesanía que resalta la belleza del suroriente de nuestro país hondureño, perfecto regalar a un extranjero.', 'honduran_artesania_1775611745291.png', 380.00, 8, 'ACT'),
            (1, 'Carrito Miniatura Sorpresa', 'Sorpresa y miniatura del carrito oficial de la tienda como un souvenir físico coleccionable para agradecerte.', 'carrito.png', 50.00, 100, 'ACT');";
            
            self::executeNonQuery($sql, []);
            echo "<h1>¡Ajuste Exitoso: 19 Productos Físicos Insertados a la Base de Datos!</h1>";
            echo "<br/><a href='index.php'>Regresar al sitio</a>";
        } catch (\Exception $e) {
            echo "Error de DB: " . $e->getMessage();
        }
    }
}
try {
    DBSeed::clearAndSeed();
} catch (\Throwable $th) {
    echo "Asegurese de que parameters.env este configurado.<br>";
    echo $th->getMessage();
}
?>
