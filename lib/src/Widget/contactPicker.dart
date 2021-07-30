import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

void main() => runApp(Yoppage());

class Yoppage extends StatefulWidget {
  @override
  _YoppageState createState() => _YoppageState();
}

class _YoppageState extends State<Yoppage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MainWidget(),
      );
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  PhoneContact _phoneContact;
  EmailContact _emailContact;
  String _contact;
  Image _contactPhoto;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children:  _buildChildren(context),
        ),
      );

  List<Widget> _buildChildren(BuildContext context) {
    return <Widget>[
      if (_phoneContact != null)
        Column(
          children: <Widget>[
            const Text("Phone contact:"),
            Text("Name: ${_phoneContact.fullName}"),
            Text(
                "Phone: ${_phoneContact.phoneNumber.number} (${_phoneContact.phoneNumber.label})")
          ],
        ),
      RaisedButton(
        child: const Text("pick phone contact"),
        onPressed: () async {
          final PhoneContact contact =
              await FlutterContactPicker.pickPhoneContact();
          print(contact);
          setState(() {
            _phoneContact = contact;
          });
        },
      ),
    ];
  }
}