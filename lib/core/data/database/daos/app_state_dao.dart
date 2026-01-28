import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/app_state_table.dart';

part 'app_state_dao.g.dart';

@DriftAccessor(tables: [AppStateTable])
class AppStateDao extends DatabaseAccessor<AppDatabase>
    with _$AppStateDaoMixin {
  AppStateDao(super.db);

  Future<String?> getValue(String key) async {
    final result = await (select(appStateTable)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return result?.value;
  }

  Future<void> setValue(String key, String value) async {
    await into(appStateTable).insertOnConflictUpdate(
      AppStateTableCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
  }

  Future<bool> hasKey(String key) async {
    final result = await getValue(key);
    return result != null;
  }
}
