import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/constants/common_size.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AuthPage extends StatelessWidget {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );

  TextEditingController _textEditingController = TextEditingController(text: '010');

  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.white,
            title: Text(
              '전화번호 로그인',
              style: Theme.of(context).appBarTheme.toolbarTextStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(common_padding),
            child: Column(
              children: [
                Row(
                  children: [
                    ExtendedImage.asset(
                      'assets/images/brocombi_lock.png',
                      width: size.width * 0.15,
                      height: size.width * 0.15,
                    ),
                    SizedBox(
                      width: common_small_padding,
                    ),
                    Text('브로콤비는 휴대폰 번호로 가입해요.\n번호는 안전하게 보관되며\n어디에도 공개되지 않아요.'),
                  ],
                ),
                SizedBox(
                  height: common_padding,
                ),
                TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskedInputFormatter('000 0000 0000'),
                  ],
                  decoration: InputDecoration(
                    border: inputBorder,
                    focusedBorder: inputBorder,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
