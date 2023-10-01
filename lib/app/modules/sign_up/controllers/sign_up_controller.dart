import 'package:entrance_test/app/data/model/auth/sign_in_request.dart';
import 'package:entrance_test/app/data/model/auth/sign_up_request.dart';
import 'package:entrance_test/app/data/rest_api/repository/impl/auth/auth_repository_impl.dart';
import 'package:entrance_test/app/data/utils/storage_utils.dart';
import 'package:entrance_test/app/modules/home/views/home_view.dart';
import 'package:entrance_test/app/modules/sign_up/widgets/sign_up_input.dart';
import 'package:entrance_test/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final email = ''.obs;
  final emailValid = false.obs;
  final emailError = ''.obs;
  final password = ''.obs;
  final passwordValid = false.obs;
  final passwordLevel = Rx<PasswordLevel?>(null);
  final legalAgeChecked = false.obs;
  final validForm = false.obs;

  final _authRepo = Get.find<AuthRepositoryImpl>();
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email.listen((value) {
      _validateEmail(value);
      validateForm();
    });

    password.listen((value) {
      _validatePassword(value);
      validateForm();
    });
  }

  _validateEmail(String value) {
    emailValid.value = value.isEmail;
    if (value.isEmpty) {
      emailError.value = 'Email is required!';
    } else if (!value.isEmail) {
      emailError.value = 'Email is not valid!';
    } else {
      emailError.value = '';
    }
  }

  _validatePassword(String value) {
    if (value.trim().isEmpty) {
      passwordLevel.value = PasswordLevel.empty;
    } else {
      ///Password length between 6-18
      if (GetUtils.isLengthBetween(value.trim(), 6, 18)) {
        passwordValid.value = true;
        if (_hasNumber(value) &&
            _hasUppercaseLetter(value) &&
            _hasSpecialCharacter(value)) {
          passwordLevel.value = PasswordLevel.strong;
        } else if (_hasNumber(value) && _hasUppercaseLetter(value)) {
          passwordLevel.value = PasswordLevel.good;
        } else if (_hasUppercaseLetter(value)) {
          passwordLevel.value = PasswordLevel.fair;
        } else {
          passwordLevel.value = PasswordLevel.weak;
        }
      } else {
        passwordValid.value = false;
        if (value.trim().length < 6) {
          passwordLevel.value = PasswordLevel.tooShort;
        } else {
          passwordLevel.value = PasswordLevel.tooLong;
        }
      }
    }
  }

  validateForm() {
    if (passwordValid.isTrue && emailValid.isTrue && legalAgeChecked.isTrue) {
      validForm.value = true;
    } else {
      validForm.value = false;
    }
  }

  bool _hasUppercaseLetter(String value) {
    return GetUtils.hasCapitalletter(value.trim());
  }

  bool _hasNumber(String value) {
    return value.trim().contains(RegExp(r'[0-9]'));
  }

  bool _hasSpecialCharacter(String value) {
    return value.trim().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  onSubmit() async {
    loading.value = true;
    final request = SignUpRequest(
      email: email.value,
      password: password.value,
      firstName: 'Khang',
      lastName: 'Ho',
    );

    final response = await _authRepo.signUp(request.toJson());
    if (response.success()) {
      final signInRequest = SignInRequest(
        email: email.value,
        password: password.value,
      );
      final logInResponse = await _authRepo.signIn(signInRequest.toJson());
      loading.value = false;
      if (logInResponse.success()) {
        Get.find<StorageUtils>().setToken(logInResponse.accessToken ?? '');
        Get.offNamed(Routes.HOME);
      } else {
        ///TODO - Handle sign in error here
      }
    } else {
      loading.value = false;
      ///TODO - Handle sign up error here
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
