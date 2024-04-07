import 'package:flutter/material.dart';
import 'package:mobile_test/utils/box_empty.dart';

class BannerApp extends StatelessWidget {
  const BannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 40, right: 40, top: 50, bottom: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          Text(
            "A joke a day keeps the doctor way",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          BoxEmpty.sizeBox25,
          Text(
            "If you joke wrong way, your teeth have to pay. (Serious)",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
