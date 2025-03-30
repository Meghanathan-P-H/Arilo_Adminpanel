import 'package:arilo_admin/common/widgets/layouts/headers/headers.dart';
import 'package:arilo_admin/common/widgets/layouts/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(),
      body: Row(
        children: [
          Expanded(child: AriloSideBar()),
          Expanded(
            child: Column(
              children: [
                //header
                AriloHeader(),

                body ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
