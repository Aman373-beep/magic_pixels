import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_pixels/Image%20Generation/Human_Text.dart';
import 'package:magic_pixels/Speech%20Image%20Generation/Speech_To_Text_To_Image.dart';
import 'package:magic_pixels/Speech%20Recognition/Speech_to_Text.dart';

class Origin extends StatefulWidget {
  const Origin({super.key});

  @override
  State<Origin> createState() => _OriginState();
}

class _OriginState extends State<Origin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OriginHome()
    );
  }
}

class OriginHome extends StatefulWidget {
  const OriginHome({super.key});

  @override
  State<OriginHome> createState() => _OriginHomeState();
}

class _OriginHomeState extends State<OriginHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            'Magic Pixels',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return HomePage();
                    })));
                  },
                  child: Container(
                    height: 90,
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Text',
                          style: GoogleFonts.anton(
                              fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          'to',
                          style: GoogleFonts.anton(
                              fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          'Image',
                          style: GoogleFonts.anton(
                              fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange),
                  ),
                ),
                GestureDetector(
                     onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return MyApp();
                    })));
                  },
                  child: Container(
                    height: 90,
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Speech',
                          style: GoogleFonts.anton(
                              fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          'Recognition',
                          style: GoogleFonts.anton(
                              fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                   
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return HomeLand();
                      })));
                    ;
                  },
                  child: Container(
                    height: 90,
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          'Speech',
                          style: GoogleFonts.anton(
                              fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          'to',
                          style: GoogleFonts.anton(
                              fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          'Image',
                          style: GoogleFonts.anton(
                              fontSize: 14, color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange),
                  ),
                )
              ],
            )
          ],
        ),
      );
  }
}