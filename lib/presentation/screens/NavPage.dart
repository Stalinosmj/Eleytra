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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
            'https://lottie.host/acdb42dc-9774-41fd-bc69-d79cea3ba395/D63X5RQ0mV.json',
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}