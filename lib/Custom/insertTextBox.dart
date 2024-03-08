import 'package:flutter/material.dart';

class InsertTextBox extends StatefulWidget {
  final String content;
  TextEditingController tec;
  bool visibleStatus;
  double paddingEdge;
  int maxLine;
  double widthSize;
  
  InsertTextBox({super.key,
    required this.content,
    required this.tec,
    this.visibleStatus = false,
    this.paddingEdge = 20,
    this.maxLine = 1,
    this.widthSize = 400

  });

  @override
  State<InsertTextBox> createState() => _InsertTextBoxState();
}

class _InsertTextBoxState extends State<InsertTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.paddingEdge),
      child: SizedBox(
        width: widget.widthSize,
        child: TextField(
          maxLines: widget.maxLine,
          controller: widget.tec,
          obscureText: widget.visibleStatus,
          decoration: InputDecoration(
            labelText: widget.content,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }
}