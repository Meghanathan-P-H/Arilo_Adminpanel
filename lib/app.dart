import 'package:arilo_admin/routes/app_routes.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/media_query.dart';
import 'package:arilo_admin/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    AppSize.init(context);
    return GetMaterialApp(
      title: 'Arilo_Admin',
      themeMode: ThemeMode.light,
      theme: AriloAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      getPages: AriloAppRoute.pages,
      initialRoute: AriloRoute.login,
      unknownRoute: GetPage(name: '/page-not-found', page: ()=> const Scaffold(body: Center(child: Text('Page Not Found'),),)),
    );
  }
}