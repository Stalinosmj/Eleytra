import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:lottie/lottie.dart';



class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  _MyNavPage createState() => _MyNavPage();
}

class _MyNavPage extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Loading...',
          style: FlutterFlowTheme.of(context)
          .bodyLarge
          .override(
          fontFamily: 'Outfit',
          color: FlutterFlowTheme.of(context)
              .alternate,
          ),
        ),
        Lottie.network(
          'https://lottie.host/4c6105e6-f01f-493c-a859-83db18c457af/UrC9pKBVXX.json',
          fit: BoxFit.fill,
        )
      ],
    );
  }
}