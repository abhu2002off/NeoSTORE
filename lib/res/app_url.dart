class AppUrl {
  static var baseURL = "http://staging.php-dev.in:8844/trainingapp/api/";

  static var loginEndPoint = baseURL + 'users/login';

  static var registerEndPoint = baseURL + 'users/register';

  static var productEndPoint = baseURL + 'products/getList';

  static var productDetailEndPoint = baseURL + "products/getDetail";

  static var productRatingEndPoint = baseURL + "products/setRating";

  static var productincartEndPoint = baseURL + "addToCart";

  static var cartitemslistEndPoint = baseURL + "cart";

  static var deleteproductEndPoint = baseURL + "deleteCart";
}
