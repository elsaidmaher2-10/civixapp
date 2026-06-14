import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shimmer/shimmer.dart';

class AppVideoPlayer extends StatefulWidget {
  final String dataSource;
  final bool isRemote;
  final VoidCallback? onTap;

  const AppVideoPlayer({
    super.key,
    required this.dataSource,
    this.isRemote = true,
    this.onTap,
  });

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = widget.isRemote
        ? VideoPlayerController.networkUrl(Uri.parse(widget.dataSource))
        : VideoPlayerController.file(File(widget.dataSource));

    try {
      await _controller.initialize();
      if (mounted) {
        setState(() => _isInitialized = true);
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return _buildShimmerLoading();
    }

    return GestureDetector(
      onTap: widget.onTap ??
          () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            if (!_controller.value.isPlaying)
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black45,
                child: Icon(Icons.play_arrow, color: Colors.white, size: 35),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
