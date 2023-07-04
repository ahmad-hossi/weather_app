import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        children: [
          SvgPicture.asset(
            AppIcons.location,
            width: 48,
            height: 48,
          ),
          const Text(
            'Location service is not Enable or don\'t have permission!',
            style:
            TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12,),
          const Text(
            'Tap here to enable Location Service and \n'
                ' get Current Location Weather \n ',
            style:
            TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Or Search City by it\'s Name \n',
            style:
            TextStyle(color: Colors.green, fontSize: 18),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}