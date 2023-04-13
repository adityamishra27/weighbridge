import 'package:flutter/material.dart';

import '../util/colors.dart';

class appBar {
  static getAppBar(String title, BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: TextStyle(color: ColorSelect.white),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications),
        ),
      ],
    );
  }

  static getAppBar1(String title, BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: TextStyle(color: ColorSelect.white),
      ),
    );
  }
}
