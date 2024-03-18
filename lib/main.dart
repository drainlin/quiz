import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_application/screens/home_screen.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  const bool kIsWeb = identical(0, 0.0);
  if (kIsWeb == false) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      WidgetsFlutterBinding.ensureInitialized();
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = const WindowOptions(
        size: Size(450, 800), // 设置默认窗口大小
        minimumSize: Size(360, 640), // 设置最小窗口大小
        center: true, // 设置窗口居中
        title: "Quiz-Powered By Yulin", // 设置窗口标题
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'dana'),
      home: HomeScreen(),
    );
  }
}
