<!--<footer style="background-color: orange; color: #fff; padding: 20px 0;">
    <div class="container" style="display: flex; justify-content: space-between; align-items: center;">
        <div class="footer-content">
            <div class="footer-logo">
                <img src="img/logo2.png" alt="Company Logo" width="50%">
            </div>
            <div class="footer-links">
                <ul style="list-style: none; padding: 0;">
                    <li><a href="Grocy-main/index.html" style="text-decoration: none; color: solid; font-size: 25px;">Home</a></li>
                    <li><a href="products.jsp" style="text-decoration: none; color: solid; font-size: 25px;">Products</a></li>
                    <li><a href="categories.jsp" style="text-decoration: none; color: solid; font-size: 25px;">Services</a></li>
                    <li><a href="Grocy-main/index.html" style="text-decoration: none; color: solid; font-size: 25px;">Contact Us</a></li>
                </ul>
            </div>
        </div>
        <hr class="footer-divider" style="border-top: 1px solid #666; margin: 10px 0;">
        <div class="copyright" style="text-align: center;">
            <p style="font-size: 50px">&copy; 2023 Grocy. All rights reserved.</p>
        </div>
    </div>
</footer>-->

<footer class="section-p1">
<style>
footer {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    background-color: orange;
    position: relative;

}
.section-p1{

}

.col {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    margin: 30px;
}

.col p{
    color: white;
}


footer h4 {
    font-size: 14px;
    padding-bottom: 15px;

}

footer p {
    font-size: 13px;
    margin: 0 0 5px 0;
}

footer a {
    font-size: 15px;
    text-decoration: none;
    margin-bottom: 10px;
    color: white;
}

.follow {
    margin-top: 20px;
}

.follow i {
    padding-right: 4px;
    cursor: pointer;
    color: white;
}

.install .row img {
    border-radius: 6px;

}

.install img {
    margin: 10px 0 15px 0;
}

.install p {
    color: white;
}

.follow i:hover,
footer a:hover
{
    color: black;
}

.copyright {
    width: 100%;
    text-align: center;
}


</style>
  <div class="col">
    <img src="img/logo2.png" class="logo" height="100px" width="100px">
    <h4>Contact</h4>
    <p><strong>Address: </strong>Hyderabad, Indiaa</p>
    <p><strong>Phone: </strong>+91 1234567890</p>
    <p><strong>Hours: </strong>09:00-18:00, Mon-Sat</p>
    <div class="follow">
      <h4>Follow US</h4>
      <div class="icon">
        <i class="fa-brands fa-facebook"></i>
        <i class="fa-brands fa-twitter"></i>
        <i class="fa-brands fa-instagram"></i>
      </div>
    </div>
  </div>

  <div class="col">
    <h4>About</h4>
    <a href="Grocy-main/index.html">About us</a>
    <a href="Grocy-main/index.html">Contact us</a>
    <a href="Grocy-main/index.html">Privacy Policy</a>
    <a href="Grocy-main/index.html">Terms & Conditions</a>

   <h4>My Account</h4>
    <a href="index.html">Login</a>
    <a href="index.html">View Cart</a>
    <a href="index.html">My Wishlist</a>
  </div>

  <!--<div class="col">
    <h4>My Account</h4>
    <a href="${pageContext.request.contextPath}/login">Login</a>
    <a href="${pageContext.request.contextPath}/cart">View Cart</a>
    <a href="${pageContext.request.contextPath}/profile">My Wishlist</a>
    <a href="#">Help</a>
  </div>-->

  <div class="col install">
    <h4>Install App</h4>
    <p>From App Store or Google Play</p>
    <div class="row">
      <img src="img/app.jpg">
      <img src="img/play.jpg">
    </div>
    <p>Secured Payment Gateways</p>
    <img src="img/pay.png">
  </div>

  <div class="copyright">
    <p>&copy;2023, Grocy site</p>
  </div>

</footer>



