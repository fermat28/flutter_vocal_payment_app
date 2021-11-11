import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Widget/VocalSignupPage.dart';
import 'package:flutter_login_signup/src/Widget/transferVocal.dart';
import 'package:flutter_login_signup/src/transactions.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import './api/speech_api.dart';
import './widget/substring_highlighted.dart';
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
    achat,
    numero,
    envoiargent,
  ];
  static const achat = 'achat de';
  static const envoiargent = 'envoie';
  static const numero = 'à';
  static const transfert = 'transfert de';
}

class _PrincipalPageState extends State<PrincipalPage> {
  String text = 'Pressez le micro pour le mode vocal';
  bool isListening = false;
  static List<Contact> contacts = [];
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

  void scanText(String rawText) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.achat)) {
      final code = _getTextAfterCommand(text: text, command: Command.achat);
      if (code.contains('francs')) {
        achatcredit(code: code.replaceAll(RegExp("s"), ""));
      } else if (code.contains('mega')) {
        achatdata(code: code.replaceAll(RegExp("a"), ""));
      }
    } else if (text.contains(Command.envoiargent)) {
      final url =
          _getTextAfterCommand(text: text, command: Command.envoiargent);
      final numero = _getTextAfterCommand(text: text, command: Command.numero);
      envoicredit(code: url, numero: numero);

      /*  } else if (text.contains(Command.envoiargent)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser2);

      achatdata(url: url);
    } else if (text.contains(Command.achat)) {
    } else if (text.contains(Command.browser2)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser2);

      envoidata(url: url);
    } else if (text.contains(Command.achat)) {
      final url = _getTextAfterCommand(text: text, command: Command.achat);
      achatcredit(code: url);
    } else if (text.contains(Command.envoiargent)) {
      final url =
          _getTextAfterCommand(text: text, command: Command.envoiargent);
      final numero = _getTextAfterCommand(text: text, command: Command.numero);
      envoicredit(code: url, numero: numero);*/
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

  Future achatcredit({
    //  final String okay = new (widget.mdpOrange) ,
    @required String code,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*1*1*${code.replaceAll(RegExp(r".[a-zA-z]"), "")}*${widget.mdpOrange}#");
  }

  Future envoicredit({
    @required String code,
    @required String numero,
  }) async {
    _sendDataToSecondScreen2(context , numero , code);
    // FlutterPhoneDirectCaller.callNumber(
    //  "#150*2*1*2*${liste_contacts(numero).toString()}*${((code.replaceAll(RegExp(r"[a-zA-z]"), "")).replaceAll(RegExp(" "), "")).replaceAll(RegExp('à'), "")}*${widget.mdpOrange}#");
  }

  Future achatdata({
    @required String code,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*2*1*${code.replaceAll(RegExp(r".[a-zA-z]"), "")}*${widget.mdpOrange}#");
  }

  Future envoidata({
    @required String code,
    @required String numero,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*2*2*${liste_contacts(numero).toString()}*${((code.replaceAll(RegExp(r"[a-zA-z]"), "")).replaceAll(RegExp(" "), "")).replaceAll(RegExp('à'), "")}*${widget.mdpOrange}#");
  }

  Future envoiargent({
    @required String code,
    @required String numero,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*1*2*${liste_contacts(numero).toString()}*${((code.replaceAll(RegExp(r"[a-zA-z]"), "")).replaceAll(RegExp(" "), "")).replaceAll(RegExp('à'), "")}*${widget.mdpOrange}#");
  }

  Widget _soly() {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: RaisedButton(
        color: Colors.transparent,
        //  backgroundColor: Colors.transparent,
        onPressed: _toggleRecording,
        child: Image.asset(
          'assets/soliGif.gif',
          height: 150,
          width: 150,
        ),
      ),
    );
  }

  Widget _manu() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              iconSize: MediaQuery.of(context).size.width * 0.1,
              color: Colors.white,
            ),

            //Icon(Icons.fingerprint, size: 80, color: Colors.white),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0107,
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
            width: MediaQuery.of(context).size.width * 0.15,
          ),
          Center(
            child: SubstringHighlight(
              text: text,
              terms: Command.all,
              textStyle: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textStyleHighlight: TextStyle(
                fontSize: 32.0,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          _soly(),
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
            textStyle: Theme.of(context).textTheme.headline4,
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
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Container(
            width: MediaQuery.of(context).size.width,
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  _title(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.009,
                  ),
                  _lebos(),
                ]),
          );
        }),
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
  void _sendDataToSecondScreen2(BuildContext context , String number , String montant) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyVocalHome( widget.mdpOrange ,  montant , liste_contacts(number).toString()

          ),
        ));
  }
}
