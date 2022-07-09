import 'package:flutter/material.dart';

class AudioObject {
  final String title, subtitle, img, url;

  const AudioObject(this.title, this.subtitle, this.img, this.url);
}

double valueFromPercentageInRange(
    {required final double min, max, percentage}) {
  return percentage * (max - min) + min;
}

double percentageFromValueInRange({required final double min, max, value}) {
  return (value - min) / (max - min);
}
double percentageFromValueInRangeForAppBar({required final double min, max, value,required ValueNotifier currentPlay}) {
  if(currentPlay.value == null) return 0;
  return (value - min) / (max - min);
}
