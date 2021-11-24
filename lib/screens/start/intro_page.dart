import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/utils/logger.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '브로콤비',
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            ExtendedImage.asset('assets/images/brocombi_intro.png'),
            Text(
              '우리 동네 중고 직거래 브로콤비',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '브로콤비는 동네 직거래 마켓이에요.\n 내 동네를 설정하고 시작해보세요!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    logger.d('on text button clicked!!!');
                  },
                  child: Text(
                    '내 동네 설정하고 시작하기',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
