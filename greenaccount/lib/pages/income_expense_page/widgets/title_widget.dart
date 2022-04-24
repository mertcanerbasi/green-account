import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final double amount;
  const TitleWidget({Key? key, required this.title, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 2, color: primaryOrange),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const Spacer(),
            Text(
              amount.toString(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
