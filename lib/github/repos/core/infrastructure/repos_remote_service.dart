import 'package:collection/src/iterable_extensions.dart';
import 'package:dio/dio.dart';
import 'package:repo_viewer/github/core/infrastructure/pagination_config.dart';

import '../../../../core/infrastructure/dio_extensions.dart';
import '../../../../core/infrastructure/remote_response.dart';
import '../../../../core/infrastructure/rest_api_exception.dart';
import '../../../core/infrastructure/github_headers.dart';
import '../../../core/infrastructure/github_headers_cache.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

abstract class ReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;

  ReposRemoteService(
    this._dio,
    this._headersCache,
  );

  Future<RemoteResponse<List<GithubRepoDTO>>> getPage({
    // The End point to call.
    required Uri requestUri,
    // [Starred] Repos will Respond with a List<Json>
    // Where [Searched] Repos Respond with Json that has the data under the ['items'] key.
    required List<dynamic> Function(dynamic json) jsonDataSelector,
    int? page,
  }) async {
    final previouseHeaders = await _headersCache.getHeaders(requestUri);
    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            'If-None-Match': previouseHeaders?.etag ?? '',
          },
        ),
      );
      if (response.statusCode == 304) {
        return RemoteResponse.notModified(
          maxPage: previouseHeaders?.link?.maxPageNumber ?? 1,
        );
      } else if (response.statusCode == 200) {
        final headers = GithubHeaders.parse(response);
        await _headersCache.saveHeader(requestUri, headers);
        // for the starred repos, [response.data].
        // for the searched repos, [response.data['items']].
        final convertedData =
            jsonDataSelector(response.data).mapIndexed((index, e) {
          e as Map<String, dynamic>;
          // Adding ordering.
          // || 0, 1, 2 || 3, 4, 5||
          //

          e["id"] = page != null
              ? index + PaginationConfig.itemPerPage * (page - 1)
              : 0;
          return GithubRepoDTO.fromJson(e);
        }).toList();

        return RemoteResponse.withData(
          convertedData,
          // because if the repos are too few it will only be one page.
          maxPage: headers.link?.maxPageNumber ?? 1,
        );
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
