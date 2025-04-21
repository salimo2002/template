import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class UploadedImage extends StatelessWidget {
  const UploadedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.close, color: kBlack)),
          SizedBox(width: 5),
          Container(
            width: 67,
            height: 67,
            decoration: BoxDecoration(
              border: Border.all(color: kBlacCustomk),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
