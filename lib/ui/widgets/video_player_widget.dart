import 'package:flutter/material.dart';

import 'video/video_player_stub.dart'
    if (dart.library.io) 'video/video_player_native.dart'
    if (dart.library.html) 'video/video_player_web.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return VideoPlayerImplementation(videoUrl: videoUrl);
  }
}
