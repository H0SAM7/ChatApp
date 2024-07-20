
import 'package:chat_app/widget/custom_indecator.dart';
import 'package:flutter/material.dart';

class CustomProgressHUD extends StatelessWidget {
  final bool inAsyncCall;
  final Widget child;
  final AlignmentGeometry indicatorAlignment;

  CustomProgressHUD({
    required this.inAsyncCall,
    required this.child,
    this.indicatorAlignment = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (inAsyncCall)
          Positioned.fill(
            child: Align(
              alignment: indicatorAlignment,
              child: CustomLoadingIndicator(),
            ),
          ),
      ],
    );
  }
}
