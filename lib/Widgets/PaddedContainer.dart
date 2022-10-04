import 'package:flutter/material.dart';

class PaddedContainer extends StatelessWidget {
  const PaddedContainer({Key? key, required this.backgroundColor, required this.child, this.constraints}) : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      constraints: constraints == null ? BoxConstraints(
        minWidth: 180
      ) : constraints,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: child,
    );
  }
}
