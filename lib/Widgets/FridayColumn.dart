import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansenberg_app_web/Widgets/PaddedContainer.dart';

class FridayColumn extends StatelessWidget {
  const FridayColumn(
      {Key? key, required this.dateString, required this.enlistedNumber})
      : super(key: key);

  final String dateString;
  final int enlistedNumber;

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
        backgroundColor: CupertinoColors.systemBackground,
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateString,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const Text(
                  "Tilmeldte: ",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  enlistedNumber.toString(),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            )
          ],
        ));
  }
}
