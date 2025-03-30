import 'package:arilo_admin/common/widgets/layouts/headers/headers.dart';
import 'package:arilo_admin/common/widgets/layouts/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key,this.body});

  final Widget? body;
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer:const AriloSideBar(),
      appBar: AriloHeader(scaffoldKey: scaffoldKey,),
      body: body ?? const SizedBox()
    );
  }
}