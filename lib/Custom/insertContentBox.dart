import 'package:flutter/material.dart';

class InsertContentBox extends StatefulWidget {
  final String content;
  TextEditingController tec;
  bool visibleStatus;
  
  InsertContentBox({super.key,
    required this.content,
    required this.tec,
    this.visibleStatus = false
  });

  @override
  State<InsertContentBox> createState() => _InsertTextBoxState();
}

class _InsertTextBoxState extends State<InsertContentBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: widget.tec,
        obscureText: widget.visibleStatus,
        decoration: InputDecoration(
          labelText: widget.content,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}