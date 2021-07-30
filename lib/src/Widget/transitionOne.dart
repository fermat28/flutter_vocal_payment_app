import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class TransactionOne extends StatefulWidget {
  final String mdpOrange;
  final String mdpMtn;
  TransactionOne(this.mdpOrange, this.mdpMtn);
  @override
  _TransactionOneState createState() => _TransactionOneState();
}

class _TransactionOneState extends State<TransactionOne> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(fontSize: 25, color: Colors.amber),
              headline6: TextStyle(fontSize: 15, color: Colors.green),
            ),
      ),
      home: MyHomePage(widget.mdpOrange),
      title: 'transtion page',
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String mdp;
  MyHomePage(this.mdp);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Buy Datas')),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff070338), Color(0xff494299)],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              Text(
                'Forfaits 24h',
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Divider(
                  color: Colors.red,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*3*4*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('100 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('100Mo',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*3*3*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('250 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('250Mo',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*3*2*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('500 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('600Mo',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*3*1*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('1000 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('2Go',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              Text(
                'Forfaits 3 jours',
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Divider(
                  color: Colors.red,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*2*1*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('500 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('500Mo',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*2*2*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('300 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('350Mo',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
              ),
              Text(
                'Forfaits 30 jours',
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Divider(
                  color: Colors.red,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*1*1*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('10000 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('1Go/jr',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*1*2*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('8000 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('9.2Go',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*1*3*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('4000 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('3Go',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*1*4*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('3000 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('1.2Go',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(30),
                      primary: Colors.black54, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
