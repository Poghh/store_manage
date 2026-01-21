import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:store_manage/core/logger/app_logger.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/core/offline/retail/retail_sync_service.dart';
import 'package:store_manage/core/offline/stock_in/stock_in_sync_service.dart';
import 'package:store_manage/core/storage/secure_storage.dart';
import 'package:store_manage/core/storage/offline_queue_storage.dart';
import 'package:store_manage/feature/home/presentation/cubit/home_cubit.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/retail/data/repositories/retail_repository.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';

final GetIt di = GetIt.instance;

Future<void> setupDI() async {
  final secureStorage = SecureStorageImpl();
  final stockInBox = await Hive.openBox<List<String>>('pending_stock_in');

  di.registerLazySingleton<SecureStorageImpl>(() => secureStorage);

  di.registerLazySingleton<NetworkClient>(() => NetworkClient(di<SecureStorageImpl>()));

  di.registerLazySingleton<AppLogger>(() => AppLogger());
  di.registerLazySingleton<HomeTabCoordinator>(() => HomeTabCoordinator());

  di.registerLazySingleton<ConnectivityService>(() => ConnectivityService(Connectivity()));
  di.registerLazySingleton<OfflineQueueStorage>(() => HiveOfflineQueueStorage(stockInBox));

  di.registerLazySingleton<StockInRepository>(() => StockInRepositoryImpl(di<NetworkClient>()));
  di.registerLazySingleton<RetailRepository>(() => RetailRepositoryImpl(di<NetworkClient>()));

  di.registerLazySingleton<StockInSyncService>(
    () => StockInSyncService(di<OfflineQueueStorage>(), di<StockInRepository>(), di<ConnectivityService>()),
  );
  di.registerLazySingleton<RetailSyncService>(
    () => RetailSyncService(di<OfflineQueueStorage>(), di<RetailRepository>(), di<ConnectivityService>()),
  );

  di.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(di<NetworkClient>()));

  di.registerFactory<HomeCubit>(() => HomeCubit());
}
