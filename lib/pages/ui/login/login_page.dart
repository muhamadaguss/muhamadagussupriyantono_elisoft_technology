import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/result.dart';
import '../../../cubit/login/login_cubit.dart';
import '../../../injector_container.dart';

import '../../../constants/app_constants.dart';
import '../../common/common.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.result != current.result,
        listener: (context, state) {
          if (state.result?.status == Status.COMPLETED) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.DASHBOARD, (route) => false);
          } else if (state.result?.status == Status.ERROR) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.result?.message ?? ''),
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 1000),
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.obsecure != current.obsecure ||
            previous.result != current.result,
        builder: (context, state) {
          if (state.result?.status == Status.LOADING) {
            return body(true, state);
          } else {
            return body(false, state);
          }
        },
      ),
    );
  }

  Widget body(bool isLoading, LoginState state) {
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: Center(
        child: Lottie.asset(
          'assets/json/loading.json',
          height: 200.h,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ReusableText(
                    text: 'My Apps',
                    style: appstyle(
                      36,
                      Color(kGreen.value),
                      FontWeight.bold,
                    ),
                  ),
                  const HeightSpacer(height: 20),
                  Lottie.asset(
                    'assets/json/login.json',
                    height: 300.h,
                  ),
                  const HeightSpacer(height: 50),
                  CustomTextField(
                    controller: emailController,
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const HeightSpacer(height: 20),
                  CustomTextField(
                    obscureText: state.obsecure,
                    controller: passwordController,
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        sl<LoginCubit>().changeViewPassword();
                      },
                      child: Icon(
                        state.obsecure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(kGreen.value),
                      ),
                    ),
                  ),
                  const HeightSpacer(height: 30),
                  CustomButton(
                    text: 'LOGIN',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        sl<LoginCubit>().login({
                          'email': emailController.text,
                          'password': passwordController.text,
                        });
                      }
                    },
                  ),
                  const HeightSpacer(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
