import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TextBig extends StatelessWidget {
  final String msg;
  final int? ta;
  final Color? clr;
  const TextBig({super.key, required this.msg, this.clr, this.ta = 0});

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      textAlign: ta == 0
          ? TextAlign.left
          : ta == 1
              ? TextAlign.center
              : TextAlign.end,
      style: TextStyle(
          color: clr ?? Theme.of(context).colorScheme.onPrimary,
          fontSize: ResponsiveValue(
            context,
            conditionalValues: [
              Condition.equals(name: MOBILE, value: 19.0),
              Condition.equals(name: TABLET, value: 21.0),
              Condition.equals(name: '2K', value: 25.0),
              Condition.equals(name: '4K', value: 30.0),
            ],
          ).value,
          fontWeight: FontWeight.w900,
          ),
          softWrap: true,
    );
  }
}
