import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUserInkwel extends StatelessWidget {
  const CustomUserInkwel({
    Key? key,
    required this.onTap,
    required this.title,
    required this.info,
  }) : super(key: key);

  final String title;
  final String info;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 5.h),
              Text(info)
            ],
          ),
          Icon(Icons.arrow_forward_ios_sharp),
        ],
      ),
    );
  }
}
