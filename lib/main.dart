import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/screens/bottom_bar_screen.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) => MaterialApp(
          title: '',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const BottomBarScreen()),
    );
  }
}
