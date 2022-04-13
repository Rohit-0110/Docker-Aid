import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DockerList extends StatelessWidget {
  final String? server;
  DockerList(this.server);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Docker List'),
        ),
        body: WebView(
          initialUrl: 'http://'+server!+'/cgi-bin/cmd.py?c=list',
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}