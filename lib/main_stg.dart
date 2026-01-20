import 'package:store_manage/main.dart';

import 'config/app_config.dart';

void main() {
  AppConfig.environment = Flavor.stg;
  mainCommon();
}
