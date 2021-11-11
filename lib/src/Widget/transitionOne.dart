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
              headline5: TextStyle(fontSize: 15, color: Colors.orange),
              headline6: TextStyle(fontSize: 7, color: Colors.green),
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
        backgroundColor: Colors.orange,
        title: Center(child: Text('Achat de  Datas')),
      ),
      body: Center(
        child: Container(
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
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              Text(
                'Forfaits 24h',
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Divider(
                  color: Colors.orange,
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                  color: Colors.orange,
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                  color: Colors.orange,
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FlutterPhoneDirectCaller.callNumber(
                          "#150*2*2*1*1*4*${widget.mdp}#");
                    },
                    child: Column(
                      children: [
                        Text('2000 Fcfa',
                            style: Theme.of(context).textTheme.headline6),
                        Text('1.2Go',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(25),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
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
