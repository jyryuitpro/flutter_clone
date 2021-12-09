import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/state/user_provider.dart';
import 'package:flutter_clone/utils/logger.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // logger.d('current user state: ${context.read<UserProvider>().userState}');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width - 32;
        final sizeOfPosImg = imgSize * 0.1;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '브로콤비',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: imgSize,
                  height: imgSize,
                  child: Stack(
                    children: [
                      ExtendedImage.asset('assets/images/brocombi_intro.png'),
                      Positioned(
                        left: imgSize * 0.45,
                        width: sizeOfPosImg,
                        top: imgSize * 0.45,
                        height: sizeOfPosImg,
                        child: ExtendedImage.asset(
                            'assets/images/brocombi_intro_position.png'),
                      ),
                    ],
                  ),
                ),
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
                      onPressed: () async {
                        context.read<PageController>().animateToPage(1, duration: Duration(microseconds: 500), curve: Curves.ease);
                        logger.d('on text button clicked!!!');
                        // var response = await Dio().get('https://randomuser.me/api/');
                        // logger.d(response);
                      },
                      child: Text(
                        '내 동네 설정하고 시작하기',
                        style: Theme.of(context).textTheme.button,
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
