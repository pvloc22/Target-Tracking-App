import 'package:flutter/material.dart';

import '../../core/style/colors.dart';

class AppbarNewItem extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppbarNewItem({super.key, required this.title});

  @override
  State<AppbarNewItem> createState() => _AppbarNewItemState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarNewItemState extends State<AppbarNewItem> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(fontWeight: FontWeight.w600, color: colorWhite),
      ),
      backgroundColor: colorPrinciple,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: colorWhite), onPressed: () => Navigator.pop(context)),
    );
  }
}
