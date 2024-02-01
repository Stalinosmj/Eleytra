import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';



class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  _MyNavPage createState() => _MyNavPage();
}

class _MyNavPage extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_bg.png'), fit: BoxFit.cover)
        ),
      );
  }
}