import 'package:docker/login_screen.dart';
import 'package:docker/widgets/docker_card.dart';
import 'package:docker/widgets/docker_images.dart';
import 'package:docker/widgets/docker_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {


  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static var r;
  String server = "192.168.1.6";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("DOCKER AID", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
            fontSize: 25),),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child:
            GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight, colors: [
                  // Colors.brown.shade300.withOpacity(.8),
                  const Color(0xFFACC8E5),
                  const Color(0xFF112A46),
                  // Colors.brown.shade100.withOpacity(.6),
                ])),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: GridView.count(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30,
              children: [
                DockerCard(
                    imgPath: 'assets/images/docker_run.png',
                    title: "DOCKER RUN",
                    onPressed: () {
                      _asyncInputDialog1(context);
                    }),
                DockerCard(
                    imgPath: 'assets/images/docker_list.png',
                    title: "DOCKER LIST",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DockerList(server)));
                    }),
                DockerCard(
                    imgPath: 'assets/images/docker_image.png',
                    title: "DOCKER IMAGES",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DockerImages(server)));
                    }),

                DockerCard(
                    imgPath: 'assets/images/docker_stop.png',
                    title: "DOCKER STOP",
                    onPressed: () {
                      _asyncInputDialog2(context);
                    }),

                DockerCard(
                    imgPath: 'assets/images/docker_start.png',
                    title: "DOCKER START",
                    onPressed: () {
                      _asyncInputDialog3(context);
                    }),

                DockerCard(
                    imgPath: 'assets/images/docker_remove.png',
                    title: "DOCKER REMOVE",
                    onPressed: () {
                      _asyncInputDialog4(context);
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _urlInputDialog(context);
        },
        child: Icon(Icons.settings, color: Colors.white, size: 29,),
        backgroundColor: Colors.green.shade400,
        tooltip: 'Change URL',
        elevation: 5,
        splashColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Changa",
          fontSize: 25),),
      content: Text("Are you sure you want to logout?",style: TextStyle(
          fontFamily: "Changa",
          fontSize: 20),),
      actions: [
        // okButton,
        TextButton(
        child: Text("Cancle",style: TextStyle(
            fontFamily: "Changa",
            fontSize: 20),),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
        TextButton(
        child: Text("Logout",style: TextStyle(
            fontFamily: "Changa",
            fontSize: 20),),
        onPressed: () {

          _signOut();
          print(clearPrefs().toString());
          // FirebaseAuth.instance.signOut();
          // clearPrefs();

          // Navigator.push(context, MaterialPageRoute<void>(
          //     builder: (BuildContext context) => const LoginScreen())
          // );
        },
    ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await clearPrefs();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            (_) => false);
  }

  clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove bool
    print(prefs.getBool("isLoggedIn").toString());

    prefs.remove("isLoggedIn");
    print(prefs.getBool("isLoggedIn").toString());

  }

  web1(cmd, cn) async {
    var url = Uri.http(
        server, "/cgi-bin/cmd.py", {"c": "run", "x": cmd, "y": cn});
    var response = await http.get(url);
    print(url.toString());
    print(cmd);
    print(cn);
    print(response.body);
  }

  web2(cmd) async {
    var url = Uri.http(
        server, "/cgi-bin/cmd.py", {"c": "stop", "x": '', "y": cmd});
    var response = await http.get(url);
    print(response.body);
    r = response.body;
    return r;
  }

  web3(cmd) async {
    var url = Uri.http(
        server, "/cgi-bin/cmd.py", {"c": "start", "x": '', "y": cmd});
    var response = await http.get(url);
    print(response.body);
    r = response.body;
    return r;
  }

  web4(cmd) async {
    var url = Uri.http(
        server, "/cgi-bin/cmd.py", {"c": "remove", "x": '', "y": cmd});
    var response = await http.get(url);
    print(response.body);
    r = response.body;
    return r;
  }

  // web5(cmd) async {
  //   var url = Uri.http(
  //       "192.168.1.6", "/cgi-bin/cmd.py", {"c": "remove", "x": '', "y": cmd});
  //   var response = await http.get(url);
  //   print(response.body);
  //   r = response.body;
  //   return r;
  // }


  Future _asyncInputDialog1(BuildContext context) async {
    String imageName = '';
    String dockerName = '';

    return showDialog(
      context: context,
      // dialog is dismissible with a tap on the barrier
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Docker Details", style: TextStyle(fontWeight: FontWeight.bold),),
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
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFACC8E5),
                      padding: const EdgeInsets.all(10.0),),
                    child: Text('OK', style: TextStyle(color: Colors.black),),
                    onPressed: () {
                      web1(imageName, dockerName);
                      print(imageName);
                      print(dockerName);
                      Navigator.of(context).pop(imageName);
                    },
                  ),
                ),
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
          title: Text(
            "Docker Details", style: TextStyle(fontWeight: FontWeight.bold),),
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
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFACC8E5),
                      padding: const EdgeInsets.all(10.0),),
                    child: Text('OK', style: TextStyle(color: Colors.black),),
                    onPressed: () {
                      web2(dockerName);
                      print(dockerName);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
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
          title: Text(
            "Docker Details", style: TextStyle(fontWeight: FontWeight.bold),),
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
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFACC8E5),
                      padding: const EdgeInsets.all(10.0),),
                    child: Text('OK', style: TextStyle(color: Colors.black),),
                    onPressed: () {
                     web3(dockerName);
                      print(dockerName);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
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
          title: Text(
            "Docker Details", style: TextStyle(fontWeight: FontWeight.bold),),
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
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFACC8E5),
                      padding: const EdgeInsets.all(10.0),),
                    child: Text('OK', style: TextStyle(color: Colors.black),),
                    onPressed: () {
                      web4(dockerName);
                      print(dockerName);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future _urlInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      // dialog is dismissible with a tap on the barrier
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Server URL", style: TextStyle(fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController()..text = server,
                decoration: InputDecoration(
                  labelText: 'Enter URL',
                ),
                onChanged: (value) {
                  server = value;
                },
              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFACC8E5),
                      padding: const EdgeInsets.all(10.0),),
                    child: Text('OK', style: TextStyle(color: Colors.black),),
                    onPressed: () {
                      print("New URL:"+server);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}
