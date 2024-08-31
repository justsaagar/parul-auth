import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImageAsset extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;

  const AppImageAsset({super.key, required this.image, this.fit, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return image.split('.').last != 'svg'
        ? Image.asset(image, fit: fit, height: height, width: width, color: color)
        : SvgPicture.asset(image, height: height, width: width);
  }
}
