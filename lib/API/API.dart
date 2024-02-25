import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class API with ChangeNotifier {
  final API_key = "sk-cMbfCGqKVyxriPOaJGvZj5Z2JrMHPG7sY3DbG6siWIlSkm1t";
  final Base_URL =
      "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image";

  var imagePath = '';
  var imageBytes = Uint8List(0);
  imageGeneration(String text) async {
    Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $API_key',
    };
    var _body = {
      'steps': 40,
      'width':  1024,
      'height': 1024,
      'seed': 0,
      'cfg_scale': 5,
      'samples': 1,
      'text_prompts': [
        {"text": text, "weight": 1},
      ],
    };

    try {
      final response = await http.post(
          headers: _headers, body: jsonEncode(_body), Uri.parse(Base_URL));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        final images = responseData['artifacts']
        
            .map((image) => base64Decode(image['base64']))
            .toList();
  
        notifyListeners();
        return images;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error generating image: $e");
      }
      rethrow;
    }
  }
}
