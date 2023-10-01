import 'package:entrance_test/app/modules/sign_up/widgets/sign_up_input.dart';
import 'package:entrance_test/app/msc/colors.dart';
import 'package:entrance_test/app/msc/text_styles.dart';
import 'package:entrance_test/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: [
            _banner(),
            _blackOverlay(),
            _body(),
            _backButton(),
            _loadingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _loadingOverlay() {
    return Obx(
      () => Visibility(
        visible: controller.loading.value,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(
              color: colorMain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _blackOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.5, 0.9],
            colors: [
              Colors.black,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Positioned.fill(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * .3),
              _BodyPadding(
                child: _getStarted(),
              ),
              SizedBox(height: 42.dp),
              _email(),
              SizedBox(height: 26.dp),
              _password(),
              _legalCheck(),
              _termsAndConditions(),
              SizedBox(height: 26.dp),
              _signUpBtn(),
              SizedBox(height: 30.dp),
            ],
          ),
        ),
      ),
    );
  }

  _BodyPadding _signUpBtn() {
    return _BodyPadding(
      child: Row(
        children: [
          Text(
            'Sign Up',
            style: text16.white,
          ),
          const Spacer(),
          _nextButton(),
        ],
      ),
    );
  }

  _BodyPadding _termsAndConditions() {
    return _BodyPadding(
      child: RichText(
        text: TextSpan(
          text: 'By clicking Sign Up, you are indicating that you have '
              'read and agree to the ',
          style: text12.whiteTrans50,
          children: [
            TextSpan(
              text: 'Terms of Service',
              style: text12.mainColor,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
              text: ' and ',
              style: text12.whiteTrans50,
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: text12.mainColor,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
    );
  }

  _BodyPadding _password() {
    return _BodyPadding(
      child: Obx(
        () => PasswordInput(
          passwordValid: controller.passwordValid.value,
          passwordLevel: controller.passwordLevel.value,
          onChanged: (value) {
            controller.password.value = value;
          },
        ),
      ),
    );
  }

  _BodyPadding _email() {
    return _BodyPadding(
      child: Obx(
        () => EmailInput(
          emailValid: controller.emailValid.value,
          emailError: controller.emailError.value,
          onChanged: (value) {
            controller.email.value = value;
          },
        ),
      ),
    );
  }

  Padding _legalCheck() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.dp).copyWith(
        top: 50.dp,
        bottom: 28.dp,
      ),
      child: Obx(
        () => Row(
          children: [
            SizedBox(
              width: 24.dp,
              height: 24.dp,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.dp),
                ),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(
                    width: 1.dp,
                    color: colorMain,
                  ),
                ),
                value: controller.legalAgeChecked.value,
                onChanged: (value) {
                  controller.legalAgeChecked.value = value ?? false;
                  controller.validateForm();
                },
                checkColor: Colors.white,
                activeColor: Colors.transparent,
              ),
            ),
            SizedBox(width: 4.dp),
            Text(
              'I am over 16 years of age',
              style: text16.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nextButton() {
    return Obx(
      () => _NextButton(
        onTap: controller.onSubmit,
        enabled: controller.validForm.value,
      ),
    );
  }

  Text _getStarted() {
    return Text(
      'Let’s get you started!',
      style: textTitle.white,
    );
  }

  Widget _backButton() {
    return Positioned(
      top: 0,
      left: 0,
      child: SafeArea(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 18.dp,
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Assets.images.imgSignUpBanner.image(),
    );
  }
}

class _BodyPadding extends StatelessWidget {
  final Widget child;

  const _BodyPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}

class _NextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;

  const _NextButton({required this.onTap, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27),
            ),
          ),
        ),
        onPressed: () {
          if (enabled) {
            onTap.call();
          }
        },
        child: SvgPicture.asset(
          Assets.icons.icSignUpBtn,
          width: 54.dp,
          height: 54.dp,
        ),
      ),
    );
  }
}
