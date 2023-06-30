import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
          Color(0xFFEBEBF4),
        ],
        stops: [0.0, 0.35, 0.5, 0.65, 1.0],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.repeated,
      ),
      period: Duration(milliseconds: 2000),
      child: child,
    );
  }
}
