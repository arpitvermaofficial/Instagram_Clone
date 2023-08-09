import 'package:flutter/material.dart';

class Follow_Button extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color bordercolor;
  final String text;
  final Color textcolor;
  const Follow_Button(
      {Key? key,
      this.function,
      required this.backgroundColor,
      required this.bordercolor,
      required this.text, required this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: bordercolor,
              ),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Text(text,style:  TextStyle(
            color:textcolor,
            fontWeight: FontWeight.bold,
          ),),
          width: 200,
          height: 27,
        ),

      ),

    );
  }
}
