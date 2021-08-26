import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OfficialSite extends StatefulWidget {
  @override
  _OfficialSiteState createState() => _OfficialSiteState();
}

class _OfficialSiteState extends State<OfficialSite> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Site Oficial'),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        width: .5
                                    )
                                )
                            )
                        ),
                        child: Text('Site Oficial',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        )
                    ),
                    _loading ? CircularProgressIndicator(
                      color: Colors.grey,
                    ) : Center(),
                    FluttermojiCircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 25,
                    )
                  ],
                ),
              )
          )
      ),
      body: Builder(
          builder: (BuildContext context) {
            return WebView(
                initialUrl: 'https://www.starwars.com/community',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                gestureNavigationEnabled: true,
                onPageStarted: (String url) {
                  setState(() {
                    _loading = true;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    _loading = false;
                  });
                }
            );
          }
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        }
    );
  }

}