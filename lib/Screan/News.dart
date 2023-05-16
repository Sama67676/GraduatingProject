import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ApplyScreen extends StatefulWidget {
  const ApplyScreen({Key? key,this.cookieManager,  required this.baseUrl}) : super(key: key);

  final CookieManager? cookieManager;
  final String baseUrl;

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  DateTime? _currentBackPressTime;
  static const Duration _backDoubleClickDuration = Duration(seconds: 2);

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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () {
          final now = DateTime.now();
          if (_currentBackPressTime == null ||
              now.difference(_currentBackPressTime!) >
                  _backDoubleClickDuration) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                // backgroundColor: context.colorScheme.primary,
                duration: _backDoubleClickDuration,
                content: Text('context.l10n.pressAgainToGoBack'),
              ),
            );

            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
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
                  // backgroundColor: context.colorScheme.background,
                ),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      // color: context.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),
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
