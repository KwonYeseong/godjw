import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Key key;
  Widget title;
  Color backgroundColor;
  List<Widget> actions;
  Widget bottom;
  bool automaticallyImplyLeading;
  Widget leading;

  CustomAppBar(
      {this.key,
      this.title,
      this.backgroundColor,
      this.actions,
      this.bottom,
      this.automaticallyImplyLeading = true,
      this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      title: title,
      backgroundColor: Colors.white,
      actions: actions,
      elevation: 0,
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(
            child: bottom,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffEAEAEA),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          )),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
