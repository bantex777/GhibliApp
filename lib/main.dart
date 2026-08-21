import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studioghibli/core/di/injection.dart';
import 'package:studioghibli/core/theme/app_colors.dart';
import 'package:studioghibli/widgets/homeScreen.dart';

void main() {
  setupDI();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Ghibli Dex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: AppColors().ghibliColors),
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(backgroundColor: Colors.transparent, elevation: 0),
          ),
          backgroundColor: const Color(0xFFF9F6ED),
          body: Home(),
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}
