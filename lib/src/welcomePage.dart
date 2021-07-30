import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/face_page.dart';
import 'package:flutter_login_signup/src/local_auth_api.dart';
import 'package:flutter_login_signup/src/principal.dart';
import 'package:flutter_login_signup/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

enum TtsState { playing, stopped }

class _WelcomePageState extends State<WelcomePage> {
  final _textcontroller1 = TextEditingController();
  final _textcontroller2 = TextEditingController();
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 0.5;
  double pitch = 0.8;
  double rate = 1.0;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    initTts();

    super.initState();
  }

  initTts() {
    flutterTts = FlutterTts();
    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
    Future.delayed(const Duration(milliseconds: 200), () async {
      await flutterTts.setVolume(volume);
      await flutterTts.setSpeechRate(rate);
      await flutterTts.setPitch(pitch);
      var result = await flutterTts.speak(
          "Bonjour.Je suis soli.Je suis là pour simplifier toutes vos opérations orange et mo bail moni. Veuillez choisir votre mode d'authentification");
      if (result == 1) setState(() => ttsState = TtsState.playing);
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  //Future _speak() async {

  //}

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Widget _submitButton(TextEditingController controller, String title,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: (MediaQuery.of(context).size.width) * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
              controller: controller,
              maxLength: 4,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              obscureText: isPassword,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  hintText: title,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  fillColor: Colors.green,
                  filled: true)),
        ],
      ),
    );
  }

  Widget _signUpButton() {
    return Container(
      child: Container(
        width: (MediaQuery.of(context).size.width) * 0.45,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: Text(
          '',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  Widget _rec() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        child: Text(
          'Reconnaissance Vocale',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  Widget _pass() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.security),
              iconSize: 80,
              color: Colors.white,
              onPressed:
                  /*() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrincipalPage()));
              }*/
                  () {
                _sendDataToSecondScreen(context);
              },
            ),

            //Icon(Icons.security, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'Mot de passe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget _Rface() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.face),
                iconSize: 80,
                color: Colors.white,
                onPressed: () async {
                  final isAvailable = await LocalAuthApi.hasBiometrics();
                  if (!isAvailable) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Availability'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            buildText('Reconaissance Faciale ', isAvailable),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Ok'),
                          )
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FacePage()));
                  }
                  ;
                }),
            //Icon(Icons.face, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'Analyse faciale',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.fingerprint),
                iconSize: 80,
                color: Colors.white,
                onPressed: () async {
                  final isAvailable = await LocalAuthApi.hasBiometrics();
                  if (!isAvailable) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Availability'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            buildText('Reconaissance Faciale ', isAvailable),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Ok'),
                          )
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  }
                  ;
                }),

            //Icon(Icons.fingerprint, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'Empreinte digitale',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _ORANGE() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Orange',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 50,
          ),
          _submitButton(_textcontroller1, "Mot de passe orange money",
              isPassword: false),
        ],
      ),
    );
  }

  Widget _MTN() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Mtn',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 60,
          ),
          _submitButton(_textcontroller2, "Mot de passe mobile money",
              isPassword: false),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "Choisissez un mode d'authentification",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

 
  Widget _lebas() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _label(),
          SizedBox(
            width: 80,
          ),
          _pass(),
          SizedBox(
            width: 80,
          ),
          _Rface(),
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'S',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 60,
            fontWeight: FontWeight.w700,
            color: Colors.orangeAccent,
          ),
          children: [
            TextSpan(
              text: 'ol',
              style: TextStyle(color: Colors.orangeAccent, fontSize: 60),
            ),
            TextSpan(
              text: 'y',
              style: TextStyle(color: Colors.orangeAccent, fontSize: 60),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff070338), Color(0xff010001)])),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    _title(),
                    SizedBox(
                      height: 35,
                    ),
                    _ORANGE(),
                    _MTN(),
                    SizedBox(
                      height: 60,
                    ),
                    _divider(),
                    SizedBox(
                      height: 10,
                    ),
                    _lebas(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    String motdepasseOrange = _textcontroller1.text;
    String motdepasseMtn = _textcontroller2.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrincipalPage(
            mdpOrange: motdepasseOrange,
            mdpMtn: motdepasseMtn,
          ),
        ));
  }
}
