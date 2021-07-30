import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './page/home_page.dart';

Future func() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class VocalPage extends StatelessWidget {
   final String mdp;
  VocalPage(this.mdp);
  static final String title = 'Speech to Text';
  @override
  Widget build(BuildContext context) {
 return   MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomePage(mdp),
    );
  }
}
