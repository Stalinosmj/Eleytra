import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';



class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPage();
}

class _NavPage extends State<NavPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Builder(builder: (context){
                  final
                }),
              )
            ],
          )
        ]
      ),
    )
  }
}
