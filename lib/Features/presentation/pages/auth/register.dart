import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Features/data/models/create_user_req.dart';
import 'package:spotify/Features/presentation/pages/auth/signin.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../service_locator.dart';
import '../../../domain/use_cases/signup.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              registerText(),
              const SizedBox(height: 50),
              textField(context,
                  hintText: "Full Name", controller: fullNameController),
              const SizedBox(height: 20),
              textField(context,
                  hintText: "Enter Email", controller: emailController),
              const SizedBox(height: 20),
              textField(context,
                  hintText: "Password", controller: passwordController),
              const SizedBox(height: 50),
              BasicAppButton(
                  onPressed: () async {
                    var result = await sl<SignUpUseCase>().call(
                        params: CreateUserReq(
                      name: fullNameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    ));
                    result.fold((l) {
                      var snackBar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }, (r) {
                      var snackBar = SnackBar(content: Text(r));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  SignInPage()),
                          (route) => false);
                    });
                  },
                  text: "Create Account"),
              const SizedBox(height: 50),
              signInText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerText() {
    return const Text(
      "Register",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget textField(BuildContext context,
      {required String hintText, required TextEditingController controller}) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
        ).applyDefaults(
          Theme.of(context).inputDecorationTheme,
        ));
  }

  Widget signInText(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        "Already have an account?",
        style: TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: const Color(0xff288CE9),
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  SignInPage(),
              ));
        },
        child: const Text(
          "Sign In",
          style: TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }
}
