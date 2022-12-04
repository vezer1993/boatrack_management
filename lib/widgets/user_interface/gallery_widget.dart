import 'package:boatrack_management/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryWidget extends StatefulWidget {
  final List<String> images;

  const GalleryWidget({Key? key, required this.images}) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageNetwork(
              image: widget.images[index],
              imageCache: CachedNetworkImageProvider(widget.images[index]),
              height: 250,
              width: 500,
              duration: 1500,
              curve: Curves.easeIn,
              onPointer: false,
              debugPrint: false,
              fullScreen: false,
              fitWeb: BoxFitWeb.contain,
              borderRadius: BorderRadius.circular(20),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if(index > 0){
                        setState(() {
                          index--;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 25,
                      color: index == 0
                          ? CustomColors().borderColor
                          : CustomColors().primaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      if(index < (widget.images.length - 1)){
                        setState(() {
                          index++;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: 25,
                      color: index < (widget.images.length - 1)
                          ? CustomColors().primaryColor
                          : CustomColors().borderColor,
                    ))
              ],
            )
          ],
        ));
  }
}
