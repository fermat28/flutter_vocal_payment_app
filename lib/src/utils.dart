import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class Command {
  static final all = [email, browser1, browser2];

  static const email = 'fais un email';
  static const browser1 = 'open';
  static const browser2 = 'go to';
  static const achat = 'achat de';
  static const numero = 'à';
  static const envoiargent = 'envoie de';
  static const envoicredit = 'envoi de';
  static const achadata = 'achat de';
  static const envoidata = 'envoi de';
  static const beepme = 'bip mi à';
}

class Utils {
  final String mdp;
  Utils(this.mdp);
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
    @required String code,
  }) async {
    FlutterPhoneDirectCaller.callNumber("#150*2*1*1*$code#");
  }

  static Future sendcredit({
    @required String code,
    @required String numero,
  }) async {
    //print(widget.mdp);
    FlutterPhoneDirectCaller.callNumber("#150*2*1*2*$numero*$code#");
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
}
