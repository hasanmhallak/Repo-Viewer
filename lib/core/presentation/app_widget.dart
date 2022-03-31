import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:sizer/sizer.dart';

import '../../auth/application/auth_notifier.dart';
import '../../auth/shared/providers.dart';
import '../shared/providers.dart';
import 'routes/app_router.gr.dart';

//instead of doing it in main.
final initializationProvider = FutureProvider((ref) async {
  await ref.read(sembastProvider).init();
  ref.watch(dioForRepo)
    ..options = BaseOptions(
      headers: {
        'accept': 'application/vnd.github.v3.html+json',
      },
      validateStatus: (status) =>
          status != null && status >= 200 && status < 400,
    )
    ..interceptors.add(ref.watch(oAuth2InterceptorProvider));

  final authNotifier = ref.read(authProvider.notifier);
  authNotifier.checkAndUpdateAuthState();
});

class AppWidget extends ConsumerWidget {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // To make sure we register the `sembastProvider` and watch `dioForRepo` to intercept it.
    ref.listen(initializationProvider, (previous, next) {});

    // ref.listen<RepoDetailState>(repoDetailNotifierProvider, (previous, next) {
    //   if (next.hasStarredStatusChanged) {
    //     ref.read(authUserNotifierProvider.notifier).getUserInfo();
    //   }
    // });
    // ref.listen<RepoDetailState>(repoDetailNotifierProvider, (previous, next) {
    //   next.maybeWhen(
    //     orElse: () {},
    //     loadSuccess: (_, __) {
    //       if (next.hasStarredStatusChanged) {
    //         ref
    //             .read(starredReposNotifierProvider.notifier)
    //             .getFirstStarredReposPage();
    //       }
    //     },
    //   );
    // });
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.maybeMap(
        orElse: () {},
        authenticated: (_) {
          appRouter.pushAndPopUntil(
            const StarredReposRoute(),
            predicate: (_) => false,
          );
        },
        unAuthenticated: (_) {
          appRouter.pushAndPopUntil(
            const SignInRoute(),
            predicate: (_) => false,
          );
        },
      );
    });

    return Sizer(
      // designSize: const Size(1080, 2160),
      builder: (context, orientation, device) {
        return MaterialApp.router(
          // useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          title: 'Repo Viewer',
          debugShowCheckedModeBanner: false,
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
          theme: _themeData(),
          darkTheme: ThemeData.dark(),
        );
      },
    );
  }

  ThemeData _themeData() {
    // MediaQuery.of(context)
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade50,
        foregroundColor: Colors.black,
      ),
    );
    // return ThemeData.dark();
  }
}
