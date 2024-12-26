import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;
  const ButtonSubmit({Key? key, required this.btnText, required this.onBtnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.blue,
      child: MaterialButton(
        onPressed: () {
          onBtnPressed();
        },
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          btnText,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
