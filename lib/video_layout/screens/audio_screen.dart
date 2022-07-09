import 'package:flutter/material.dart';
import '../widgets/audio_list_tile.dart';

import '../utils.dart';

const Set<AudioObject> audioExamples = {
  AudioObject('Losing It', 'FISHER',
      'https://i.ytimg.com/vi/cpB2ZMzXrss/hqdefault.jpg?s…AFwAcABBg==&rs=AOn4CLBdJ-Gyd5FLg3mMypzce3etyGJLig',
  "https://www.youtube.com/watch?v=cpB2ZMzXrss"),
  AudioObject('American Kids', 'Kenny Chesney',
      'https://i.ytimg.com/vi/fMj8Awr33js/hqdefault.jpg?s…AFwAcABBg==&rs=AOn4CLAKSiX7A8VkqXhbSAJn2L8lrZ5Mpw',
  "https://www.youtube.com/watch?v=fMj8Awr33js&t=53s"),
  AudioObject('Wake Me Up', 'Avicii',
      'https://i.ytimg.com/vi/DTRMgvt26Fg/hqdefault.jpg?s…AFwAcABBg==&rs=AOn4CLB_blgRwv4xqWPSzG7yWxcMvDdt4A',
  "https://www.youtube.com/watch?v=DTRMgvt26Fg"),
  AudioObject('Missing You', 'Mesto',
      'https://i.ytimg.com/vi/xZYHehC7TVc/hqdefault.jpg?s…AFwAcABBg==&rs=AOn4CLBwl8bYu9C6ulxMhM8VWijk0HY8IA',
  "https://www.youtube.com/watch?v=xZYHehC7TVc"),
  AudioObject('Cigarettes', 'Tash Sultana',
      'https://i.ytimg.com/vi/WABOrIYhR94/hqdefault.jpg?s…AFwAcABBg==&rs=AOn4CLAQw7u6I7Y9yH9zs9SsGKH20DfYiQ',
  "https://www.youtube.com/watch?v=WABOrIYhR94"),
  AudioObject('Ego Death', 'Ty Dolla \$ign, Kanye West, FKA Twigs, Skrillex',
      'https://i.ytimg.com/vi/JHSRTU31T14/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAI25-djfyqR2DkS0mdgNc34laB4g',
  "https://www.youtube.com/watch?v=JHSRTU31T14"),
};

class AudioScreen extends StatelessWidget {
  final Function onTap;

  const AudioScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 6, top: 15),
          child: Text('Your Library:'),
        ),
        for (AudioObject a in audioExamples)
          AudioListTile(audioObject: a, onTap: () => onTap(a))
      ],
    );
  }
}
