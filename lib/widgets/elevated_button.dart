import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.maximumSize,
    this.minimumSize,
    this.disabled,
  }) : super(key: key);

  final Function() onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Size? maximumSize;
  final Size? minimumSize;
  final bool? disabled;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey,
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: backgroundColor ?? Colors.white,
          maximumSize: maximumSize,
          minimumSize: minimumSize,
        ),
        onPressed: disabled != null && disabled! ? null : onPressed,
        child: child,
      );
}
