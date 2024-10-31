import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../manager/theme_bloc/theme_cubit.dart';
import '../auth/signup_or_signin.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: ExactAssetImage(AppImages.chooseModeBG),
        )),
        child: Column(
          children: [
            SvgPicture.asset(AppVectors.logo),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose your mode",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().changeTheme(themeMode: ThemeMode.dark);
                          },
                          child: ClipOval(
                              child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.backgroundIMode
                                        .withOpacity(0.5),
                                    child: SvgPicture.asset(AppVectors.moon),
                                  ))),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text("Dark Mode",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.white,fontWeight: FontWeight.w500))
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              context.read<ThemeCubit>().changeTheme(themeMode: ThemeMode.light);
                            },
                            child:ClipOval(
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor:
                                    AppColors.backgroundIMode.withOpacity(0.5),
                                child: SvgPicture.asset(AppVectors.sun),
                              )),
                        )),
                        const SizedBox(
                          height: 12,
                        ),
                        Text("Light Mode",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.white,fontWeight: FontWeight.w500))
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            BasicAppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpOrSignIn(),
                      ));
                },
                text: "Continue"),
          ],
        ),
      ),
    );
  }
}
