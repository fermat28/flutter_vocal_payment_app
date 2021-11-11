import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/achatCredit.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SendMoney extends StatefulWidget {
  final String mdpOrange;
  final String montant;
  final String numero;
  SendMoney(this.mdpOrange, this.montant , this.numero);
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyVocalHome(widget.mdpOrange , widget.montant , widget.numero),
    );
  }
}

class MyVocalHome extends StatefulWidget {
  final String mdpOrange;
  final String montant;
  final String numero;
  MyVocalHome(this.mdpOrange , this.montant , this.numero);
  @override
  _MyVocalHomeState createState() => _MyVocalHomeState();
}

class _MyVocalHomeState extends State<MyVocalHome> {
  String text = 'Text';

  final _textcontroller1 = TextEditingController();
  final _textcontroller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text("Transfert D'argent"),
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
                controller: _textcontroller2,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.phone,
                decoration: new InputDecoration(
                    hintText: widget.numero,
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
                    hintText: widget.montant,
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
                      //print(widget.mdpOrange);
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*1*1*${widget.numero}*${widget.montant}*${widget.mdpOrange}#");
                    }
                  : () {
                      //print(widget.mdpOrange);
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*1*1*${_textcontroller2.text}*${_textcontroller1.text}*${widget.mdpOrange}#");
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
