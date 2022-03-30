import 'package:dio/dio.dart';

import '../../core/infrastructure/dio_extensions.dart';
import '../../core/infrastructure/remote_response.dart';
import '../../core/infrastructure/rest_api_exception.dart';
import '../../github/core/infrastructure/github_headers.dart';
import '../../github/core/infrastructure/github_headers_cache.dart';
import 'authenticated_user_dto.dart';

class AuthenticatedUserRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;
  AuthenticatedUserRemoteService(
    this._dio,
    this._headersCache,
  );

  Future<RemoteResponse<AuthenticatedUserDTO>> getUserInfo() async {
    // Create uri.
    final requestUri = Uri.https(
      'api.github.com',
      '/user',
    );

    // Getting previouse headers.
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
        // Not modified.
        return const RemoteResponse.notModified(maxPage: 0);
      } else if (response.statusCode == 200) {
        // New data.
        final headers = GithubHeaders.parse(response);
        await _headersCache.saveHeader(requestUri, headers);
        final convertedData = AuthenticatedUserDTO.fromJson(
          response.data as Map<String, dynamic>,
        );
        return RemoteResponse.withData(
          convertedData,
          maxPage: 0,
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

  // Future<RemoteResponse<int>> getStarsCount() async {
  //   // Create uri.
  //   final requestUri = Uri.https(
  //     'api.github.com',
  //     '/user/starred',
  //     {
  //       'page': '1',
  //       'per_page': '1',
  //     },
  //   );

  //   // Getting previouse headers.
  //   final previouseHeaders = await _headersCache.getHeaders(requestUri);
  //   try {
  //     final response = await _dio.getUri(
  //       requestUri,
  //       options: Options(
  //         headers: {
  //           'If-None-Match': previouseHeaders?.etag ?? '',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 304) {
  //       // Not modified.
  //       return const RemoteResponse.notModified(maxPage: 0);
  //     } else if (response.statusCode == 200) {
  //       // New data.
  //       final headers = GithubHeaders.parse(response);
  //       await _headersCache.saveHeader(requestUri, headers);
  //       return RemoteResponse.withData(
  //         // if link is null, there's no any starred repos.
  //         headers.link?.maxPageNumber ?? 0,
  //         maxPage: 0,
  //       );
  //     } else {
  //       throw RestApiException(response.statusCode);
  //     }
  //   } on DioError catch (e) {
  //     if (e.isNoConnectionError) {
  //       return const RemoteResponse.noConnection();
  //     } else if (e.response != null) {
  //       throw RestApiException(e.response?.statusCode);
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }
}
