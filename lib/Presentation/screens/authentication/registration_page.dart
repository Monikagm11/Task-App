import 'package:authenticationapp/Presentation/screens/authentication/login_page.dart';
import 'package:authenticationapp/bloc/register_bloc/register_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/color_constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _obscuretext = true;
  final _registerkey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  height: 350,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorConstant.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(70)),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: ColorConstant.white,
                          size: 80,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                            color: ColorConstant.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Positioned(
                top: 200,
                left: 15,
                right: 15,
                bottom: 10,
                child: Form(
                  key: _registerkey,
                  child: SingleChildScrollView(
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field cannot be empty";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0),
                              textInputAction: TextInputAction.next,
                              controller: firstnameController,
                              decoration: InputDecoration(
                                hintText: "First Name",
                                filled: true,
                                fillColor: ColorConstant.grey,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.person_outline),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field can't be empty";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0),
                              textInputAction: TextInputAction.next,
                              controller: lastnameController,
                              decoration: InputDecoration(
                                hintText: "Last Name",
                                filled: true,
                                fillColor: ColorConstant.grey,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.person_3_outlined),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field can't be empty";
                                } else if (!RegExp(
                                        r'^[\w-]+(.[\w-]+)*@[\w-]+(.[\w-]+)+$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                filled: true,
                                fillColor: ColorConstant.grey,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.mail_outline),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field can't be empty";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0),
                              textInputAction: TextInputAction.next,
                              controller: addressController,
                              decoration: InputDecoration(
                                  hintText: "Address",
                                  filled: true,
                                  fillColor: ColorConstant.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  prefixIcon:
                                      const Icon(Icons.location_on_outlined)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field can't be empty";
                                } else if (value.length != 10) {
                                  return "Enter a valid phone number";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                filled: true,
                                fillColor: ColorConstant.grey,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field can't be empty";
                                } else if (value.length < 6) {
                                  return "Password must be at least 6 digits";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0),
                              textInputAction: TextInputAction.done,
                              obscureText: _obscuretext,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                filled: true,
                                fillColor: ColorConstant.grey,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.key),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscuretext = !_obscuretext;
                                    });
                                  },
                                  icon: Icon(_obscuretext
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocListener<RegisterBloc, RegisterState>(
                              listener: (context, state) {
                                if (state is RegisterLoadingState) {
                                  BotToast.showLoading();
                                }
                                if (state is RegisterLoadedState) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(
                                      text: "You have succesfully registered");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                }
                                if (state is RegisterErrorState) {
                                  BotToast.closeAllLoading();
                                  BotToast.showText(text: state.errormessage);
                                }
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_registerkey.currentState!.validate()) {
                                    BlocProvider.of<RegisterBloc>(context).add(
                                        RegisterButtonClickedEvent(
                                            first_name:
                                                firstnameController.text,
                                            last_name: lastnameController.text,
                                            email: emailController.text,
                                            address: addressController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text));
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorConstant.blue),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 80, vertical: 15))),
                                child: const Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Already have an account?"),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ));
                                  },
                                  child: const Text(
                                    "SignIn",
                                    style: TextStyle(
                                        color: ColorConstant.blue,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
