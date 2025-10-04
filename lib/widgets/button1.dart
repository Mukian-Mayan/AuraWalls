import 'package:aura_walls/Themes/app_theme.dart';
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String text;
  final double fontSize;
  final IconData icon;
  final void Function()? onTap;

  const Button1({
    super.key,
    required this.text,
    required this.icon,
    this.onTap, required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        height: MediaQuery.of(context).size.height*0.038,
        width: MediaQuery.of(context).size.width*0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.color5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppTheme.color2,
                fontFamily: 'LeagueSpartan-Black',
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(icon, color: AppTheme.color2,size: fontSize,),
          ],
        ),
      ),
    );
  }
}
