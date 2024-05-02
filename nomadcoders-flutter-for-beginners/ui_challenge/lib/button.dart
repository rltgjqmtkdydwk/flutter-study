import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  //property
  final String text;
  final Color bgcolor;
  final Color txtcolor;

  //constructor
  const Button({
    super.key,
    required this.text,
    required this.bgcolor,
    required this.txtcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: txtcolor,
              fontSize: 20,
            ),
          )),
    );
  }
}
