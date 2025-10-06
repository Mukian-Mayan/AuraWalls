import 'package:aura_walls/Themes/app_theme.dart';
import 'package:flutter/material.dart';

class Layout1 extends StatelessWidget {
  final Widget? child;
  const Layout1({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                
                color: AppTheme.color5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
            ),
           if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
