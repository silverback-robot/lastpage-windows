import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:lastpage/models/user_uploads/user_upload_info.dart';
import 'package:photo_view/photo_view.dart';

class FullscreenView extends StatefulWidget {
  const FullscreenView({Key? key}) : super(key: key);

  static const routeName = '/fullscreen_view';
  @override
  State<FullscreenView> createState() => _FullscreenViewState();
}

class _FullscreenViewState extends State<FullscreenView> {
  @override
  void initState() {
    _toggleFullScreen(true);
    super.initState();
  }

  @override
  void dispose() {
    _toggleFullScreen(false);
    super.dispose();
  }

  Future<void> _toggleFullScreen(bool enterFullScreen) async {
    if (enterFullScreen) {
      await Window.enterFullscreen();
    } else {
      await Window.exitFullscreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    UserUploadInfo uploadInfo =
        ModalRoute.of(context)!.settings.arguments as UserUploadInfo;
    List<String> localFilePaths = uploadInfo.localFilePaths!;
    var idx = 0;
    return Container(
      child: PhotoView(
        imageProvider: FileImage(
          File(localFilePaths[idx]),
        ),
      ),
    );
  }
}
