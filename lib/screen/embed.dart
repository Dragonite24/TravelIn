import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Вставиание веб приложения в экран
class Embed extends StatefulWidget {
  Embed({Key key, this.url, this.color, this.title}) : super(key: key);

  final String url;
  final String title;
  final Color color;

  @override
  _EmbedState createState() => _EmbedState();
}

class _EmbedState extends State<Embed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
