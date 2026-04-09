import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final Authcontroller controller = Get.find<Authcontroller>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 Background Gradient
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: screenWidth * 0.9,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                                      
                        border: Border.all(
                          color: TheColors.yellow,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    
                      /// 📦 FORM CONTENT
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// LOGO
                            Image.asset(
                              "assets/image/hr.png",
                              width: 100,
                              height: 100,
                            ),
                    
                            const SizedBox(height: 20),
                    
                            /// PHONE
                            CustomTextField(
                              controller: phoneController,
                              hintText: "លេខទូរសព្ទ",
                              prefixIcon: Icons.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "សូមបញ្ចូលលេខទូរសព្ទ";
                                }
                                return null;
                              },
                            ),
                    
                            const SizedBox(height: 15),
                    
                            /// PASSWORD
                            CustomTextField(
                              controller: passwordController,
                              hintText: "លេខកូដ",
                              prefixIcon: Icons.lock,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "សូមបញ្ចូលលេខកូដ";
                                }
                                return null;
                              },
                            ),
                    
                            const SizedBox(height: 25),
                    
                            /// BUTTON
                            Obx(() {
                              return SizedBox(
                                width: double.infinity,
                                child: CustomElevatedButton(
                                  text: controller.isLoading.value
                                      ? "កំពុងភ្ជាប់..."
                                      : "ចូល",
                                  onPressed: controller.isLoading.value
                                      ? () {}
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            controller.login(
                                              phone: phoneController.text,
                                              password:
                                                  passwordController.text,
                                            );
                                          }
                                        },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}