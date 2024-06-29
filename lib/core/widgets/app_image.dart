import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
  }) : super(key: key);

  final String imageUrl;
  final double width;
  final double height;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(

      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeftRadius),
        topRight: Radius.circular(topRightRadius),
        bottomRight: Radius.circular(bottomRightRadius),
        bottomLeft: Radius.circular(bottomLeftRadius),
      ),
      child: CachedNetworkImage(


        fit: BoxFit.fill,
        width: width,
        height: height,
        imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Image.asset(
            width: 0.5.w,
            height:1.h ,
            "assets/images/loading.gif",
          );
        },
        errorWidget: (context, url, error) => Padding(


          padding: EdgeInsets.all(15.sp),
          child: const Icon(
            Icons.error,
            // color: Colors.red,
          ),
        ),
        // const SizedBox(
        //     width: double.infinity,
        //     child: Icon(Icons.error)),
      ),
    );
  }
}