import 'package:authenticationapp/Presentation/screens/home/view_task.dart';
import 'package:authenticationapp/bloc/login_bloc/login_bloc.dart';
import 'package:authenticationapp/utils/constants/color_constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscuretext = true;
  final _key = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   passwordVisible = true;
  // }
  TextEditingController emailController =
      TextEditingController(text: "hh@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorConstant.white,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                  height: 350.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorConstant.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(70)),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: ColorConstant.white,
                          size: 80.r,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Welcome!!",
                        style: TextStyle(
                            color: ColorConstant.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Positioned(
                top: 280,
                left: 15,
                right: 15,
                bottom: 40,
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 40, 10, 40).r,
                        child: Column(
                          children: [
                            TextFormField(
                              //autofocus: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email can't be empty";
                                } else if (!RegExp(
                                        r'^[\w-]+(.[\w-]+)*@[\w-]+(.[\w-]+)+$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                decorationThickness: 0,
                              ),
                              textInputAction: TextInputAction.next,
                              controller: emailController,
                              decoration: InputDecoration(
                                // contentPadding: const EdgeInsets.symmetric(
                                //     vertical: 15, horizontal: 80),
                                hintText: "Username/Email",
                                filled: true,
                                fillColor: ColorConstant.grey,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.mail_outline),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password field can't be empty";
                                }
                                return null;
                              },
                              obscureText: _obscuretext,
                              textInputAction: TextInputAction.done,
                              controller: passwordController,
                              decoration: InputDecoration(
                                // contentPadding: const EdgeInsets.symmetric(
                                //     vertical: 15, horizontal: 80),
                                hintText: "Password",
                                filled: true,
                                fillColor: ColorConstant.grey,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.key),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscuretext
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscuretext = !_obscuretext;
                                    });
                                  },
                                  // onPressed: () {
                                  //   print(passwordVisible);

                                  //   print("cfrgvbh");
                                  //   setState() {
                                  //     passwordVisible =
                                  //         passwordVisible ? false : true;
                                  //     print(passwordVisible);
                                  //   }
                                  // },
                                  // icon: Icon(!passwordVisible
                                  //     ? Icons.visibility
                                  //     : Icons.visibility_off)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10).r,
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: ColorConstant.blue,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            BlocListener<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginLoadingState) {
                                  BotToast.showLoading();
                                }
                                if (state is LoginLoadedState) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(
                                      text: "Logged in succesfully");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ViewTaskPage()));
                                }
                                if (state is LoginErrorState) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(text: state.errormessage);
                                }
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginButtonClickedEvent(
                                            email: emailController.text,
                                            password: passwordController.text));
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                        ColorConstant.blue),
                                    padding: WidgetStateProperty.all(
                                        const EdgeInsets.symmetric(
                                                horizontal: 80, vertical: 15)
                                            .r)),
                                child: Text(
                                  "LogIn",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Don't have an account?"),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationPage(),
                                        ));
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: ColorConstant.blue,
                                        fontSize: 16.sp),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
