import 'package:flutter/material.dart';
import 'package:magic_pixels/API/API.dart';
import 'package:magic_pixels/Screens/HomePage.dart';
import 'package:magic_pixels/Image%20Generation/Text_to_Image.dart';
import 'package:provider/provider.dart';
import 'package:gallery_saver_plus/files.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  final text = TextEditingController();
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Origin();
                  }));
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 21,color: Colors.white,
                ),
              ),
        title: Text(
          'Magic Pixels',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the Text for Image',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(height: 10,),
            Container(
              height: 48,
              width: w / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white38),
              child: TextFormField(
                controller: text,
                decoration: InputDecoration(
                    hintText: 'Enter your text.....', border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 26.5,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                text_to_image(val: text.text)));
                  });
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.deepOrange,
                  ),
                  child: Center(
                    child: Text(
                      'Send',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
