import 'package:clean_archi_features_first/core/common/widgets/loader.dart';
import 'package:clean_archi_features_first/core/theme/app_pallete.dart';
import 'package:clean_archi_features_first/core/util/show_snackbar.dart';
import 'package:clean_archi_features_first/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_archi_features_first/features/auth/presentation/pages/singin_page.dart';
import 'package:clean_archi_features_first/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean_archi_features_first/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() {
    return _SingUpPage();
  }
}

class _SingUpPage extends State<SingUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final forKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFaliure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is Authloading) {
              return const Loader();
            }
            return Form(
              key: forKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sing Up',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(hintText: 'Email', controller: emailController),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObsecureText: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthGradientButton(
                    text: 'Sing Up',
                    onPressed: () {
                      if (forKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSingUp(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SinginPage(),
                          ));
                    },
                    child: RichText(
                      text: TextSpan(
                          text: 'Already Have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: ' Sing In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
