import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:eleytra/presentation/screens/NavPage.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 0),
          end: const Offset(1, 1),
        ),
      ],
    ),
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).lineColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Your Car',
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Model Tesla X',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    )
                  ],
                ),
              ),
              Image.asset(
                'assets/images/ev_car.png',
                width: MediaQuery.sizeOf(context).width,
                height: 240,
                fit: BoxFit.fitWidth,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: LinearPercentIndicator(
                  percent: 0.4,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  lineHeight: 24,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: FlutterFlowTheme.of(context).primary,
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                  barRadius: const Radius.circular(40),
                  padding: EdgeInsets.zero,

                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Text(
                            'Charge',
                            style: FlutterFlowTheme.of(context).bodySmall,
                          ),
                        ),
                        Text(
                          '70%',
                          style: FlutterFlowTheme.of(context).displaySmall,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Text(
                            'Range',
                            style: FlutterFlowTheme.of(context).bodySmall,
                          ),
                        ),
                        Text(
                          '329m',
                          style: FlutterFlowTheme.of(context).displaySmall,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Text(
                            'Status',
                            style: FlutterFlowTheme.of(context).bodySmall,
                          ),
                        ),
                        Text(
                          'Good',
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0x9A090F13),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x43000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/Logo.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fleet Assistant',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.getFont(
                                    'Lexend Deca',
                                    color: const Color(0xB3FFFFFF),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '4:30pm',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.getFont(
                                    'Lexend Deca',
                                    color: const Color(0xB3FFFFFF),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Battery is in need of charging.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1/2,
                      height: 170,
                      decoration:  BoxDecoration(
                        color: FlutterFlowTheme.of(context).accent2,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x39000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          FFButtonWidget(
                            onPressed: () {
                              print('Button Pressed....');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const NavPage()),
                              );
                            },
                            text: 'Find Charger',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                                const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                              ),
                              elevation: 3,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              hoverColor: const Color(0xFF7C8126),
                            ),
                          ),
                          Lottie.network(
                            'https://lottie.host/2b30b098-96db-40c3-b70b-6953e080623c/hZrTEQtjay.json',
                            width: 150,
                            height: 25,
                            fit: BoxFit.cover,
                            animate: true,
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB((0), 16, 0, 0),
                            child: Text(
                            '',
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
