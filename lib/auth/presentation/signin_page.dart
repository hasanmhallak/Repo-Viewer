import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/presentation/routes/app_router.gr.dart';
import '../shared/providers.dart';

class SignInPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  MdiIcons.github,
                  size: 150,
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome to\nRepo Viewer',
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    // calls sign-in method in which will take a function that take the url for the sign-in and return
                    // the redirected uri.
                    ref.read(authProvider.notifier).signIn(
                      (authUri) {
                        // Creates a future to hold the url callback.
                        final completer = Completer<Uri>();
                        AutoRouter.of(context).push(
                          AuthorizationRoute(
                            authorizationUrl: authUri,
                            // this function will give us the redirected uri.
                            onAuthorizationCodeRedirectAttemp: (uri) {
                              completer.complete(uri);
                            },
                          ),
                        );
                        return completer.future;
                      },
                    );
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
