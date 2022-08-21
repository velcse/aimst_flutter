//import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StaticPage extends StatefulWidget {
  final String url;
  final String navigationTitle;

  const StaticPage({Key? key, required this.url, required this.navigationTitle})
      : super(key: key);
  @override
  _StaticPageState createState() => _StaticPageState();
}

class _StaticPageState extends State<StaticPage> {
  //final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.navigationTitle.toUpperCase()),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: widget.url,
          );
        }));
  }
}
