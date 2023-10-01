import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/model/auth/log_in_response.dart';
import 'package:entrance_test/app/data/model/auth/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/signup')
  Future<UserModel> signUp(@Body() Map<String, dynamic> data);

  @POST('/auth/signin')
  Future<LogInResponse> signIn(@Body() Map<String, dynamic> data);
}
