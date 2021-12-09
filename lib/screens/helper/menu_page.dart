import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuPage extends StatelessWidget {
  final ZoomDrawerController drawerController;
  const MenuPage({Key? key, required this.drawerController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          backgroundColor: const Color(0xff78909c),
          body: Container(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuItem(context, Icons.home, "Home", "/"),
                    menuItem(context, Icons.shop, "Shop", "/shop"),
                    menuItem(context, Icons.shopping_bag, "Shopping Bag",
                        "/shopping-bag"),
                    menuItem(context, Icons.info, "About Us", "/"),
                  ]),
            ),
          )),
    );
  }

  Widget menuItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      selected: ModalRoute.of(context)!.settings.name == route,
      minLeadingWidth: 20,
      leading: Icon(icon),
      title: Text(title),
      onTap: () async {
        // final _receivePort = ReceivePort();
        // await Isolate.spawn(drawerController.toggle!(), _receivePort.sendPort);
        // await Future.doWhile(() => drawerController.isOpen!());
        // drawerController.toggle!();
        await Future(drawerController.toggle! as dynamic).then((value) {
          Navigator.of(context).pushNamed(route);
        });
      },
    );
  }
}