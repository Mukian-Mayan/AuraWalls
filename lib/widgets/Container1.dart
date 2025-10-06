import 'package:flutter/material.dart';

class Container1 extends StatelessWidget {
  final IconData? textIcon;
  final IconData? secondIcon;
  final String iconText;
  final double fontSize;
  final void Function()? onTap;

  const Container1({
    super.key,
    this.secondIcon,
    this.textIcon,
    required this.iconText,
    required this.fontSize, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        width: MediaQuery.of(context).size.width * 0.89,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          //color: AppTheme.color5,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Icon(textIcon, color: Colors.white, size: fontSize),
                ), // left icon
                Text(
                  iconText,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'LeagueSpartan-Black',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Icon(secondIcon, color: Colors.white, size: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
