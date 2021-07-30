import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Widget/TransitonPage.dart';
import 'package:flutter_login_signup/src/Widget/senCredit.dart';
import 'package:flutter_login_signup/src/Widget/sendMoney.dart';
import 'package:flutter_login_signup/src/Widget/transitionOne.dart';
import 'package:flutter_login_signup/src/Widget/transitionTwo.dart';
import 'package:flutter_login_signup/src/achatCredit.dart';
import 'package:flutter_login_signup/src/models/codes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class TransactionPage extends StatefulWidget {
  final String mdpOrange;
  final String mdpMtn;
  static const routeName = '/transactions';
  TransactionPage(
      {Key key, this.title, @required this.mdpOrange, @required this.mdpMtn})
      : super(key: key);

  final String title;

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _textcontroller1 = TextEditingController();
  void submitData() {
    final enteredAmount = _textcontroller1.text;

    if (enteredAmount.isEmpty) {
      return;
    }
    FlutterPhoneDirectCaller.callNumber(
        "*150*2*1*1*${_textcontroller1.text}*${widget.mdpOrange}#");
    Navigator.of(context).pop();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Montant'),
                    controller: _textcontroller1,
                    onSubmitted: (_) => submitData(),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                  ),
                  FlatButton(
                    child: Text('Valider'),
                    textColor: Colors.purple,
                    onPressed: submitData,
                  ),
                ],
              ),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Widget _achatcredit() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.input),
              iconSize: 80,
              color: Colors.white,
              onPressed: () => _startAddNewTransaction(
                  context), /*async {
                FlutterPhoneDirectCaller.callNumber(
                    "#150*2*1*1*${_textcontroller1.text}*2005#");
              },*/
            ),

            //Icon(Icons.security, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'Mon achat credit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _transfertcredit() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.mobile_friendly),
                iconSize: 80,
                color: Colors.white,
                onPressed:
                    /*() async {
                if (text[1] == '7' ||
                    text[1] == '8' ||
                    (text[1] == '5' && text[2] == '0') ||
                    (text[1] == '5' && text[2] == '1') ||
                    (text[1] == '5' && text[2] == '3') ||
                    (text[1] == '5' && text[2] == '4') ||
                    (text[1] == '5' && text[2] == '2')) {
                  FlutterPhoneDirectCaller.callNumber(
                      "*126*3*1*1*${_textcontroller1.text}*2005#");
                } else {
                  FlutterPhoneDirectCaller.callNumber(
                      "#150*2*1*${text}*5000*${widget.mdpOrange , widget.mdpMtn}#");
                }*/
                    () {
                  _sendDataToSecondScreenfour(context);
                }),

            //Icon(Icons.security, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'transférer du crédit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _transfertArgent() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.monetization_on),
              iconSize: 80,
              color: Colors.white,
              onPressed: () {
                _sendDataToSecondScreenthtee(context);
              }
/*async {
                FlutterPhoneDirectCaller.callNumber(
                    "#150*1*1*695425491*${_textcontroller1.text}*2005#");
              }*/
              ,
            ),

            //Icon(Icons.fingerprint, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              "Envoyer de l'argent",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _achatInternet(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_circle),
              iconSize: 80,
              color: Colors.white,
              onPressed: () {
                _sendDataToSecondScreen(context);
              },
            ),

            //Icon(Icons.security, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'acheter des data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Widget _envoieInternet() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              iconSize: 80,
              color: Colors.white,
              onPressed: () {
                _sendDataToSecondScreentwo(context);
              },
            ),

            //Icon(Icons.security, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              'envoyer des data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  /* Widget _beepMe() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.accessibility_sharp),
              iconSize: 80,
              color: Colors.white,
              onPressed: () async {
                FlutterPhoneDirectCaller.callNumber("#150*2*1*1*5000*2005#");
              },
            ),

            //Icon(Icons.fingerprint, size: 80, color: Colors.white),
            SizedBox(
              height: 15,
            ),
            Text(
              "Paiement facture",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }*/

  Widget _lebous() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _achatcredit(),
          SizedBox(
            width: 80,
          ),
          _transfertArgent(),
          SizedBox(
            width: 80,
          ),
          _transfertcredit(),
        ],
      ),
    );
  }

  Widget _lebouse() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _achatInternet(context),
          SizedBox(
            width: 80,
          ),
          _envoieInternet(),
          SizedBox(
            width: 80,
          ),
          // _beepMe(),
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
              colors: [Color(0xff070338), Color(0xff494299)],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                  ),
                  _title(),
                  SizedBox(
                    height: 70.0,
                  ),
                  _lebous(),
                  SizedBox(
                    height: 20.0,
                  ),
                  _lebouse(),
                ]),
          ),
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
    });
  }

  void _sendDataToSecondScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionOne(widget.mdpOrange, widget.mdpMtn),
        ));
  }

  void _sendDataToSecondScreentwo(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransitionPage(widget.mdpOrange, widget.mdpMtn),
        ));
  }

  void _sendDataToSecondScreenthtee(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendMoney(widget.mdpOrange, widget.mdpMtn),
        ));
  }

  void _sendDataToSecondScreenfour(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendCredit(widget.mdpOrange, widget.mdpMtn),
        ));
  }
}
