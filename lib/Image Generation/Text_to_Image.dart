import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:magic_pixels/API/API.dart';
import 'package:magic_pixels/Screens/HomePage.dart';
import 'Human_Text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class text_to_image extends StatefulWidget {
  final String val;
  text_to_image({super.key, required this.val});

  @override
  State<text_to_image> createState() => _text_to_imageState();
}

class _text_to_imageState extends State<text_to_image> {
  @override
  Uint8List? imageData;
  void initState() {
    super.initState();
    _generateImage();
  }

  Future<void> _generateImage() async {
    API api = API();
    final images = await api.imageGeneration(widget.val);
    print(images);
    setState(() {
      if (images != null) {
        imageData = images?.first as Uint8List?;
      } else {
        // Handle the case where images is null, e.g., show an error message
        imageData = Uint8List(0);
      }
    });
  }

  Future<void> _saveImage(Uint8List imageData) async {
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw Exception("Failed to access external storage");
    }

    final path = directory.path +
        "/generated_image_${DateTime.now().millisecondsSinceEpoch}.png";
    print(path);
    // Save the image to a temporary file
    final tempFile = File(path);
    await tempFile.writeAsBytes(imageData);

    try {
      // Resize the image if needed
      // Replace maxWidth and maxHeight with your desired values
      await GallerySaver.saveImage(path, albumName: "MagicPixels");

      // You can use resizedImageData for further processing if needed
      print("Image saved successfully!");
    } catch (e) {
      print("Error saving image: $e");
    }
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 21,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Magic Pixels',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              centerTitle: true,
            ),
            body: (imageData != null)
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Image.memory(imageData!, fit: BoxFit.cover),
                        SizedBox(
                          height: 22,
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (imageData != null) {
                                // Show saving indicator or feedback
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Saving image..."),
                                  ),
                                );
                                await _saveImage(imageData!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Image saved successfully!"),
                                  ),
                                );
                              }
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(17)),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator())));
  }
}
