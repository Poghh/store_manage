import 'package:store_manage/config/app_config.dart';
import 'package:store_manage/main.dart';

void main() {
  AppConfig.environment = Flavor.dev;
  mainCommon();
}
