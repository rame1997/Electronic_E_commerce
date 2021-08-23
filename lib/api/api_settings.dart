
mixin ApiSettings {

  static const String _API_BASE_URL = 'https://smart-store.mr-dev.tech/api/';

  static const String REGISTER = _API_BASE_URL + "auth/register";
  static const String LOGIN = _API_BASE_URL + "auth/login";
  static const String LOGOUT = _API_BASE_URL + "auth/logout";
  static const String ACTIVATE = _API_BASE_URL + "auth/activate";
  static const String FORGET = _API_BASE_URL + "auth/forget-password";
  static const String RESET = _API_BASE_URL + "auth/reset-password";
  static const String CHANGE_PASSWORD = _API_BASE_URL + "auth/change-password";
  static const String REFRESH_FCM_TOKEN = _API_BASE_URL + "auth/refresh-fcm-token";
  static const String CITY = _API_BASE_URL + "cities";
  static const String HOME = _API_BASE_URL + "home";
  static const String Categorie = _API_BASE_URL + "categories";
  static const String PRODUCT = _API_BASE_URL + "sub-categories";
  static const String PRODUCT_DETILES = _API_BASE_URL + "products";
  static const String UPDATE_PROFILE = _API_BASE_URL + "update-profile";
  static const String CONTACT_REQUESTES = _API_BASE_URL + "contact-requests";
  static const String Question = _API_BASE_URL + "faqs";
  static const String RATE = _API_BASE_URL + "products/rate";
  static const String ADD_FAVARITE_PRODUCT = _API_BASE_URL + "favorite-products";
  static const String READ_FAVARITE_PRODUCT = _API_BASE_URL + "favorite-products";
  static const String ADDRESS = _API_BASE_URL + "addresses";
  static const String PAYMENT_CARDS = _API_BASE_URL + "payment-cards";
  static const String ORDER = _API_BASE_URL + "orders";
  static const String Notifications = _API_BASE_URL + "notifications";

}