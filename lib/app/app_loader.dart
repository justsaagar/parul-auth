import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'constant/color_constant.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: AppColorConstant.appWhite.withOpacity(0.4)),
      child: LoadingAnimationWidget.discreteCircle(size: 40, color: AppColorConstant.appBlack),
    );
  }
}
