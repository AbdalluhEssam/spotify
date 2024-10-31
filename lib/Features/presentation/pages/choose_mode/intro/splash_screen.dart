import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';

import 'get_started.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppVectors.logo),
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GetStarted(),));
      },
    );
  }
}
