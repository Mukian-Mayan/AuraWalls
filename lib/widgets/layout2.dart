import 'package:aura_walls/Themes/app_theme.dart';
import 'package:flutter/material.dart';

class Layout2 extends StatelessWidget {
  final Widget? child;
  const Layout2( {super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                
                color: AppTheme.color5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
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
