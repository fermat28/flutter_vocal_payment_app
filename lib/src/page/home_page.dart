import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import '../api/speech_api.dart';
import '../vocal.dart';
import '../widget/substring_highlighted.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:string_similarity/string_similarity.dart';

class HomePage extends StatefulWidget {
  static String mdp;
  HomePage(mdp);
  @override
  _HomePageState createState() => _HomePageState();
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

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
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
      if (Command.envoiargent != Null) {
        sendcredit(code: url, numero: numero);
      }
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
    @required String code,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*1*1*${code.replaceAll(RegExp(r'[a-zA-z]'), "")}#");
  }

  static Future sendcredit({
    @required String code,
    @required String numero,
  }) async {
    FlutterPhoneDirectCaller.callNumber(
        "#150*2*1*2*${liste_contacts(numero).toString()}*${code.replaceAll(RegExp(r'[a-zA-z]'), "")}*${HomePage.mdp}#");
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

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(VocalPage.title),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(text);

                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('✓   Copied to Clipboard')),
                  );
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30).copyWith(bottom: 150),
          child: Column(
            children: [
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
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 75,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
            onPressed: toggleRecording,
          ),
        ),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
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
}
