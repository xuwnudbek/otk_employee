import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otk_employee/services/storage_service.dart';
import 'package:otk_employee/ui/auth/login_page.dart';
import 'package:otk_employee/ui/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _splashTime() async {
    await Future.delayed(const Duration(seconds: 2));

    String token = StorageService.read('token') ?? '';
    Map user = StorageService.read('user') ?? {};

    bool isLoggedOut = token.isNotEmpty && user.isNotEmpty;

    if (!isLoggedOut) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  @override
  void initState() {
    super.initState();
    _splashTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
