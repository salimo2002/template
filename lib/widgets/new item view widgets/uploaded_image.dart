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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xffeaeaea),
              border: Border.all(color: Color(0xffbbbbbb)),
              shape: BoxShape.circle,
            ),
            child:
                widget.url == ''
                    ? widget.image == null
                        ? Icon(Icons.camera_alt_outlined, color: Colors.grey)
                        : SizedBox()
                    : CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: FileImage(File(widget.url)),
                    ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(.5),
              decoration: BoxDecoration(
                color: Color(0xffbbbbbb),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: kWhite,
                child: Icon(Icons.edit, size: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
