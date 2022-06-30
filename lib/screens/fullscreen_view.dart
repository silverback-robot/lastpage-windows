import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:lastpage/models/lastpage_colors.dart';
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
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _visible = false;
        });
      }
    });
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

  var previewIdx = 0;
  var _visible = false;

  @override
  Widget build(BuildContext context) {
    UserUploadInfo uploadInfo =
        ModalRoute.of(context)!.settings.arguments as UserUploadInfo;
    List<String> localFilePaths = uploadInfo.localFilePaths!;
    var maxIdx = localFilePaths.length - 1;
    return MouseRegion(
      onHover: (event) {
        if (mounted && !_visible) {
          setState(() {
            _visible = true;
          });
        }
        Future.delayed(const Duration(seconds: 5), (() {
          if (mounted && _visible) {
            setState(() {
              _visible = false;
            });
          }
        }));
      },
      child: Stack(children: [
        Container(
          child: PhotoView(
            imageProvider: FileImage(
              File(localFilePaths[previewIdx]),
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 25,
          child: Visibility(
            visible: _visible,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  // width: 1.0,
                  color: LastpageColors.lightGrey,
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: LastpageColors.white,
              ),
              child: Center(
                child: Column(children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _toggleFullScreen(false);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CLOSE"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                LastpageColors.lightGrey),
                          ),
                          onPressed: previewIdx > 0
                              ? () {
                                  if (previewIdx > 0) {
                                    setState(() {
                                      previewIdx -= 1;
                                    });
                                  }
                                }
                              : null,
                          child: const Icon(Icons.arrow_left),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                LastpageColors.lightGrey),
                          ),
                          onPressed: previewIdx < maxIdx
                              ? () {
                                  if (previewIdx < maxIdx) {
                                    setState(() {
                                      previewIdx += 1;
                                    });
                                  }
                                }
                              : null,
                          child: const Icon(Icons.arrow_right),
                        ),
                      ]),
                ]),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
