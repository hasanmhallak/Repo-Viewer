import 'package:dio/dio.dart';

import '../../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/github_headers_cache.dart';
import '../../../core/infrastructure/github_repo_dto.dart';
import '../../../core/infrastructure/pagination_config.dart';
import '../../core/infrastructure/repos_remote_service.dart';

class StarredRepoRemoteService extends ReposRemoteService {
  StarredRepoRemoteService(
    Dio dio,
    GithubHeadersCache headersCache,
  ) : super(dio, headersCache);

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredRepo(int page) =>
      super.getPage(
        requestUri: Uri.https(
          'api.github.com',
          '/user/starred',
          {
            'page': page.toString(),
            'per_page': PaginationConfig.itemPerPage.toString(),
          },
        ),
        jsonDataSelector: (json) => json as List<dynamic>,
        page: page,
      );
}
