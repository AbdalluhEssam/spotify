import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Features/presentation/pages/auth/register.dart';
import 'package:spotify/Features/presentation/pages/auth/signin.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/configs/theme/app_colors.dart';

class SignUpOrSignIn extends StatelessWidget {
  const SignUpOrSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
          alignment: AlignmentDirectional.bottomStart,
          image: ExactAssetImage(AppImages.authBG),
        )),
        child: Stack(
          children: [
            const BasicAppBar(),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: SvgPicture.asset(
                AppVectors.topPattern,
                alignment: AlignmentDirectional.topEnd,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: SvgPicture.asset(
                AppVectors.bottomPattern,
                alignment: AlignmentDirectional.topEnd,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Enjoy listening to music",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    "Spotify is a proprietary Swedish audio streaming and media services provider ",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: BasicAppButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  SignUpPage(),
                                    ));
                              },
                              text: "Register")),
                      const SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: BasicAppButton(
                              color: Colors.transparent,
                              elevation: 0,
                              textColor: context.isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  SignInPage(),
                                    ));
                              },
                              text: "Sign in")),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
