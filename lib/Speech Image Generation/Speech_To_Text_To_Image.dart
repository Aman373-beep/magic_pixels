import 'package:flutter/material.dart';
import 'package:magic_pixels/Screens/HomePage.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:clipboard/clipboard.dart';

import '../Image Generation/Text_to_Image.dart';

class HomeLand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Speech_To_Text(),
    );
  }
}

class Speech_To_Text extends StatefulWidget {
  Speech_To_Text({Key? key}) : super(key: key);

  @override
  _Speech_To_TextState createState() => _Speech_To_TextState();
}

class _Speech_To_TextState extends State<Speech_To_Text> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    print(_lastWords);
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    _controller.text = result.recognizedWords;
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  final controller = TextEditingController();
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Magic Pixel',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
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
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _speechToText.isListening
                        ? '$_lastWords'
                        : _speechEnabled
                            ? 'Tap the microphone to start listening...'
                            : 'Speech not available',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: h / 3.55,
                  ),
                  Text(
                    'Your Current Text:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        // border: const OutlineInputBorder(),
                        suffix: IconButton(
                          icon: Icon(
                            Icons.send_outlined,
                            color: Colors.black,
                            size: 15,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return text_to_image(
                                val: _controller.text,
                              );
                            }));
                          },
                        ),
                        hintText: 'Your Spoken Text'),
                  )
                ],
              )),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
