class AriloRoute {
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brand = '/brand';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const banner = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const product = '/product';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

  static List sidebarMenuItems = [dashboard, media, categories,brand,product];
}
