import 'package:flutter/material.dart';

class ImageTextWidget extends StatelessWidget {
  const ImageTextWidget({
    required this.imagePath, 
    required this.buttonText, 
    required this.onPressed, 
    super.key,
  });

  final String imagePath;
  final String buttonText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30, 
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}
