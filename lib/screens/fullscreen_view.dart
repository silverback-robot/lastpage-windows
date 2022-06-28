import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullscreenView extends StatefulWidget {
  const FullscreenView({Key? key}) : super(key: key);

  static const routeName = '/fullscreen_view';
  @override
  State<FullscreenView> createState() => _FullscreenViewState();
}

class _FullscreenViewState extends State<FullscreenView> {
  List<String>? localFilePaths;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: FileImage(File(localFilePaths![index])),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          // heroAttributes: PhotoViewHeroAttributes(tag: localFilePaths[index].id),
        );
      },
      itemCount: localFilePaths!.length,
      // loadingBuilder: (context, event) => Center(
      //   child: Container(
      //     width: 20.0,
      //     height: 20.0,
      //     child: CircularProgressIndicator(
      //       value: event == null
      //           ? 0
      //           : event.cumulativeBytesLoaded / event.expectedTotalBytes,
      //     ),
      //   ),
      // ),
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    ));
  }
}
