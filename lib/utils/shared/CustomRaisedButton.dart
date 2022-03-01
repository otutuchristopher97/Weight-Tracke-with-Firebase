import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  bool isLoading;
  String title;
  double size;
  Color titleColor, buttonColor;
  double width;
  Icon icon;
  Function onPress;
  CustomRaisedButton({
    this.icon,
    this.title,
    this.onPress,
    this.titleColor = Colors.white,
    this.buttonColor = Colors.blue,
    this.width,
    this.isLoading = false,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: width,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  width: 20,
                  height: 20,
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon != null ? icon : Text(""),
                  Text(
                    this.title,
                    style: TextStyle(color: titleColor, fontSize: size != null ? size :  20),
                  ),
                ],
              ),
        color: buttonColor,
        disabledColor: buttonColor,
        onPressed: isLoading ? null : this.onPress,
      ),
    );
  }
}
