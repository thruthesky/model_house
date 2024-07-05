import 'package:model_house/model_house.dart';

/// [iam] and [i] are the simple aliases of UserService.instance
UserService get iam => UserService.instance;
UserService get i => iam;

/// [my] is the simple alias of [iam.user]
User? get my => iam.user;
