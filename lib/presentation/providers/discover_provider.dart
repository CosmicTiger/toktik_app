import 'package:flutter/material.dart';
import 'package:toktik_app/domain/entities/video_post.dart';
import 'package:toktik_app/infrastructure/models/local_video_model.dart';

class DiscoverProvider extends ChangeNotifier {
  /// TODO: Repository
  /// TODO: DataSource

  bool initialLoading = true;

  /// NOTE: This is because as Provider workout as a Singleton we need to have some form to check if the videos are getting loaded.

  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<VideoPost> newVideos = videos
        .map((video) => LocalVideoModel.fromJson(video as Map<String, dynamic>)
            .toVideoPostEntity())
        .toList();

    videos.addAll(newVideos);
    notifyListeners();
  }
}
