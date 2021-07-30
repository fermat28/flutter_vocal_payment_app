import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Widget/transitionTwo.dart';
import 'package:flutter_login_signup/src/achatCredit.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class TransitionPage extends StatefulWidget {
  final String mdpOrange;
  final String mdpMtn;
  TransitionPage(this.mdpOrange, this.mdpMtn);
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<TransitionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(widget.mdpOrange),
    );
  }
}

class MyHome extends StatefulWidget {
  final String mdp;
  MyHome(this.mdp);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _textcontroller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Send Datas'),
        ),
      ),
      body: Container(
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              margin: EdgeInsets.all(30),
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                border: new Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: new TextField(
                controller: _textcontroller2,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  hintText: "Entrez le numero s'il n'est pas dans vos contacts",
                  border: InputBorder.none,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _awaitReturnValueFromSecondScreen(context);
              },
              child: Text("Choisir le contact du destinataire"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            ElevatedButton(
              onPressed:
                  /*_textcontroller2.text.isEmpty
                  ? () {
                      //print(widget.mdp);
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*1*2*${text}*${_textcontroller1.text}*${widget.mdp}#");
                    }
                  : () {
                      //print(widget.mdp);
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*1*2*${_textcontroller2.text}*${_textcontroller1.text}*${widget.mdp}#");
                    }*/
                  () {
                _sendDataToSecondScreentwo(context);
              },
              child: Text("Valider"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.07,
            ),
          ],
        ),
      ),
    );
  }

  String text = 'Text';

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YoPage(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      text = result;
      _textcontroller2.text = text;
    });
  }

  void _sendDataToSecondScreentwo(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Transactiontwo(widget.mdp, text),
        ));
  }
}
