import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';

final userImageNotifier = ValueNotifier<String>(
  AppPreferences.getUserImageUrl(),
);
