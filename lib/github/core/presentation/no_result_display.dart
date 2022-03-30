import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class NoResultDisplay extends StatelessWidget {
  final String message;
  const NoResultDisplay({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/no_data.svg',
          height: 100.w,
        ),
        Text(
          "That's about everything we could find in your starred repos right now.",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
