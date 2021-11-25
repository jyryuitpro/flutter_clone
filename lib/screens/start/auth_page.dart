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

  TextEditingController _phoneNumberController = TextEditingController(text: '010');

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        return Form(
          key: _formKey,
          child: Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      MaskedInputFormatter('000 0000 0000'),
                    ],
                    decoration: InputDecoration(
                      border: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                    validator: (phoneNumber) {
                      if(phoneNumber != null && phoneNumber.length == 13) {
                        return null;
                      } else {
                        return '전화번호를 정확하게 입력해주세요.';
                      }
                    },
                  ),
                  SizedBox(
                    height: common_small_padding,
                  ),
                  TextButton(
                    onPressed: () {
                      if(_formKey.currentState != null) {
                        bool passed = _formKey.currentState!.validate();
                        print(passed);
                      }
                    },
                    child: Text('인증문자 발송'),
                  ),
                  SizedBox(
                    height: common_padding,
                  ),
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MaskedInputFormatter('000000'),
                    ],
                    decoration: InputDecoration(
                      border: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                  ),
                  SizedBox(
                    height: common_small_padding,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('인증문자 발송'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
