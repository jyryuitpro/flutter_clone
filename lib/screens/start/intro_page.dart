import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/utils/logger.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('브로콤비'),
        ExtendedImage.asset('assets/images/brocombi_intro.png'),
        Text('우리 동네 중고 직거래 브로콤비'),
        Text('브로콤비는 동네 직거래 마켓이에요.'),
        Text('내 동네를 설정하고 시작해보세요!'),
        TextButton(
          onPressed: () {
            logger.d('on text button clicked!!!');
          },
          child: Text(
            '내 동네 설정하고 시작하기',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}
