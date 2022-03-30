import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../infrastructure/github_authenticatore.dart';

class AuthorizationPage extends StatefulWidget {
  final Uri authorizationUrl;
  final void Function(Uri redirectedUrl) onAuthorizationCodeRedirectAttemp;

  const AuthorizationPage({
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttemp,
  });
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.authorizationUrl.toString(),
          // Clears cookies so it will alwayes show the sign-in page.
          onWebViewCreated: (controller) {
            controller.clearCache();
            CookieManager().clearCookies();
          },
          navigationDelegate: (navReq) {
            // intercept the redirection attemp.
            if (navReq.url.startsWith(Github.redirectedUrl.toString())) {
              widget.onAuthorizationCodeRedirectAttemp(Uri.parse(navReq.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
