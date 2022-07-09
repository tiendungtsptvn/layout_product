import 'package:flutter/material.dart';
import 'package:layout_example/product_layout/product_layout.dart';
import 'package:layout_example/video_layout/constants/constants.dart';
import 'package:layout_example/video_layout/video_layout.dart';
import 'package:layout_example/video_layout/widgets/video.dart';
import 'package:miniplayer/miniplayer.dart';

import '../utils.dart';


class DetailedPlayer extends StatelessWidget {
  final double maxHeight;
  final AudioObject audioObject;
  final ValueNotifier<double> playerExpandProgress;
  final MiniplayerController controller;

  const DetailedPlayer({
    Key? key,
    required this.audioObject,
    required this.maxHeight,
    required this.playerExpandProgress,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      valueNotifier: playerExpandProgress,
      minHeight: playerMinHeight,
      maxHeight: maxHeight,
      controller: controller,
      elevation: 4,
      onDismissed: () {
        currentlyPlaying.value = null;
        playerExpandProgress.value = maxHeight;
      },
      curve: Curves.easeOut,
      builder: (height, percentage) {
        final bool miniplayer = percentage < miniplayerPercentageDeclaration;
        final double width = MediaQuery.of(context).size.width;

        const buttonPlay = IconButton(
          icon: Icon(Icons.pause),
          onPressed: onTap,
        );

        const progressIndicator = LinearProgressIndicator(value: 0.3);


        //Declare additional widgets (eg. SkipButton) and variables
        if (!miniplayer) {
          var percentageExpandedPlayer = percentageFromValueInRange(
              min:
                  maxHeight * miniplayerPercentageDeclaration + playerMinHeight,
              max: maxHeight,
              value: height);
          if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;

          return Column(
            children: [
              Expanded(
                child: Opacity(
                  opacity: percentageExpandedPlayer,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child:
                        ProductLayout(
                          headerWidget:  const VideoItem(
                            url:
                            "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                          ),
                          headerHeight: width * (9 / 16),
                          miniplayerController: controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: SizedBox(
              //     child: video,
              //   ),
              // ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 33),
              //     child: Opacity(
              //       opacity: percentageExpandedPlayer,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           const Flexible(child: Text("Content")),
              //           const Flexible(child: progressIndicator),
              //           Container(),
              //           Container(),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        }

        //Miniplayer
        final percentageMiniplayer = percentageFromValueInRange(
            min: playerMinHeight,
            max: maxHeight * miniplayerPercentageDeclaration + playerMinHeight,
            value: height);

        final elementOpacity = 1 - 1 * percentageMiniplayer;
        final progressIndicatorHeight = 4 - 4 * percentageMiniplayer;

        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(
                    width: playerMinHeight * (16 / 9),
                    height: playerMinHeight,
                    child: VideoItem(
                      showControlButton: false,
                      url:
                      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Opacity(
                        opacity: elementOpacity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(audioObject.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 16)),
                            Text(
                              audioObject.subtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color!
                                        .withOpacity(0.55),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.fullscreen),
                      onPressed: () {
                        controller.animateToHeight(state: PanelState.MAX);
                      }),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Opacity(
                      opacity: elementOpacity,
                      child: buttonPlay,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: progressIndicatorHeight,
              child: Opacity(
                opacity: elementOpacity,
                child: progressIndicator,
              ),
            ),
          ],
        );
      },
    );
  }
}

void onTap() {}
