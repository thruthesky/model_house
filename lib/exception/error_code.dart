import 'package:model_house/model_house.dart';

class ErrorCode {
  static ErrorCode? _instance;
  static ErrorCode get instance => _instance ??= ErrorCode._();
  ErrorCode._();

  UserErrorCode user = UserErrorCode();
  HouseErrorCode house = HouseErrorCode();
  ChatErrorCode chat = ChatErrorCode();
}

final code = ErrorCode.instance;
