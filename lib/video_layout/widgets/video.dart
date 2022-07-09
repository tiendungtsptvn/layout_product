import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String url;
  final double? aspectRatio;
  final bool? showControlButton;
  const VideoItem({Key? key, required this.url, this.aspectRatio, this.showControlButton})
      : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void didChangeDependencies() {
    initializePlayer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    if (widget.url.isNotEmpty) {
      _videoPlayerController = VideoPlayerController.network(widget.url);
      await Future.wait([_videoPlayerController!.initialize()]);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoInitialize: true,
        aspectRatio: 16/9,
        // showControls: false,
        showOptions: widget.showControlButton ?? true,
        showControls: widget.showControlButton ?? true,

        // hideControlsTimer: const Duration(days: 1),

        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized)
        ? Wrap(

      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: Chewie(
            controller: _chewieController!,
          ),
        )
      ],
    )
        : const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
