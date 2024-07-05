import 'package:model_house/model_house.dart';

extension TranslationServiceExtensionMap on String {
  /// Translate the string from the Mintl.
  ///
  /// Example:
  /// ```dart
  /// 'version'.tr(args: {'#version': '1.0.0'})
  /// ```
  String get t => TranslationService.instance.tr(this);
  String tr({Map<String, dynamic>? args, int? form}) =>
      TranslationService.instance.tr(this, args: args, form: form);
}
