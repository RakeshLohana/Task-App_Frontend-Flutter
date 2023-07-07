import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
final VoidCallback onTap;
final   bool isLoading;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double border;
  
   ActionButton({super.key, required this.text, required this.backgroundColor, required this.textColor, required this.isLoading, required this.onTap,this.border=30});

  @override
  Widget build(BuildContext context) {
    return InkWell(
  onTap: onTap,
  child: Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    height: MediaQuery.of(context).size.height / 14,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(border),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Center(
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
    ),
  ),
);

  }
}