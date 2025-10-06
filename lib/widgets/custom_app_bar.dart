import 'package:flutter/material.dart';
import 'package:aura_walls/Themes/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? leadingIcon;
  final IconData? actionIcon;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onActionPressed;
  final Color? color;

  const CustomAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actionIcon,
    this.onLeadingPressed,
    this.onActionPressed, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:color, 
      elevation: 0, 
      leading: Padding(
        padding: const EdgeInsets.all(15.0),
        child: leadingIcon != null
            ? IconButton(
                icon: Icon(leadingIcon, color: AppTheme.color2),
                onPressed: onLeadingPressed,
              )
            : null,
      ),
      title: Padding(
        padding: const EdgeInsets.all(15.0),
        child: title != null
            ? Text(
                title!,
                style: TextStyle(
                  color: AppTheme.color2,
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              )
            : null,
      ),
      centerTitle: true,
      actions: [
        if (actionIcon != null)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
              icon: Icon(actionIcon, color: AppTheme.color2),
              onPressed: onActionPressed,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
