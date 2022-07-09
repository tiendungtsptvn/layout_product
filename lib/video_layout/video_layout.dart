import 'package:flutter/material.dart';
import 'package:layout_example/video_layout/constants/constants.dart';
import 'package:layout_example/video_layout/screens/audio_screen.dart';
import 'package:layout_example/video_layout/utils.dart';
import 'package:layout_example/video_layout/widgets/player.dart';
import 'package:miniplayer/miniplayer.dart';

ValueNotifier<AudioObject?> currentlyPlaying = ValueNotifier(null);

class VideoLayout extends StatefulWidget {
  const VideoLayout({Key? key, required this.maxHeight}) : super(key: key);
  final double maxHeight;
  @override
  State<VideoLayout> createState() => _VideoLayoutState();
}

class _VideoLayoutState extends State<VideoLayout> {
  late ValueNotifier<double> playerExpandProgress;
  final MiniplayerController controller = MiniplayerController();

  @override
  void initState() {
    playerExpandProgress = ValueNotifier(widget.maxHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  child: AudioScreen(
                    onTap: (audioObject) async {
                      if (currentlyPlaying.value != audioObject) {
                        currentlyPlaying.value = audioObject;
                        controller.animateToHeight(state: PanelState.MAX);
                        await Future.delayed(const Duration(milliseconds: 500));
                        playerExpandProgress.value = widget.maxHeight;
                      } else {
                        controller.animateToHeight(state: PanelState.MAX);
                      }
                    },
                  ),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: currentlyPlaying,
              builder: (BuildContext context, AudioObject? audioObject,
                      Widget? child) =>
                  audioObject != null
                      ? DetailedPlayer(
                          audioObject: audioObject,
                          maxHeight: widget.maxHeight,
                          playerExpandProgress: playerExpandProgress,
                          controller: controller,
                        )
                      : Container(
                          height: widget.maxHeight / 2,
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: currentlyPlaying,
        builder: (
          BuildContext context,
          AudioObject? height,
          Widget? child,
        ) {
          return ValueListenableBuilder(
            valueListenable: playerExpandProgress,
            builder: (BuildContext context, double height, Widget? child) {
              final value = percentageFromValueInRangeForAppBar(
                  min: playerMinHeight,
                  max: widget.maxHeight,
                  value: height,
                  currentPlay: currentlyPlaying);

              var opacity = 1 - value;
              if (opacity < 0) opacity = 0;
              if (opacity > 1) opacity = 1;

              return SizedBox(
                height: kBottomNavigationBarHeight -
                    kBottomNavigationBarHeight * value,
                child: Transform.translate(
                  offset: Offset(0.0, kBottomNavigationBarHeight * value * 0.5),
                  child: Opacity(
                    opacity: opacity,
                    child: OverflowBox(
                      maxHeight: kBottomNavigationBarHeight,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: Colors.blue,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books), label: 'Library'),
              ],
            ),
          );
        },
      ),
    );
  }
}
