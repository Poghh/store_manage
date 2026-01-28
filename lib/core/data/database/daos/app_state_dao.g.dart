// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state_dao.dart';

// ignore_for_file: type=lint
mixin _$AppStateDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppStateTableTable get appStateTable => attachedDatabase.appStateTable;
  AppStateDaoManager get managers => AppStateDaoManager(this);
}

class AppStateDaoManager {
  final _$AppStateDaoMixin _db;
  AppStateDaoManager(this._db);
  $$AppStateTableTableTableManager get appStateTable =>
      $$AppStateTableTableTableManager(_db.attachedDatabase, _db.appStateTable);
}
