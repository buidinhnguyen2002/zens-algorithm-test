import 'package:flutter/material.dart';
import 'package:mobile_test/utils/constants.dart';

class TextButtonCustom extends StatelessWidget {
  const TextButtonCustom(
      {super.key,
      required this.bgColor,
      required this.title,
      required this.onPress});
  final Color bgColor;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: const TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }
}
