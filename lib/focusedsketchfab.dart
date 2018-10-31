import 'package:flutter/material.dart';
import 'model.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/gestures.dart';
import 'package:chewie/chewie.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'videoplayer.dart';
import 'focusedscreen.dart';

class FocusedSketchfab extends StatefulWidget{
  FocusedSketchfab(PostData post) {
    n = post;
  }
  PostData n;

  @override
  State<StatefulWidget> createState() {
    return new FocusedSketchfabState(n);
  }
}

class FocusedSketchfabState extends State<FocusedSketchfab> {

  FocusedSketchfabState(PostData post) {
    n = post;
    appBar = AppBar(title: Text(n.assetName + " on SketchFab"));
    safeArea = SafeArea();
  }

  PostData n;
  FlutterWebviewPlugin webView;
  AppBar appBar;
  SafeArea safeArea;
  double width;
  double height;

  void DismissWebView() {
    if (webView != null) {
      webView.close();
    }
  }
  void DrawWebView(double appBarHeight, double width, double height) {
    if (webView != null) {
      webView.dispose();
      webView = null;
    }
    webView = new FlutterWebviewPlugin();
    webView.launch(
      "https://sketchfab.com/models/" + n.content + "/embed?autospin=0.2&amp;autostart=1&amp;camera=0",
      rect: Offset(0.0, appBarHeight) & Size(width, height)
    );
    /*
    webView.evalJavascript('''
    document.write(`
    <div class="sketchfab-embed-wrapper">
    <iframe width="''' + width.toString() + '''" height="''' + height.toString() + '''"
    src="
    '''
    + "https://sketchfab.com/models/" + n.content + "/embed?autospin=0.2&amp;autostart=1&amp;camera=0" +
    '''
    frameborder="0" allow="autoplay; fullscreen; vr" mozallowfullscreen="true" webkitallowfullscreen="true">
    </iframe>
    </div>
    `);
    ''');
    */
  }

  @override
  void dispose() {
    super.dispose();
    DismissWebView();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    double offset = MediaQuery.of(context).padding.top + appBar.preferredSize.height;
    DrawWebView(offset, width, height - offset);
    return new Scaffold(
        body: SafeArea(
        ),
        appBar: appBar
      );
  }
}