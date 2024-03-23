<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Grocy</title>
    <link rel="icon" href="images/grocy.png" type="image/x-icon" />
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
        crossorigin="anonymous"
        referrerpolicy="no-referrer"
    />
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"
    />
    <link rel="stylesheet" href="Grocy-main/style.css" />
</head>
<body>
    <header class="header">
        <a href="" class="logo"><i class="fas fa-shopping-basket"></i> Grocy</a>

        <nav class="navbar">
            <a href="products.jsp">home</a>
            <a href="order.jsp">Orders</a>
            <a href="products.jsp">products</a>
            <a href="categories.jsp">categories</a>
        </nav>
        <div class="icons">
            <div class="fas fa-bars" id="menu-btn"></div>
            <a href="products.jsp"><div class="fas fa-search" id="search-btn"></div></a>
            <a href="cart.jsp"><div class="fas fa-shopping-cart" id="cart-btn"></div></a>
            <a href="logout.jsp"><div class="fas fa-user" id="login-btn" onclick="redirectToLogin()"></div></a>
        </div>
        <form action="" class="search-form">
            <input type="text" id="search-box" placeholder="search here..." />
            <label for="search-box" class="fas fa-search"></label>
        </form>
        <div class="shopping-cart">
            
           
        </div>
    </header>
</body>
</html>




