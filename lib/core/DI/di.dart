import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:store_manage/core/logger/app_logger.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/core/offline/product/product_delete_sync_service.dart';
import 'package:store_manage/core/offline/retail/retail_sync_service.dart';
import 'package:store_manage/core/offline/stock_in/stock_in_sync_service.dart';
import 'package:store_manage/core/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/services/local_product_service.dart';
import 'package:store_manage/core/services/retail_revenue_service.dart';
import 'package:store_manage/core/storage/inventory_adjustment_storage.dart';
import 'package:store_manage/core/storage/local_product_storage.dart';
import 'package:store_manage/core/storage/retail_transaction_storage.dart';
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
  final retailTransactionBox = await Hive.openBox<List<String>>('retail_transactions');
  final inventoryAdjustmentBox = await Hive.openBox<int>('inventory_adjustments');
  final localProductBox = await Hive.openBox<List<String>>('local_products');

  di.registerLazySingleton<SecureStorageImpl>(() => secureStorage);

  di.registerLazySingleton<NetworkClient>(() => NetworkClient(di<SecureStorageImpl>()));

  di.registerLazySingleton<AppLogger>(() => AppLogger());
  di.registerLazySingleton<HomeTabCoordinator>(() => HomeTabCoordinator());

  di.registerLazySingleton<ConnectivityService>(() => ConnectivityService(Connectivity()));
  di.registerLazySingleton<OfflineQueueStorage>(() => HiveOfflineQueueStorage(stockInBox));
  di.registerLazySingleton<RetailTransactionStorage>(() => HiveRetailTransactionStorage(retailTransactionBox));
  di.registerLazySingleton<InventoryAdjustmentStorage>(() => HiveInventoryAdjustmentStorage(inventoryAdjustmentBox));
  di.registerLazySingleton<LocalProductStorage>(() => HiveLocalProductStorage(localProductBox));
  di.registerLazySingleton<InventoryAdjustmentService>(
    () => InventoryAdjustmentService(di<InventoryAdjustmentStorage>()),
  );
  di.registerLazySingleton<LocalProductService>(() => LocalProductService(di<LocalProductStorage>()));
  di.registerLazySingleton<RetailRevenueService>(
    () => RetailRevenueService(di<RetailTransactionStorage>(), di<NetworkClient>()),
  );

  di.registerLazySingleton<StockInRepository>(() => StockInRepositoryImpl(di<NetworkClient>()));
  di.registerLazySingleton<RetailRepository>(() => RetailRepositoryImpl(di<NetworkClient>()));

  di.registerLazySingleton<StockInSyncService>(
    () => StockInSyncService(
      di<OfflineQueueStorage>(),
      di<StockInRepository>(),
      di<ConnectivityService>(),
      di<LocalProductService>(),
    ),
  );
  di.registerLazySingleton<ProductDeleteSyncService>(
    () => ProductDeleteSyncService(di<OfflineQueueStorage>(), di<ProductRepository>(), di<ConnectivityService>()),
  );
  di.registerLazySingleton<RetailSyncService>(
    () => RetailSyncService(di<OfflineQueueStorage>(), di<RetailRepository>(), di<ConnectivityService>()),
  );

  di.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(di<NetworkClient>(), di<InventoryAdjustmentService>(), di<LocalProductStorage>()),
  );

  di.registerFactory<HomeCubit>(() => HomeCubit());
}
