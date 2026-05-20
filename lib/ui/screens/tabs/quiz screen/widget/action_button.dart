import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Color iconColor;
  final VoidCallback? onTap;          // NEW: callback from outside

  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textStyle,
    required this.iconColor,
    this.onTap,                       // NEW: optional so nothing breaks
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return InkWell(
      onTap: onTap,                   // CHANGED: was () {} — now uses the callback
      borderRadius: BorderRadius.circular(width * 0.1),
      child: Container(
        width: double.infinity,
        height: height * 0.07,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(width * 0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: width * 0.05),
            SizedBox(width: width * 0.02),
            Text(text, style: textStyle),
          ],
        ),
      ),
    );
  }
}