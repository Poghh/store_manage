import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/feature/stock_in/data/repositories/stock_in_repository.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_cubit.dart';
import 'package:store_manage/feature/stock_in/presentation/cubit/stock_in_state.dart';

class MockStockInRepository extends Mock implements StockInRepository {}

void main() {
  late StockInRepository repository;

  setUp(() {
    repository = MockStockInRepository();
  });

  blocTest<StockInCubit, StockInState>(
    'emits error when API base URL is not configured',
    build: () => StockInCubit(repository),
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
    },
  );

  blocTest<StockInCubit, StockInState>(
    'emits loaded when submit succeeds',
    build: () => StockInCubit(repository),
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
    },
  );

  blocTest<StockInCubit, StockInState>(
    'emits error when submit fails',
    build: () => StockInCubit(repository),
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
  );
}
