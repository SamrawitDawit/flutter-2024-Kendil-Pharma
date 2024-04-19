import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(home: KendilAppBar()));
}
class KendilAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KendilAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = true,

  });
   final Widget ? title;
   final bool showBackArrow;
   final IconData ? leadingIcon;
   final List<Widget> ? actions;
   final VoidCallback ? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(padding:  EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow ? IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_left))
        :leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,
      ),);
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
  

