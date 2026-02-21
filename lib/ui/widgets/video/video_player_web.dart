// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class VideoPlayerImplementation extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerImplementation({super.key, required this.videoUrl});

  @override
  State<VideoPlayerImplementation> createState() => _VideoPlayerImplementationState();
}

class _VideoPlayerImplementationState extends State<VideoPlayerImplementation> {
  late String _viewId;

  @override
  void initState() {
    super.initState();
    // Unique ID for each video player instance
    _viewId = 'video-player-${DateTime.now().millisecondsSinceEpoch}';
    
    // Register the video element factory
    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
      final videoElement = html.VideoElement()
        ..src = widget.videoUrl
        ..style.border = 'none'
        ..style.height = '100%'
        ..style.width = '100%'
        ..controls = true // Use native browser controls
        ..autoplay = false
        ..loop = false;
        
      return videoElement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: HtmlElementView(viewType: _viewId),
    );
  }
}
