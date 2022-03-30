import 'package:dio/dio.dart';

import '../../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/github_headers_cache.dart';
import '../../../core/infrastructure/github_repo_dto.dart';
import '../../../core/infrastructure/pagination_config.dart';
import '../../core/infrastructure/repos_remote_service.dart';

class SearchedRepoRemoteService extends ReposRemoteService {
  SearchedRepoRemoteService(
    Dio dio,
    GithubHeadersCache headersCache,
  ) : super(dio, headersCache);

  Future<RemoteResponse<List<GithubRepoDTO>>> getSearchedRepo(
    int page,
    String query,
  ) =>
      super.getPage(
        requestUri: Uri.https(
          'api.github.com',
          '/search/repositories',
          {
            'q': query,
            'page': page.toString(),
            'per_page': PaginationConfig.itemPerPage.toString(),
          },
        ),
        jsonDataSelector: (json) => json['items'] as List<dynamic>,
      );
}
