import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/network/connectivity_service.dart';
import 'package:store_manage/core/offline/stock_in/stock_in_sync_service.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_cubit.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_state.dart';

class MockStockInRepository extends Mock implements StockInRepository {}
class MockStockInSyncService extends Mock implements StockInSyncService {}
class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  late StockInRepository repository;
  late StockInSyncService syncService;
  late ConnectivityService connectivity;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    repository = MockStockInRepository();
    syncService = MockStockInSyncService();
    connectivity = MockConnectivityService();

    when(() => connectivity.onChanged).thenAnswer((_) => const Stream<ConnectivityResult>.empty());
    when(() => connectivity.isOnline).thenAnswer((_) async => true);
    when(() => syncService.syncPending()).thenAnswer((_) async {});
    when(() => syncService.enqueue(any())).thenAnswer((_) async {});
  });

  blocTest<StockInCubit, StockInState>(
    'emits error when API base URL is not configured',
    build: () => StockInCubit(repository, syncService, connectivity),
    setUp: () {
      dotenv.loadFromString(envString: '', isOptional: true);
    },
    act: (cubit) => cubit.submitStockIn({'name': 'demo'}),
    expect: () => [
      isA<StockInLoading>(),
      isA<StockInError>().having(
        (state) => state.message,
        'message',
        AppStrings.stockInApiNotConfigured,
      ),
    ],
    verify: (_) {
      verifyNever(() => repository.submitStockIn(any()));
      verifyNever(() => syncService.enqueue(any()));
      verifyNever(() => syncService.syncPending());
    },
  );

  blocTest<StockInCubit, StockInState>(
    'emits loaded when submit succeeds',
    build: () => StockInCubit(repository, syncService, connectivity),
    setUp: () {
      dotenv.loadFromString(envString: 'API_BASE_URL=http://localhost');
      when(() => repository.submitStockIn(any())).thenAnswer((_) async {});
    },
    act: (cubit) => cubit.submitStockIn({'name': 'demo'}),
    expect: () => [
      isA<StockInLoading>(),
      isA<StockInLoaded>(),
    ],
    verify: (_) {
      verify(() => repository.submitStockIn(any())).called(1);
      verify(() => syncService.syncPending()).called(1);
    },
  );

  blocTest<StockInCubit, StockInState>(
    'emits error when submit fails',
    build: () => StockInCubit(repository, syncService, connectivity),
    setUp: () {
      dotenv.loadFromString(envString: 'API_BASE_URL=http://localhost');
      when(() => repository.submitStockIn(any())).thenThrow(Exception('boom'));
    },
    act: (cubit) => cubit.submitStockIn({'name': 'demo'}),
    expect: () => [
      isA<StockInLoading>(),
      isA<StockInError>().having(
        (state) => state.message,
        'message',
        AppStrings.stockInSubmitError,
      ),
    ],
    verify: (_) {
      verify(() => repository.submitStockIn(any())).called(1);
      verifyNever(() => syncService.syncPending());
    },
  );
}
