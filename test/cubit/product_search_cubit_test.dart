import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_cubit.dart';
import 'package:store_manage/feature/product/presentation/cubit/product_search_state.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
  });

  blocTest<ProductSearchCubit, ProductSearchState>(
    'emits empty state when query is blank',
    build: () => ProductSearchCubit(repository),
    act: (cubit) => cubit.search('   '),
    expect: () => [
      isA<ProductSearchState>()
          .having((state) => state.isLoading, 'isLoading', false)
          .having((state) => state.results.length, 'results', 0)
          .having((state) => state.error, 'error', null),
    ],
  );

  blocTest<ProductSearchCubit, ProductSearchState>(
    'emits loading then filtered results when repository succeeds',
    build: () => ProductSearchCubit(repository),
    setUp: () {
      when(() => repository.searchProducts('ip')).thenAnswer(
        (_) async => const [
          Product(code: 'IP-01', name: 'iPhone'),
          Product(code: 'SS-02', name: 'Samsung'),
        ],
      );
    },
    act: (cubit) => cubit.search('ip'),
    expect: () => [
      isA<ProductSearchState>()
          .having((state) => state.isLoading, 'isLoading', true)
          .having((state) => state.error, 'error', null),
      isA<ProductSearchState>()
          .having((state) => state.isLoading, 'isLoading', false)
          .having((state) => state.results.length, 'results', 1)
          .having((state) => state.results.first.code, 'firstCode', 'IP-01'),
    ],
    verify: (_) {
      verify(() => repository.searchProducts('ip')).called(1);
    },
  );

  blocTest<ProductSearchCubit, ProductSearchState>(
    'emits loading then error when repository throws',
    build: () => ProductSearchCubit(repository),
    setUp: () {
      when(() => repository.searchProducts('ip')).thenThrow(Exception('boom'));
    },
    act: (cubit) => cubit.search('ip'),
    expect: () => [
      isA<ProductSearchState>()
          .having((state) => state.isLoading, 'isLoading', true),
      isA<ProductSearchState>()
          .having((state) => state.isLoading, 'isLoading', false)
          .having((state) => state.results.length, 'results', 0)
          .having((state) => state.error, 'error', isNotNull),
    ],
  );
}
