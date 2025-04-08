import 'package:flutter/material.dart';

class FatwaTile extends StatefulWidget {
  final String title;
  final String? content;

  const FatwaTile({super.key, required this.title, this.content});

  @override
  State<FatwaTile> createState() => _FatwaTileState();
}

class _FatwaTileState extends State<FatwaTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 243, 243, 243),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Color(0xFFB7AD9F),
          width: 1,
        ),
      ),
      elevation: 1,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Image.asset(
            'images/fatwas.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onExpansionChanged: (value) => setState(() => isExpanded = value),
          children: widget.content != null
              ? [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(widget.content!,
                        style: const TextStyle(color: Colors.black54)),
                  ),
                ]
              : [],
        ),
      ),
    );
  }
}
