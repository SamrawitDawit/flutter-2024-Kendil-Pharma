import 'package:flutter/material.dart';
import '../screens/order_list.dart';

void main() {
  runApp(MaterialApp(home: KendilAppBar()));
}

class KendilAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KendilAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = true,
  }) : super(key: key);

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_left),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                  )
                : null,
        title: Align(
          alignment: Alignment.centerLeft,
          child: title,
        ),
        actions: actions != null
            ? [...actions!, IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderScreen()),
          );
            })]
            : [IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderScreen()),
          );
            })],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 24.0);
}