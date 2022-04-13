import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DockerImages extends StatelessWidget {
  final String? server;
  DockerImages(this.server);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Docker Images'),
        ),
        body:  WebView(
          initialUrl: 'http://'+server!+'/cgi-bin/cmd.py?c=images',
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}