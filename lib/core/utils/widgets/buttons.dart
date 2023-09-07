import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? minWidth;
  final bool? isHost;
  final VoidCallback? onTap;
  final Color? color;
  final String ? icon;
  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color,
    this.titleColor,
    this.minWidth,
    this.isHost, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      disabledColor: color,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      minWidth: minWidth ?? MediaQuery.of(context).size.width,
      height: 42,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null)
           Image.asset(icon!,width: 20,height: 20,),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: titleColor,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
