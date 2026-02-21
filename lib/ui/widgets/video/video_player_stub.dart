import 'package:flutter/material.dart';

class VideoPlayerImplementation extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerImplementation({super.key, required this.videoUrl});

  @override
  State<VideoPlayerImplementation> createState() => _VideoPlayerImplementationState();
}

class _VideoPlayerImplementationState extends State<VideoPlayerImplementation> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
