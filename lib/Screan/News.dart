import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ApplyScreen extends StatefulWidget {
  const ApplyScreen({Key? key,  required this.baseUrl}) : super(key: key);


  final String baseUrl;

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();



  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (UniversalPlatform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {


    

    if (kDebugMode) {
      print(widget.baseUrl);
    }

    return 
       Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                WebView(
                  initialUrl: widget.baseUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    if (kDebugMode) {
                      print('WebView is loading (progress : $progress%)');
                    }
                  },
                  javascriptChannels: <JavascriptChannel>{
                    _toasterJavascriptChannel(context),
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (kDebugMode) {
                      print('blocking navigation to $request}');
                    }

                    if (kDebugMode) {
                      print('allowing navigation to $request');
                    }
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    if (kDebugMode) {
                      print('Page started loading: $url');
                    }
                  },
                  onPageFinished: (String url) {
                    setState(() {
                      isLoading = false;
                    });
                    if (kDebugMode) {
                      print('Page finished loading: $url');
                    }
                  },
                  gestureNavigationEnabled: true,

                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                    ),
                  ),
              ],
            ),
          ),
        );
  
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'University',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
