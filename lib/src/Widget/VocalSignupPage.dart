import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:flutter_login_signup/src/page/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class VocalSignupPage extends StatefulWidget {
  VocalSignupPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VocalSignupPageState createState() => _VocalSignupPageState();
}

class _VocalSignupPageState extends State<VocalSignupPage> {
  final _textcontroller1 = TextEditingController();
  final _textcontroller2 = TextEditingController();
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField1(String title, {bool isPassword = false}) {
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: (MediaQuery.of(context).size.width) * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _textcontroller1,
              maxLength: 4,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              obscureText: isPassword,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xff05204a),
                  filled: true)),
        ],
      ),
    );
  }
  Widget _entryField2(String title, {bool isPassword = false}) {
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: (MediaQuery.of(context).size.width) * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _textcontroller2,
              maxLength: 5,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              obscureText: isPassword,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xff05204a),
                  filled: true)),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: (MediaQuery.of(context).size.width) * 0.22,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
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
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff070338), Color(0xff494299)])),
      child: FlatButton(
        child: Text(
          'Enregistrer',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed:  () {
              _sendDataToSecondScreen(context);
            },
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'By ulrich NDJIKI',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
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
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ol',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'y',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField1("Mot de passe orange money", isPassword: false),
        _entryField2("Mot de passe mobile money", isPassword: false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 150,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 40,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
  void _sendDataToSecondScreen(BuildContext context) {
    String motdepasse = _textcontroller1.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(motdepasse)
          
        ));
  }
}
