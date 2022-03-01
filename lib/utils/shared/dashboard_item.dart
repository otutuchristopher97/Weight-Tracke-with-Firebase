import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  String label, iconUrl;
  Function onTap;
  DashboardItem({this.label, this.onTap, this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset("$iconUrl"),
      // minLeadingWidth: 20,
      title: Text(
        "$label",
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}