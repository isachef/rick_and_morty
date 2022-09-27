import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../function/functions.dart';

class CustomUserCard extends StatelessWidget {
  final bool isGrid;
  final String url;
  final String status;
  final String name;
  final String species;
  final String gender;
  final Function() onTap;

  const CustomUserCard({
    Key? key,
    required this.isGrid,
    required this.url,
    required this.status,
    required this.name,
    required this.species,
    required this.gender,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGrid
        ? InkWell(
            onTap: onTap,
            child: Container(
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      width: 122.r,
                      height: 122.r,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor(status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$species, $gender',
                    style: TextStyle(
                        color: Color(0xff828282),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: 74.r,
                    height: 74.r,
                  ),
                ),
                SizedBox(width: 18.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor(status),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$species, $gender',
                      style: TextStyle(
                          color: const Color(0xff828282),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}