import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:get_it/get_it.dart';

import 'package:store_manage/core/data/database/app_database.dart';
import 'package:store_manage/core/data/database/daos/inventory_adjustment_dao.dart';
import 'package:store_manage/core/data/database/daos/local_product_dao.dart';
import 'package:store_manage/core/data/database/daos/offline_queue_dao.dart';
import 'package:store_manage/core/data/database/daos/retail_transaction_dao.dart';
import 'package:store_manage/core/data/storage/drift/drift_inventory_adjustment_storage.dart';
import 'package:store_manage/core/data/storage/drift/drift_local_product_storage.dart';
import 'package:store_manage/core/data/storage/drift/drift_offline_queue_storage.dart';
import 'package:store_manage/core/data/storage/drift/drift_retail_transaction_storage.dart';
import 'package:store_manage/core/logger/app_logger.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/network/network_client.dart';
import 'package:store_manage/core/data/repositories/daily_sync_repository.dart';
import 'package:store_manage/core/data/sync/daily_sync_service.dart';
import 'package:store_manage/core/data/sync/product_delete_sync_service.dart';
import 'package:store_manage/core/data/sync/retail_sync_service.dart';
import 'package:store_manage/core/data/sync/stock_in_sync_service.dart';
import 'package:store_manage/core/platform/biometric_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';
import 'package:store_manage/core/data/services/retail_revenue_service.dart';
import 'package:store_manage/core/data/storage/interfaces/inventory_adjustment_storage.dart';
import 'package:store_manage/core/data/storage/interfaces/local_product_storage.dart';
import 'package:store_manage/core/data/storage/interfaces/retail_transaction_storage.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/data/storage/interfaces/offline_queue_storage.dart';
import 'package:store_manage/core/data/storage/local_storage.dart';
import 'package:store_manage/feature/home/presentation/cubit/home_cubit.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';

final GetIt di = GetIt.instance;

Future<void> setupDI() async {
  final secureStorage = SecureStorageImpl();
  final localStorage = LocalStorageImpl();

  // Initialize Drift database
  final database = AppDatabase();

  // Create DAOs
  final localProductDao = LocalProductDao(database);
  final retailTransactionDao = RetailTransactionDao(database);
  final inventoryAdjustmentDao = InventoryAdjustmentDao(database);
  final offlineQueueDao = OfflineQueueDao(database);

  di.registerLazySingleton<AppDatabase>(() => database);
  di.registerLazySingleton<SecureStorageImpl>(() => secureStorage);
  di.registerLazySingleton<LocalStorage>(() => localStorage);

  di.registerLazySingleton<NetworkClient>(() => NetworkClient(di<SecureStorageImpl>()));

  di.registerLazySingleton<AppLogger>(() => AppLogger());
  di.registerLazySingleton<HomeTabCoordinator>(() => HomeTabCoordinator());
  di.registerLazySingleton<BiometricService>(() => BiometricService());

  di.registerLazySingleton<ConnectivityService>(() => ConnectivityService(InternetConnection()));
  di.registerLazySingleton<OfflineQueueStorage>(() => DriftOfflineQueueStorage(offlineQueueDao));
  di.registerLazySingleton<RetailTransactionStorage>(() => DriftRetailTransactionStorage(retailTransactionDao));
  di.registerLazySingleton<InventoryAdjustmentStorage>(() => DriftInventoryAdjustmentStorage(inventoryAdjustmentDao));
  di.registerLazySingleton<LocalProductStorage>(() => DriftLocalProductStorage(localProductDao));
  di.registerLazySingleton<InventoryAdjustmentService>(
    () => InventoryAdjustmentService(di<InventoryAdjustmentStorage>()),
  );
  di.registerLazySingleton<LocalProductService>(() => LocalProductService(di<LocalProductStorage>()));
  di.registerLazySingleton<RetailRevenueService>(
    () => RetailRevenueService(di<RetailTransactionStorage>(), di<NetworkClient>()),
  );

  di.registerLazySingleton<DailySyncRepository>(() => DailySyncRepository(di<NetworkClient>()));
  di.registerLazySingleton<DailySyncService>(
    () => DailySyncService(
      di<OfflineQueueStorage>(),
      di<DailySyncRepository>(),
      di<ConnectivityService>(),
      di<LocalStorage>(),
      di<SecureStorageImpl>(),
      di<LocalProductService>(),
      di<InventoryAdjustmentService>(),
    ),
  );

  di.registerLazySingleton<StockInSyncService>(() => StockInSyncService(di<DailySyncService>()));
  di.registerLazySingleton<ProductDeleteSyncService>(
    () => ProductDeleteSyncService(di<DailySyncService>(), di<ConnectivityService>()),
  );
  di.registerLazySingleton<RetailSyncService>(() => RetailSyncService(di<DailySyncService>()));

  di.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(di<NetworkClient>(), di<InventoryAdjustmentService>(), di<LocalProductStorage>()),
  );

  di.registerFactory<HomeCubit>(() => HomeCubit());
}
