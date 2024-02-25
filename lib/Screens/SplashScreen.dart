import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:magic_pixels/Screens/HomePage.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Splash2());
  }
}

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Origin())));
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: Center(
          child: Container(height: 300,width: 300,color: Colors.white,child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          Text(
            'Magic',
            style: GoogleFonts.nunito(
                fontSize: 55, color: Colors.deepOrangeAccent, fontWeight: FontWeight.w500),
          ),
          Text(
            '     Pixels',
            style: GoogleFonts.nunito(
                fontSize: 55, color: Colors.deepOrangeAccent, fontWeight: FontWeight.w500),
          ),
        ],
      ),)),
    );
  }
}
