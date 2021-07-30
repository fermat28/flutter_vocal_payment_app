import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Widget/VocalSignupPage.dart';
import 'package:flutter_login_signup/src/transactions.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import './api/speech_api.dart';
import './widget/substring_highlighted.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:string_similarity/string_similarity.dart';

class PrincipalPage extends StatefulWidget {
  final String mdpOrange;
  final String mdpMtn;
  PrincipalPage(
      {Key key, this.title, @required this.mdpOrange, @required this.mdpMtn})
      : super(key: key);

  final String title;

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class Command {
  static final all = [
    email,
    browser1,
    browser2,
    achat,
    numero,
    envoiargent,
    envoicredit,
    achadata,
    envoidata,
    beepme
  ];
  static const email = 'fais un email';
  static const browser1 = 'open';
  static const browser2 = 'go to';
  static const achat = 'achat de';
  static const numero = 'à';
  static const envoiargent = 'envoie';
  static const envoicredit = 'envoi de';
  static const achadata = 'achat de';
  static const envoidata = 'envoi de';
  static const beepme = 'bip mi à';
}

class _PrincipalPageState extends State<PrincipalPage> {
  String text = 'for vocal mode Press the button and start speaking';
  bool isListening = false;
  static List<Contact> contacts = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();
  static final noms = <String>[];
  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();

    setState(() {
      contacts = _contacts;
    });
  }

  static String liste_contacts(String number) {
    final comparison = <double>[];
    for (var i = 0; i < contacts.length; i++) {
      final numero = number;

      noms.add(contacts[i].displayName);
      comparison.add(numero.similarityTo(noms[i]));
    }
    var largestGeekValue = comparison[0];
    int value;
    String yo;

    for (var j = 0; j < comparison.length; j++) {
      // Checking for largest value in the list
      if (comparison[j] > largestGeekValue) {
        largestGeekValue = comparison[j];
        value = j;
        yo = contacts[value]
            .phones
            .elementAt(0)
            .value
            .replaceAll(new RegExp(r"\s+\b|\b\s"), "");
        if (yo.length == 10) {
          String text = yo.substring(1);
          yo = text;
        } else if (yo.length == 12) {
          String text = yo.substring(3, 12);
          yo = text;
        } else if (yo.length == 13) {
          String text = yo.substring(4, 13);
          yo = text;
        }
      }
    }
    return yo;
  }

  static void scanText(String rawText) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.email)) {
      final body = _getTextAfterCommand(text: text, command: Command.email);

      openEmail(body: body);
    } else if (text.contains(Command.browser1)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser1);

      openLink(url: url);
    } else if (text.contains(Command.browser2)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser2);

      openLink(url: url);
    } else if (text.contains(Command.achat)) {
      final url = _getTextAfterCommand(text: text, command: Command.achat);
      openOm(code: url);
    } else if (text.contains(Command.envoiargent)) {
      final url =
          _getTextAfterCommand(text: text, command: Command.envoiargent);
      final numero = _getTextAfterCommand(text: text, command: Command.numero);
      sendcredit(code: url, numero: numero);
    }
  }

  static String _getTextAfterCommand({
    @required String text,
    @required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future openLink({
    @required String url,
  }) async {
    if (url.trim().isEmpty) {
      await _launchUrl('https://google.com');
    } else {
      await _launchUrl('https://$url');
    }
  }

  static Future openOm({
    //  final String okay = new (widget.mdpOrange) ,
    @required String code,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*1*1*${code.replaceAll(RegExp(r".[a-zA-z]"), "")}#");
  }

  static Future sendcredit({
    @required String code,
    @required String numero,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*1*2*${liste_contacts(numero).toString()}*${((code.replaceAll(RegExp(r"[a-zA-z]"), "")).replaceAll(RegExp(" "), "")).replaceAll(RegExp('à'), "")}*#");
  }

  static Future openEmail({
    @required String body,
  }) async {
    final url = 'mailto: ?body=${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _soly() {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: RaisedButton(
        color: Colors.transparent,
        //  backgroundColor: Colors.transparent,
        onPressed: () {},
        child: Image.asset(
          'assets/soliGif.gif',
          height: 150,
          width: 150,
        ),
      ),
    );
  }

  Widget _rec() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VocalSignupPage()));
              },
              icon: Icon(Icons.mic),
              iconSize: 80,
              color: Colors.white,
            ),

            //Icon(Icons.security, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'Commande vocale',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _manu() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              onPressed:
                  /*() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              }*/
                  () {
                _sendDataToSecondScreen(context);
              },
              icon: Icon(Icons.touch_app),
              iconSize: 80,
              color: Colors.white,
            ),

            //Icon(Icons.fingerprint, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'Mode manuel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _lebos() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _manu(),
          SizedBox(
            width: 80,
          ),
          Center(
            child: SubstringHighlight(
              text: text,
              terms: Command.all,
              textStyle: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textStyleHighlight: TextStyle(
                fontSize: 32.0,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          AvatarGlow(
            animate: isListening,
            endRadius: 75,
            glowColor: Theme.of(context).primaryColor,
            child: FloatingActionButton(
              child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
              onPressed: _toggleRecording,
            ),
          ),
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
                  colors: [Colors.amber, Colors.white])),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(),
                SizedBox(
                  height: 10.0,
                ),
                _lebos(),
              ]),
        ),
      ),
    );
  }

  Future _toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              scanText(text);
            });
          }
        },
      );
  void _sendDataToSecondScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionPage(
            mdpOrange: widget.mdpOrange,
            mdpMtn: widget.mdpMtn,
          ),
        ));
  }
}
