import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));

class HomePage extends StatefulWidget {
  static var r;
  web1(cmd, cn) async {
    var url = Uri.http(
        "192.168.1.6", "/cgi-bin/cmd.py", {"c": "run", "x": cmd, "y": cn});
    var response = await http.get(url);
    print(response.body);
  }

  web2(cmd) async {
    var url = Uri.http(
        "192.168.1.6", "/cgi-bin/cmd.py", {"c": "stop", "x": '', "y": cmd});
    var response = await http.get(url);
    print(response.body);
    r = response.body;
    return r;
  }

  web3(cmd) async {
    var url = Uri.http(
        "192.168.1.6", "/cgi-bin/cmd.py", {"c": "start", "x": '', "y": cmd});
    var response = await http.get(url);
    print(response.body);
    r = response.body;
    return r;
  }

  web4(cmd) async {
    var url = Uri.http(
        "192.168.1.6", "/cgi-bin/cmd.py", {"c": "remove", "x": '', "y": cmd});
    var response = await http.get(url);
    print(response.body);
    r = response.body;
    return r;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

// ignore: camel_case_types
class pg2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Docker List'),
        ),
        body: const WebView(
          initialUrl: 'http://192.168.1.6/cgi-bin/cmd.py?c=list',
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}

// ignore: camel_case_types
class pg3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Docker Images'),
        ),
        body: const WebView(
          initialUrl: 'http://192.168.1.6/cgi-bin/cmd.py?c=images',
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}

Future _asyncInputDialog1(BuildContext context) async {
  String imageName = '';
  String dockerName = '';

  return showDialog(
    context: context,
    // dialog is dismissible with a tap on the barrier
    builder: (context) {
      return AlertDialog(
        title: Text("Docker Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                //icon: Icon(Icons.account_circle),
                labelText: 'Image Name',
              ),
              onChanged: (value) {
                imageName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                //icon: Icon(Icons.lock),
                labelText: 'Docker Name',
              ),
              onChanged: (value) {
                dockerName = value;
              },
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Ok'),
              onPressed: () {
                HomePage obj = new HomePage();
                obj.web1(imageName, dockerName);
                print(imageName);
                print(dockerName);
                Navigator.of(context).pop(imageName);
              },
            ),
          ],
        ),
      );
    },
  );
}

Future _asyncInputDialog2(BuildContext context) async {
  String dockerName = '';

  return showDialog(
    context: context,
    // dialog is dismissible with a tap on the barrier
    builder: (context) {
      return AlertDialog(
        title: Text("Docker Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                //icon: Icon(Icons.account_circle),
                labelText: 'Docker Name to Stop',
              ),
              onChanged: (value) {
                dockerName = value;
              },
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Ok'),
              onPressed: () {
                HomePage obj = new HomePage();
                obj.web2(dockerName);
                print(dockerName);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

Future _asyncInputDialog3(BuildContext context) async {
  String dockerName = '';

  return showDialog(
    context: context,
    // dialog is dismissible with a tap on the barrier
    builder: (context) {
      return AlertDialog(
        title: Text("Docker Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                //icon: Icon(Icons.account_circle),
                labelText: 'Docker Name to Start',
              ),
              onChanged: (value) {
                dockerName = value;
              },
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Ok'),
              onPressed: () {
                HomePage obj = new HomePage();
                obj.web3(dockerName);
                print(dockerName);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

Future _asyncInputDialog4(BuildContext context) async {
  String dockerName = '';

  return showDialog(
    context: context,
    // dialog is dismissible with a tap on the barrier
    builder: (context) {
      return AlertDialog(
        title: Text("Docker Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                //icon: Icon(Icons.account_circle),
                labelText: 'Docker Image to Remove',
              ),
              onChanged: (value) {
                dockerName = value;
              },
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Ok'),
              onPressed: () {
                HomePage obj = new HomePage();
                obj.web4(dockerName);
                print(dockerName);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.menu),
          title: Text("Home"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: 36,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text("")),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.brown.shade300.withOpacity(.8),
                  Colors.brown.shade100.withOpacity(.6),
                ])),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: AssetImage('icon_01.png'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.brown.shade500.withOpacity(1),
                                Colors.brown.shade500.withOpacity(1),
                              ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Docker Aid",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Tap 1');
                          _asyncInputDialog1(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            // handle your image tap here
                            image: DecorationImage(
                                image: AssetImage(
                              'assets/images/img1.png',
                            )),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          print('Tap 2');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => pg2()));
                          //_asyncInputDialog2(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            // handle your image tap here
                            image: DecorationImage(
                                image: AssetImage(
                              'assets/images/img2.png',
                            )),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          print('Tap 3');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => pg3()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            // handle your image tap here
                            image: DecorationImage(
                                image: AssetImage(
                              'assets/images/img3.png',
                            )),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          print('Tap 4');
                          _asyncInputDialog2(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            // handle your image tap here
                            image: DecorationImage(
                                image: AssetImage(
                              'assets/images/img4.png',
                            )),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          print('Tap 5');
                          _asyncInputDialog3(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            // handle your image tap here
                            image: DecorationImage(
                                image: AssetImage(
                              'assets/images/img5.png',
                            )),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          print('Tap 6');
                          _asyncInputDialog4(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            // handle your image tap here
                            image: DecorationImage(
                                image: AssetImage(
                              'assets/images/img6.png',
                            )),
                          ),
                        ),
                      ),

                      // Image.asset('assets/images/img2.png'),
                      // Image.asset('assets/images/img3.png'),
                      // Image.asset('assets/images/img4.png'),
                      // Image.asset('assets/images/img5.png'),
                      // Image.asset('assets/images/img6.png'),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
