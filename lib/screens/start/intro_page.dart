import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('브로콤비'),
        ExtendedImage.asset('assets/images/brocombi_intro.png'),
      ],
    );
  }
}
