import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/achatCredit.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SendCredit extends StatefulWidget {
  final String mdpOrange;
  final String mdpMtn;
  SendCredit(this.mdpOrange, this.mdpMtn);
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendCredit> {
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
  final _textcontroller1 = TextEditingController();
  final _textcontroller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text('Transfert De Credit'),
        ),
      ),
      body: Container(
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
            colors: [Color(0xff070338), Color(0xff010001)],
          ),
        ),
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
                keyboardType: TextInputType.phone,
                controller: _textcontroller2,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    hintText: "Numero Du Destinataire",
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
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
                keyboardType: TextInputType.phone,
                controller: _textcontroller1,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    hintText: ' Montant de la transaction',
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            RaisedButton(
              color: Colors.orange,
              onPressed: () {
                _awaitReturnValueFromSecondScreen(context);
              },
              child: Text("Choisir le contact du destinataire"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            RaisedButton(
              color: Colors.orange,
              onPressed: (_textcontroller2.text == null)
                  ? () {
                      //print(widget.mdp);
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*1*2*${text}*${_textcontroller1.text}*${widget.mdp}#");
                    }
                  : () {
                      //print(widget.mdp);
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*1*2*${_textcontroller2.text}*${_textcontroller1.text}*${widget.mdp}#");
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
}
