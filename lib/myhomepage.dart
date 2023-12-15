import 'package:flutter/material.dart' ;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent, // This sets the background color
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 391,
                  height: 694,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children:[
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bg_map.png'),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Transform.scale(
                          scale: 0.8, // Adjust this value to change the size of the image
                          child: Container(
                            width: 252,
                            height: 245,
                            padding: const EdgeInsets.fromLTRB(100,100, 0,100),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/ev_car.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}