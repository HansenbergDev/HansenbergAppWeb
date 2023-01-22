import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansenberg_app_web/Widgets/PaddedContainer.dart';

// TODO: Personalet skal kunne se hvor mange der er frameldte (Frameldte, total, og frameldte før fredag)

class DayColumn extends StatefulWidget {
  const DayColumn({Key? key, required this.dateString, this.menuString})
      : super(key: key);

  final String dateString;
  final String? menuString;

  @override
  State<DayColumn> createState() => _DayColumnState();
}

class _DayColumnState extends State<DayColumn> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.menuString);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      backgroundColor: CupertinoColors.systemBackground,
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.dateString,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15,),
          TextField(
            maxLines: null,
            controller: _controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Dagens menu",
                labelStyle: TextStyle(fontStyle: FontStyle.italic)),
          )
        ],
      ),
    );
  }
}
