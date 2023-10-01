import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  SignUpRequest({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
