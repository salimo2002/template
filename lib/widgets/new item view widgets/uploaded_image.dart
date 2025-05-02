import 'dart:io';

import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class UploadedImage extends StatefulWidget {
  const UploadedImage({super.key, this.onTap, required this.url, this.image});
  final void Function()? onTap;
  final String url;
  final String? image;
  @override
  State<UploadedImage> createState() => _UploadedImageState();
}

class _UploadedImageState extends State<UploadedImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.close, color: kBlack),
            ),
            SizedBox(width: 5),
            Container(
              width: 67,
              height: 67,
              decoration: BoxDecoration(
                border: Border.all(color: kBlacCustomk),
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  widget.url == ''
                      ? widget.image == null
                          ? SizedBox()
                          : SizedBox()
                      : Image.file(File(widget.url)),
            ),
          ],
        ),
      ),
    );
  }
}
