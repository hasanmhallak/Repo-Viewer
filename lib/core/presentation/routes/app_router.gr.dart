// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../../auth/presentation/authorization_page.dart' as _i3;
import '../../../auth/presentation/signin_page.dart' as _i2;
import '../../../drawer/presentation/drawer_state.dart' as _i7;
import '../../../github/core/domain/github_repo.dart' as _i10;
import '../../../github/details/presentation/repo_detail_page.dart' as _i6;
import '../../../github/repos/searched_repo/presentation/searched_repos_page.dart'
    as _i5;
import '../../../github/repos/starred_repos/presentation/starred_repos_page.dart'
    as _i4;
import '../../../splash_page/presentation/splash_page.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashPage());
    },
    SignInRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.SignInPage());
    },
    AuthorizationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizationRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.AuthorizationPage(
              authorizationUrl: args.authorizationUrl,
              onAuthorizationCodeRedirectAttemp:
                  args.onAuthorizationCodeRedirectAttemp));
    },
    StarredReposRoute.name: (routeData) {
      final args = routeData.argsAs<StarredReposRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i4.StarredReposPage(key: args.key, openDrawer: args.openDrawer));
    },
    SearchedReposRoute.name: (routeData) {
      final args = routeData.argsAs<SearchedReposRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.SearchedReposPage(
              key: args.key, searchTerm: args.searchTerm));
    },
    RepoDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RepoDetailRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.RepoDetailPage(args.repo, key: args.key));
    },
    DrawerStateRoute.name: (routeData) {
      final args = routeData.argsAs<DrawerStateRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.DrawerStatePage(
              key: args.key,
              homePage: args.homePage,
              drawerPage: args.drawerPage));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(SplashRoute.name, path: '/'),
        _i8.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i8.RouteConfig(AuthorizationRoute.name, path: '/auth'),
        _i8.RouteConfig(StarredReposRoute.name, path: '/starred'),
        _i8.RouteConfig(SearchedReposRoute.name, path: '/searched'),
        _i8.RouteConfig(RepoDetailRoute.name, path: '/detail'),
        _i8.RouteConfig(DrawerStateRoute.name, path: '/drawer')
      ];
}

/// generated route for [_i1.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for [_i2.SignInPage]
class SignInRoute extends _i8.PageRouteInfo<void> {
  const SignInRoute() : super(name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for [_i3.AuthorizationPage]
class AuthorizationRoute extends _i8.PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute(
      {required Uri authorizationUrl,
      required void Function(Uri) onAuthorizationCodeRedirectAttemp})
      : super(name,
            path: '/auth',
            args: AuthorizationRouteArgs(
                authorizationUrl: authorizationUrl,
                onAuthorizationCodeRedirectAttemp:
                    onAuthorizationCodeRedirectAttemp));

  static const String name = 'AuthorizationRoute';
}

class AuthorizationRouteArgs {
  const AuthorizationRouteArgs(
      {required this.authorizationUrl,
      required this.onAuthorizationCodeRedirectAttemp});

  final Uri authorizationUrl;

  final void Function(Uri) onAuthorizationCodeRedirectAttemp;

  @override
  String toString() {
    return 'AuthorizationRouteArgs{authorizationUrl: $authorizationUrl, onAuthorizationCodeRedirectAttemp: $onAuthorizationCodeRedirectAttemp}';
  }
}

/// generated route for [_i4.StarredReposPage]
class StarredReposRoute extends _i8.PageRouteInfo<StarredReposRouteArgs> {
  StarredReposRoute({_i9.Key? key, required void Function() openDrawer})
      : super(name,
            path: '/starred',
            args: StarredReposRouteArgs(key: key, openDrawer: openDrawer));

  static const String name = 'StarredReposRoute';
}

class StarredReposRouteArgs {
  const StarredReposRouteArgs({this.key, required this.openDrawer});

  final _i9.Key? key;

  final void Function() openDrawer;

  @override
  String toString() {
    return 'StarredReposRouteArgs{key: $key, openDrawer: $openDrawer}';
  }
}

/// generated route for [_i5.SearchedReposPage]
class SearchedReposRoute extends _i8.PageRouteInfo<SearchedReposRouteArgs> {
  SearchedReposRoute({_i9.Key? key, required String searchTerm})
      : super(name,
            path: '/searched',
            args: SearchedReposRouteArgs(key: key, searchTerm: searchTerm));

  static const String name = 'SearchedReposRoute';
}

class SearchedReposRouteArgs {
  const SearchedReposRouteArgs({this.key, required this.searchTerm});

  final _i9.Key? key;

  final String searchTerm;

  @override
  String toString() {
    return 'SearchedReposRouteArgs{key: $key, searchTerm: $searchTerm}';
  }
}

/// generated route for [_i6.RepoDetailPage]
class RepoDetailRoute extends _i8.PageRouteInfo<RepoDetailRouteArgs> {
  RepoDetailRoute({required _i10.GithubRepo repo, _i9.Key? key})
      : super(name,
            path: '/detail', args: RepoDetailRouteArgs(repo: repo, key: key));

  static const String name = 'RepoDetailRoute';
}

class RepoDetailRouteArgs {
  const RepoDetailRouteArgs({required this.repo, this.key});

  final _i10.GithubRepo repo;

  final _i9.Key? key;

  @override
  String toString() {
    return 'RepoDetailRouteArgs{repo: $repo, key: $key}';
  }
}

/// generated route for [_i7.DrawerStatePage]
class DrawerStateRoute extends _i8.PageRouteInfo<DrawerStateRouteArgs> {
  DrawerStateRoute(
      {_i9.Key? key,
      required _i9.Widget Function(void Function()) homePage,
      required _i9.Widget Function() drawerPage})
      : super(name,
            path: '/drawer',
            args: DrawerStateRouteArgs(
                key: key, homePage: homePage, drawerPage: drawerPage));

  static const String name = 'DrawerStateRoute';
}

class DrawerStateRouteArgs {
  const DrawerStateRouteArgs(
      {this.key, required this.homePage, required this.drawerPage});

  final _i9.Key? key;

  final _i9.Widget Function(void Function()) homePage;

  final _i9.Widget Function() drawerPage;

  @override
  String toString() {
    return 'DrawerStateRouteArgs{key: $key, homePage: $homePage, drawerPage: $drawerPage}';
  }
}
