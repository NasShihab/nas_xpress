import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_xpress/auth/login/controller/login_page.dart';
import 'package:nas_xpress/auth/sign_up/sign_up_page/controller/sign_up_controller.dart';
import 'package:nas_xpress/core/my_colors.dart';
import '../../../../core/height_width/height_width_custom.dart';
import '../../auth_widget/auth_widget.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: myOrange,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: myOrange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80.r),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image(
                      image: const AssetImage("assets/logo/launcher_icon.png"),
                      height: 70.h,
                      width: 70.w,
                    ),
                  ),
                ),
                Positioned(
                  right: 15.w,
                  bottom: 15.h,
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.secularOne(
                      color: Colors.white,
                      fontSize: 30.sp,
                    ),
                  ),
                )
              ],
            ),
            height40(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormFieldWidget(
                    onChanged: (value) {},
                    labelText: 'Email',
                    controller: controller.emailController,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  ),
                  height15(),
                  FormFieldWidget(
                    onChanged: (value) {},
                    labelText: 'Password',
                    obscureText: true,
                    controller: controller.passwordController,
                    prefixIcon: const Icon(CupertinoIcons.shield_lefthalf_fill),
                  ),
                  height15(),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: () {
                        controller.signUp();
                        // if (FirebaseAuth.instance.currentUser!.email != null) {
                          // FirebaseFirestore.instance
                          //     .collection('user_data')
                          //     .doc(FirebaseAuth.instance.currentUser!.email)
                          //     .set({
                          //   "name": '',
                          //   "age": '',
                          //   "gender": '',
                          //   "phone": '',
                          //   "address1": '',
                          //   "city": '',
                          //   "role": 'user',
                          // }).then((value) => Get.to(const DashBoard()));
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: myOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
                        child: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'SignUp',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: GoogleFonts.secularOne(fontSize: 15.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: myOrange),
                      ),
                    )
                  ],
                ),
              ),
            ),
            height30(),
          ],
        ),
      ),
    );
  }
}
