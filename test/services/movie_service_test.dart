import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:moviedb/core/common/constants.dart';
import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/models/video_response.dart';
import 'package:moviedb/core/providers/dio_provider.dart';
import 'package:moviedb/core/services/movie_service.dart';

import '../mock/mock_response_from_api.dart';

void main() {
  final mockDioProvider = Dio();
  final dioAdapter = DioAdapter(dio: mockDioProvider);
  mockDioProvider.httpClientAdapter = dioAdapter;
  test("Get Movie Detail By Id Success test", () async {
    const path = '${API_URL}movie/1?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, dummyDetailMovieRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    MovieDetail movieDetail = await service.getMovieById(1);
    expect(movieDetail, TypeMatcher<MovieDetail>());
  });

  test("Get Video Trailer By Id Success test", () async {
    const path = '${API_URL}movie/1/videos?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, dummyVideoTrailerRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    VideoResponse videoResponse = await service.getVideoById(1);
    expect(videoResponse, TypeMatcher<VideoResponse>());
  });

  test("Get Cast By Id Success test", () async {
    const path = '${API_URL}movie/1/credits?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, dummyCastRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    List<Actor> listActor = await service.getCastById(1);
    expect(listActor, TypeMatcher<List<Actor>>());
  });
}
