// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../../auth/presentation/authorization_page.dart' as _i3;
import '../../../auth/presentation/signin_page.dart' as _i2;
import '../../../github/core/domain/github_repo.dart' as _i9;
import '../../../github/details/presentation/repo_detail_page.dart' as _i6;
import '../../../github/repos/searched_repo/presentation/searched_repos_page.dart'
    as _i5;
import '../../../github/repos/starred_repos/presentation/starred_repos_page.dart'
    as _i4;
import '../../../splash_page/presentation/splash_page.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashPage());
    },
    SignInRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.SignInPage());
    },
    AuthorizationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizationRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.AuthorizationPage(
              authorizationUrl: args.authorizationUrl,
              onAuthorizationCodeRedirectAttemp:
                  args.onAuthorizationCodeRedirectAttemp));
    },
    StarredReposRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.StarredReposPage());
    },
    SearchedReposRoute.name: (routeData) {
      final args = routeData.argsAs<SearchedReposRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.SearchedReposPage(
              key: args.key, searchTerm: args.searchTerm));
    },
    RepoDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RepoDetailRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.RepoDetailPage(args.repo, key: args.key));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(SplashRoute.name, path: '/'),
        _i7.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i7.RouteConfig(AuthorizationRoute.name, path: '/auth'),
        _i7.RouteConfig(StarredReposRoute.name, path: '/starred'),
        _i7.RouteConfig(SearchedReposRoute.name, path: '/searched'),
        _i7.RouteConfig(RepoDetailRoute.name, path: '/detail')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.AuthorizationPage]
class AuthorizationRoute extends _i7.PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute(
      {required Uri authorizationUrl,
      required void Function(Uri) onAuthorizationCodeRedirectAttemp})
      : super(AuthorizationRoute.name,
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

/// generated route for
/// [_i4.StarredReposPage]
class StarredReposRoute extends _i7.PageRouteInfo<void> {
  const StarredReposRoute() : super(StarredReposRoute.name, path: '/starred');

  static const String name = 'StarredReposRoute';
}

/// generated route for
/// [_i5.SearchedReposPage]
class SearchedReposRoute extends _i7.PageRouteInfo<SearchedReposRouteArgs> {
  SearchedReposRoute({_i8.Key? key, required String searchTerm})
      : super(SearchedReposRoute.name,
            path: '/searched',
            args: SearchedReposRouteArgs(key: key, searchTerm: searchTerm));

  static const String name = 'SearchedReposRoute';
}

class SearchedReposRouteArgs {
  const SearchedReposRouteArgs({this.key, required this.searchTerm});

  final _i8.Key? key;

  final String searchTerm;

  @override
  String toString() {
    return 'SearchedReposRouteArgs{key: $key, searchTerm: $searchTerm}';
  }
}

/// generated route for
/// [_i6.RepoDetailPage]
class RepoDetailRoute extends _i7.PageRouteInfo<RepoDetailRouteArgs> {
  RepoDetailRoute({required _i9.GithubRepo repo, _i8.Key? key})
      : super(RepoDetailRoute.name,
            path: '/detail', args: RepoDetailRouteArgs(repo: repo, key: key));

  static const String name = 'RepoDetailRoute';
}

class RepoDetailRouteArgs {
  const RepoDetailRouteArgs({required this.repo, this.key});

  final _i9.GithubRepo repo;

  final _i8.Key? key;

  @override
  String toString() {
    return 'RepoDetailRouteArgs{repo: $repo, key: $key}';
  }
}
