import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';

import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/data/sync/stock_in_sync_service.dart';
import 'package:store_manage/core/data/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/data/services/local_product_service.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_cubit.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_state.dart';

class MockStockInRepository extends Mock implements StockInRepository {}

class MockStockInSyncService extends Mock implements StockInSyncService {}

class MockConnectivityService extends Mock implements ConnectivityService {}

class MockInventoryAdjustmentService extends Mock implements InventoryAdjustmentService {}

class MockLocalProductService extends Mock implements LocalProductService {}

void main() {
  late StockInRepository repository;
  late StockInSyncService syncService;
  late ConnectivityService connectivity;
  late InventoryAdjustmentService inventoryService;
  late LocalProductService localProductService;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    repository = MockStockInRepository();
    syncService = MockStockInSyncService();
    connectivity = MockConnectivityService();
    inventoryService = MockInventoryAdjustmentService();
    localProductService = MockLocalProductService();

    when(() => connectivity.onChanged).thenAnswer((_) => const Stream<InternetStatus>.empty());
    when(() => connectivity.isOnline).thenAnswer((_) async => true);
    when(() => syncService.syncPending()).thenAnswer((_) async {});
    when(() => syncService.enqueue(any())).thenAnswer((_) async {});
    when(() => inventoryService.applyStockIn(any(), any())).thenAnswer((_) async {});
    when(() => localProductService.addFromStockInPayload(any())).thenAnswer((_) async {});
  });

  blocTest<StockInCubit, StockInState>(
    'emits error when API base URL is not configured',
    build: () => StockInCubit(repository, syncService, connectivity, inventoryService, localProductService),
    setUp: () {
      dotenv.loadFromString(envString: '', isOptional: true);
    },
    act: (cubit) => cubit.submitStockIn({'name': 'demo'}),
    expect: () => [
      isA<StockInLoading>(),
      isA<StockInError>().having((state) => state.message, 'message', AppStrings.stockInApiNotConfigured),
    ],
    verify: (_) {
      verifyNever(() => repository.submitStockIn(any()));
      verifyNever(() => syncService.enqueue(any()));
      verifyNever(() => syncService.syncPending());
    },
  );

  blocTest<StockInCubit, StockInState>(
    'emits loaded when submit succeeds',
    build: () => StockInCubit(repository, syncService, connectivity, inventoryService, localProductService),
    setUp: () {
      dotenv.loadFromString(envString: 'API_BASE_URL=http://localhost');
      when(() => repository.submitStockIn(any())).thenAnswer((_) async => <String, dynamic>{});
    },
    act: (cubit) => cubit.submitStockIn({'name': 'demo'}),
    expect: () => [isA<StockInLoading>(), isA<StockInLoaded>()],
    verify: (_) {
      verify(() => repository.submitStockIn(any())).called(1);
      verify(() => syncService.syncPending()).called(1);
    },
  );

  blocTest<StockInCubit, StockInState>(
    'emits queued when submit fails',
    build: () => StockInCubit(repository, syncService, connectivity, inventoryService, localProductService),
    setUp: () {
      dotenv.loadFromString(envString: 'API_BASE_URL=http://localhost');
      when(() => repository.submitStockIn(any())).thenThrow(Exception('boom'));
    },
    act: (cubit) => cubit.submitStockIn({'name': 'demo'}),
    expect: () => [
      isA<StockInLoading>(),
      isA<StockInQueued>().having((state) => state.message, 'message', AppStrings.stockInQueued),
    ],
    verify: (_) {
      verify(() => repository.submitStockIn(any())).called(1);
      verify(() => syncService.enqueue(any())).called(1);
    },
  );
}
