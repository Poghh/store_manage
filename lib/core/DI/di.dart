import 'package:get_it/get_it.dart';

import 'package:store_manage/core/logger/app_logger.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/core/storage/secure_storage.dart';
import 'package:store_manage/feature/home/presentation/cubit/home_cubit.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';

final GetIt di = GetIt.instance;

Future<void> setupDI() async {
  final secureStorage = SecureStorageImpl();

  di.registerLazySingleton<SecureStorageImpl>(() => secureStorage);

  di.registerLazySingleton<NetworkClient>(() => NetworkClient(di<SecureStorageImpl>()));

  di.registerLazySingleton<AppLogger>(() => AppLogger());

  di.registerLazySingleton<StockInRepository>(() => StockInRepositoryImpl(di<NetworkClient>()));

  di.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(di<NetworkClient>()));

  di.registerFactory<HomeCubit>(() => HomeCubit());
}
