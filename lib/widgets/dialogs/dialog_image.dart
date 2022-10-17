import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_network/image_network.dart';

class DialogShowImage extends StatefulWidget {
  final String imagePath;
  const DialogShowImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<DialogShowImage> createState() => _DialogShowImageState();
}

class _DialogShowImageState extends State<DialogShowImage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        height: 600,
        child: ImageNetwork(
          image: widget.imagePath,
          imageCache: CachedNetworkImageProvider(
              widget.imagePath),
          width: 600,
          height: 600,
          duration: 1500,
          curve: Curves.easeIn,
          onPointer: false,
          debugPrint: false,
          fullScreen: false,
          fitAndroidIos: BoxFit.fill,
          fitWeb: BoxFitWeb.fill,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
