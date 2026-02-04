import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:store_manage/core/data/repositories/daily_sync_repository.dart';
import 'package:store_manage/core/data/repositories/store_repository.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';
import 'package:store_manage/core/data/storage/interfaces/offline_queue_storage.dart';
import 'package:store_manage/core/data/storage/local_storage.dart';
import 'package:store_manage/core/data/storage/secure_storage.dart';
import 'package:store_manage/core/data/sync/daily_sync_service.dart';
import 'package:store_manage/core/network/connectivity_service.dart';

class MockOfflineQueueStorage extends Mock implements OfflineQueueStorage {}

class MockDailySyncRepository extends Mock implements DailySyncRepository {}

class MockStoreRepository extends Mock implements StoreRepository {}

class MockConnectivityService extends Mock implements ConnectivityService {}

class MockLocalStorage extends Mock implements LocalStorage {}

class MockSecureStorage extends Mock implements SecureStorageImpl {}

class MockLocalProductService extends Mock implements LocalProductService {}

class MockInventoryAdjustmentService extends Mock implements InventoryAdjustmentService {}

void main() {
  late OfflineQueueStorage queue;
  late DailySyncRepository dailyRepo;
  late StoreRepository storeRepo;
  late ConnectivityService connectivity;
  late LocalStorage localStorage;
  late SecureStorageImpl secureStorage;
  late LocalProductService localProductService;
  late InventoryAdjustmentService inventoryAdjustmentService;

  setUpAll(() {
    registerFallbackValue(DateTime(2000));
  });

  setUp(() {
    queue = MockOfflineQueueStorage();
    dailyRepo = MockDailySyncRepository();
    storeRepo = MockStoreRepository();
    connectivity = MockConnectivityService();
    localStorage = MockLocalStorage();
    secureStorage = MockSecureStorage();
    localProductService = MockLocalProductService();
    inventoryAdjustmentService = MockInventoryAdjustmentService();

    when(() => connectivity.isOnline).thenAnswer((_) async => true);
    when(() => secureStorage.getSavedPhoneNumber()).thenAnswer((_) async => '0123456789');
    when(() => localStorage.read(any())).thenAnswer((_) async => null);
    when(() => queue.getUnsynced(any())).thenAnswer((_) async => <Map<String, dynamic>>[]);
    when(
      () => storeRepo.syncStore(
        phone: any(named: 'phone'),
        syncTime: any(named: 'syncTime'),
        syncData: any(named: 'syncData'),
      ),
    ).thenAnswer((_) async => <String, dynamic>{});
    when(() => queue.markSynced(any())).thenAnswer((_) async {});
  });

  DailySyncService buildService() {
    return DailySyncService(
      queue,
      dailyRepo,
      storeRepo,
      connectivity,
      localStorage,
      secureStorage,
      localProductService,
      inventoryAdjustmentService,
    );
  }

  group('syncStore', () {
    test('syncs only when current time allows', () async {
      final service = buildService();
      final now = DateTime.now();

      when(() => queue.getUnsynced(DailySyncService.stockInQueueKey)).thenAnswer(
        (_) async => [
          {'_queueId': 1, 'productCode': 'A'},
        ],
      );
      when(() => queue.getUnsynced(DailySyncService.retailQueueKey)).thenAnswer(
        (_) async => [
          {'_queueId': 2, 'productCode': 'B'},
        ],
      );
      when(() => queue.getUnsynced(DailySyncService.productDeleteQueueKey)).thenAnswer(
        (_) async => [
          {'_queueId': 3, 'productCode': 'C'},
        ],
      );

      await service.syncStore();

      if (now.hour < 20) {
        verifyNever(
          () => storeRepo.syncStore(
            phone: any(named: 'phone'),
            syncTime: any(named: 'syncTime'),
            syncData: any(named: 'syncData'),
          ),
        );
        verifyNever(() => queue.markSynced(any()));
      } else {
        verify(
          () => storeRepo.syncStore(
            phone: any(named: 'phone'),
            syncTime: any(named: 'syncTime'),
            syncData: any(named: 'syncData'),
          ),
        ).called(1);
        verify(() => queue.markSynced(1)).called(1);
        verify(() => queue.markSynced(2)).called(1);
        verify(() => queue.markSynced(3)).called(1);
      }
    });

    test('does not sync if already synced today', () async {
      final service = buildService();
      final now = DateTime.now();

      when(
        () => localStorage.read('last_store_sync'),
      ).thenAnswer((_) async => DateTime(now.year, now.month, now.day, 20, 5).toIso8601String());
      when(() => queue.getUnsynced(any())).thenAnswer(
        (_) async => [
          {'_queueId': 1, 'productCode': 'A'},
        ],
      );

      await service.syncStore();

      verifyNever(
        () => storeRepo.syncStore(
          phone: any(named: 'phone'),
          syncTime: any(named: 'syncTime'),
          syncData: any(named: 'syncData'),
        ),
      );
      verifyNever(() => queue.markSynced(any()));
    });
  });
}
