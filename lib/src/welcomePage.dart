import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/local_auth_api.dart';
import 'package:flutter_login_signup/src/principal.dart';
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
  double rate = 0.6;
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

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Widget _submitButton1(TextEditingController controller, String title,
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
                  fillColor: Colors.orange,
                  filled: true)),
        ],
      ),
    );
  }

  Widget _submitButton2(TextEditingController controller, String title,
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
              maxLength: 5,
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
                  fillColor: Colors.orange,
                  filled: true)),
        ],
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
              iconSize: MediaQuery.of(context).size.width * 0.1,
              color: Colors.white,
              onPressed: (((_textcontroller1.text).isEmpty &&
                          (_textcontroller2.text).isEmpty) ||
                      (_textcontroller1.text.length < 4))
                  ? () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Center(child: Text('Erreur')),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 16),
                                    FittedBox(
                                      child: Text(
                                          'veuillez saisir un mot de passe correct',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Ok'),
                                  )
                                ],
                              ));
                    }
                  /*() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrincipalPage()));
              }*/
                  : () {
                      _sendDataToSecondScreen(context);
                    },
            ),

            //Icon(Icons.security, size: 80, color: Colors.white),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.017,
            ),
            Text(
              'M.D.P',
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
                iconSize: MediaQuery.of(context).size.width * 0.1,
                color: Colors.white,
                onPressed: () async {
                  final isAvailable = await LocalAuthApi.hasBiometrics();
                  if (!isAvailable) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Non supporté'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            buildText('R.Faciale ', isAvailable),
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
                  } else
                    _sendDataToSecondScreen(context);
                }),
            //Icon(Icons.face, size: 80, color: Colors.white),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.017,
            ),
            Text(
              'A.faciale',
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
                iconSize: MediaQuery.of(context).size.width * 0.1,
                color: Colors.white,
                onPressed: () async {
                  final isAvailable = await LocalAuthApi.hasBiometrics();
                  if (!isAvailable) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Non supporté'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            buildText('Empreinte digitale', isAvailable),
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
                  } else
                    _sendDataToSecondScreen(context);

                  ;
                }),

            //Icon(Icons.fingerprint, size: 80, color: Colors.white),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.017,
            ),
            Text(
              'E.digitale',
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
      margin: EdgeInsets.only(
        top: 40,
      ),
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
            width: MediaQuery.of(context).size.height * 0.03,
          ),
          _submitButton1(_textcontroller1, " O.M", isPassword: false),
        ],
      ),
    );
  }

  Widget _MTN() {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
      ),
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
            width: MediaQuery.of(context).size.height * 0.06,
          ),
          _submitButton2(_textcontroller2, "MoMo", isPassword: false),
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
            width: MediaQuery.of(context).size.width * 0.025,
          ),
        ],
      ),
    );
  }

  Widget _lebas() {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        width: (MediaQuery.of(context).size.width -
            MediaQuery.of(context).padding.right),
        margin: EdgeInsets.only(top: 40, bottom: 20),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _label(),
            SizedBox(
              width: constraints.maxWidth * 0.15,
            ),
            _pass(),
            SizedBox(
              width: constraints.maxWidth * 0.15,
            ),
            _Rface(),
          ],
        ),
      );
    });
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
            child: LayoutBuilder(builder: (ctx, constraints) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      _title(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0015,
                      ),
                      Column(
                        children: [
                          _ORANGE(),
                          _MTN(),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.013,
                      ),
                      _divider(),
                      _lebas(),
                    ]),
              );
            }),
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
