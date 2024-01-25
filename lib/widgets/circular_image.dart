import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/app_colors.dart';

class CircularImage extends StatelessWidget {
  final String imageUrl;
  final double outerRadius;
  final double innerRadius;

  const CircularImage({
    super.key,
    required this.imageUrl,
    required this.outerRadius,
    required this.innerRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.buttonColor,
      radius: outerRadius,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 2 * innerRadius,
          height: 2 * innerRadius,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, _) => const SpinKitDoubleBounce(
            color: AppColors.textColor2,
            size: 14,
          ),
        ),
      ),
    );
  }
}
