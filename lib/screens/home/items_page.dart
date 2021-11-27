import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Image.network('https://picsum.photos/100'),
            Expanded(
              child: Column(),
            ),
          ],
        );
      },
    );
  }
}
