import 'package:auto_route/auto_route.dart';

import '../../../auth/presentation/authorization_page.dart';
import '../../../auth/presentation/signin_page.dart';
import '../../../drawer/presentation/drawer_state.dart';
import '../../../github/details/presentation/repo_detail_page.dart';
import '../../../github/repos/searched_repo/presentation/searched_repos_page.dart';
import '../../../github/repos/starred_repos/presentation/starred_repos_page.dart';
import '../../../splash_page/presentation/splash_page.dart';

@MaterialAutoRouter(
  routes: [
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage, path: '/sign-in'),
    MaterialRoute(page: AuthorizationPage, path: '/auth'),
    MaterialRoute(page: StarredReposPage, path: '/starred'),
    MaterialRoute(page: SearchedReposPage, path: '/searched'),
    MaterialRoute(page: RepoDetailPage, path: '/detail'),
    MaterialRoute(page: DrawerStatePage, path: '/drawer'),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
