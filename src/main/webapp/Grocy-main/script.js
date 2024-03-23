let searchForm=document.querySelector('.search-form');
document.querySelector('#search-btn').onclick=()=>{
    searchForm.classList.toggle('active');
    Menu.classList.remove('active');
    ShoppingCart.classList.remove('active');
    Login.classList.remove('active');
}
let ShoppingCart=document.querySelector('.shopping-cart');
document.querySelector('#cart-btn').onclick=()=>{
    ShoppingCart.classList.toggle('active');
    Menu.classList.remove('active');
    searchForm.classList.remove('active');
    Login.classList.remove('active');
}
function redirectToLogin() {
  // Specify the URL of the login page you want to redirect to
  const loginPageUrl = 'http://localhost:8080/GroceryStore/index.html';

  // Redirect the user to the login page
  window.location.href = loginPageUrl;
}
let Menu=document.querySelector('.navbar');
document.querySelector('#menu-btn').onclick=()=>{
    Menu.classList.toggle('active');
    searchForm.classList.remove('active');
    ShoppingCart.classList.remove('active');
    Login.classList.remove('active');
}
window.onscroll=()=>{
    Menu.classList.remove('active');
    searchForm.classList.remove('active');
    ShoppingCart.classList.remove('active');
    Login.classList.remove('active');
}


var swiper = new Swiper(".product-slider", {
  loop:true,
  spaceBetween: 20,
  breakpoints: {
    0: {
      slidesPerView: 1,

    },
    750: {
      slidesPerView: 2,
    },
    1024: {
      slidesPerView: 3,
    },
  },
});