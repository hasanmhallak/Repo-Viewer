import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/infrastructure/dio_extensions.dart';
import '../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/rest_api_exception.dart';
import '../../core/infrastructure/github_headers.dart';
import '../../core/infrastructure/github_headers_cache.dart';

class RepoDetailRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;

  RepoDetailRemoteService(this._dio, this._headersCache);

  Future<RemoteResponse<String>> getHtml(String fullRepoName) async {
    final requestUri = Uri.https(
      'api.github.com',
      '/repos/$fullRepoName/readme',
    );

    final previouseHeaders = await _headersCache.getHeaders(requestUri);
    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            'If-None-Match': previouseHeaders?.etag ?? '',
          },
          // to make the return type as plain text because an html file is not a valid json.
          //TODO: try to accomplish this by changeing the accept headers.
          responseType: ResponseType.plain,
        ),
      );
      // Not modified
      if (response.statusCode == 304) {
        return const RemoteResponse.notModified(maxPage: 0);
        // success. New data.
      } else if (response.statusCode == 200) {
        // parsing headers.
        final headers = GithubHeaders.parse(response);
        // saving headers to local cache.
        await _headersCache.saveHeader(requestUri, headers);
        final html = response.data as String;
        return RemoteResponse.withData(html, maxPage: 0);
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

  /// Returns `null` if there's no internet connection.
  Future<bool?> getStarredStatus(String fullRepoName) async {
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred/$fullRepoName',
    );

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          validateStatus: (status) =>
              (status != null && status >= 200 && status < 400) ||
              status == 404,
        ),
      );

      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return null;
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }

  /// Dart don't have a nullable `void` so we use `Unit` to indicate that there's no internet connection.
  Future<Unit?> switchStarredStatus(
    String fullRepoName, {
    required bool isStarred,
  }) async {
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred/$fullRepoName',
    );

    try {
      final response = await (isStarred
          ? _dio.deleteUri(requestUri)
          : _dio.putUri(requestUri));
      // Success. No content.
      if (response.statusCode == 204) {
        return unit;
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return null;
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
