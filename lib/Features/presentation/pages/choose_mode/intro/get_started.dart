import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

import '../choose_mode.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: ExactAssetImage(AppImages.introBG),
        )),
        child: Column(
          children: [
            SvgPicture.asset(AppVectors.logo),
            const Spacer(),
            const Text(
              'Enjoy listening to music',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.',
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            BasicAppButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseModePage(),));
            }, text: "Get Started")
          ],
        ),
      ),
    );
  }
}
