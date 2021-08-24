import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/models/video_response.dart';
import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/services/movie_service.dart';

final detailMovieViewModelProvider =
    FutureProvider.autoDispose.family<MovieDetail?, int>((ref, id) {
  final api = ref.watch(movieServiceProvider);
  return api.getMovieById(id);
});

final videoTrailerViewModelProvider =
    FutureProvider.autoDispose.family<VideoResponse?, int>((ref, id) {
  final api = ref.watch(movieServiceProvider);
  return api.getVideoById(id);
});

final castViewModelProvider =
    FutureProvider.autoDispose.family<List<Actor>?, int>((ref, id) {
  final api = ref.watch(movieServiceProvider);
  return api.getCastById(id);
});
