import 'package:flutter/material.dart';

Color statusColor(String status) {
  // if (status == 'Alive') {
  //   return Colors.green;
  // } else if (status == 'Dead') {
  //   return Colors.red;
  // } else {
  //   return Colors.grey;
  // }

  switch (status) {
    case 'Alive':
      return Colors.green;
    case 'Dead':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
