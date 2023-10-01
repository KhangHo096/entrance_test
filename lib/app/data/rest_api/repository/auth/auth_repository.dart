import 'package:entrance_test/app/data/model/auth/log_in_response.dart';
import 'package:entrance_test/app/data/model/auth/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> signUp(Map<String, dynamic> data);

  Future<LogInResponse> signIn(Map<String, dynamic> data);
}
