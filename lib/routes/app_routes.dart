import 'package:arilo_admin/features/authentication/screens/login/frogot_success.dart';
import 'package:arilo_admin/features/authentication/screens/login/login.dart';
import 'package:arilo_admin/features/media/screen/media.dart';
import 'package:arilo_admin/features/shop/screens/banner/all_banners/banners.dart';
import 'package:arilo_admin/features/shop/screens/banner/create_%20banners/create_banner.dart';
import 'package:arilo_admin/features/shop/screens/banner/edit_banners/edit_banner.dart';
import 'package:arilo_admin/features/shop/screens/brand/all_brands/brand.dart';
import 'package:arilo_admin/features/shop/screens/brand/create_brand/create_brand.dart';
import 'package:arilo_admin/features/shop/screens/brand/edit_brand/edit_brand.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/categories.dart';
import 'package:arilo_admin/features/shop/screens/category/createcategories/createcategories.dart';
import 'package:arilo_admin/features/shop/screens/category/editcategories/editcategories.dart';
import 'package:arilo_admin/features/shop/screens/dashbord/dashboard.dart';
import 'package:arilo_admin/routes/route_middleware.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AriloAppRoute {
  static final List<GetPage> pages =[
    GetPage(name: AriloRoute.login, page:()=>LoginScreen()),
    GetPage(name: AriloRoute.forgotPassword, page:()=>ForgotSuccess()),
    GetPage(name: AriloRoute.dashboard, page:()=>DashboardScreen(),middlewares: [AriloRouteMiddleWare()]),   
    GetPage(name: AriloRoute.media, page:()=>MediaScreen(),middlewares: [AriloRouteMiddleWare()]), 

    GetPage(name: AriloRoute.categories, page: ()=> CategoriesScreen(),middlewares: [AriloRouteMiddleWare()]),  
    GetPage(name: AriloRoute.createCategory, page: ()=> Createcategories(),middlewares: [AriloRouteMiddleWare()]),  
    GetPage(name: AriloRoute.editCategory, page: ()=> EditCategoriesScreen(),middlewares: [AriloRouteMiddleWare()]),  

    GetPage(name: AriloRoute.brand, page: ()=> BrandScreen(),middlewares: [AriloRouteMiddleWare()]),  
    GetPage(name: AriloRoute.createBrand, page: ()=> CreateBrandScreen(),middlewares: [AriloRouteMiddleWare()]),  
    GetPage(name: AriloRoute.editBrand, page: ()=> EditBrandScreen(),middlewares: [AriloRouteMiddleWare()]),  

    GetPage(name: AriloRoute.banner, page: ()=> BannersScreen(),middlewares: [AriloRouteMiddleWare()]),  
    GetPage(name: AriloRoute.createBanner, page: ()=> CreateBannerScreen(),middlewares: [AriloRouteMiddleWare()]),  
    GetPage(name: AriloRoute.editBanner, page: ()=> EditBanner(),middlewares: [AriloRouteMiddleWare()]),  

  ];
}
