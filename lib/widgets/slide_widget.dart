import 'package:flutter/material.dart';
import '../models/slide_model.dart';

class SlideWidget extends StatelessWidget {
  final SlideModel slide;
  final bool isFullscreen;

  const SlideWidget({
    super.key,
    required this.slide,
    this.isFullscreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 800;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(isLargeScreen ? 80.0 : 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            slide.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: isLargeScreen ? 48 : 32,
              shadows: [
                Shadow(
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
          ),

          SizedBox(height: isLargeScreen ? 30 : 20),

          // Subtitle
          // Text(
          //   slide.subtitle,
          //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          //     fontSize: isLargeScreen ? 28 : 20,
          //     fontWeight: FontWeight.w400,
          //     // shadows: [
          //     //   Shadow(
          //     //     offset: const Offset(1, 1),
          //     //     blurRadius: 2,
          //     //     color: Colors.black.withOpacity(0.3),
          //     //   ),
          //     // ],
          //   ),
          // ),

          SizedBox(height: isLargeScreen ? 50 : 30),

          // Bullet Points
          // if (slide.bulletPoints.isNotEmpty) ...[
          //   Expanded(
          //     child: ListView.builder(
          //       itemCount: slide.bulletPoints.length,
          //       itemBuilder: (context, index) {
          //         return Padding(
          //           padding: EdgeInsets.symmetric(
          //             vertical: isLargeScreen ? 12.0 : 8.0,
          //           ),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 margin: const EdgeInsets.only(top: 8, right: 16),
          //                 width: 8,
          //                 height: 8,
          //                 decoration: const BoxDecoration(
          //                   color: Colors.white,
          //                   shape: BoxShape.circle,
          //                 ),
          //               ),
          //               Expanded(
          //                 child: Text(
          //                   slide.bulletPoints[index],
          //                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          //                     fontSize: isLargeScreen ? 24 : 18,
          //                     shadows: [
          //                       Shadow(
          //                         offset: const Offset(1, 1),
          //                         blurRadius: 2,
          //                         color: Colors.black.withOpacity(0.3),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }
}