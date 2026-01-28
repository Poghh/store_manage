// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalProductsTableTable extends LocalProductsTable
    with TableInfo<$LocalProductsTableTable, LocalProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProductsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productCodeMeta = const VerificationMeta(
    'productCode',
  );
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
    'product_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<int> purchasePrice = GeneratedColumn<int>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stockInDateMeta = const VerificationMeta(
    'stockInDate',
  );
  @override
  late final GeneratedColumn<String> stockInDate = GeneratedColumn<String>(
    'stock_in_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _offlineTempCodeMeta = const VerificationMeta(
    'offlineTempCode',
  );
  @override
  late final GeneratedColumn<String> offlineTempCode = GeneratedColumn<String>(
    'offline_temp_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productCode,
    productName,
    unit,
    quantity,
    purchasePrice,
    stockInDate,
    image,
    category,
    platform,
    brand,
    isDeleted,
    offlineTempCode,
    createdAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_products_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalProductsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_code')) {
      context.handle(
        _productCodeMeta,
        productCode.isAcceptableOrUnknown(
          data['product_code']!,
          _productCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('stock_in_date')) {
      context.handle(
        _stockInDateMeta,
        stockInDate.isAcceptableOrUnknown(
          data['stock_in_date']!,
          _stockInDateMeta,
        ),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('offline_temp_code')) {
      context.handle(
        _offlineTempCodeMeta,
        offlineTempCode.isAcceptableOrUnknown(
          data['offline_temp_code']!,
          _offlineTempCodeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProductsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_code'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_price'],
      )!,
      stockInDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stock_in_date'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      ),
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      offlineTempCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}offline_temp_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $LocalProductsTableTable createAlias(String alias) {
    return $LocalProductsTableTable(attachedDatabase, alias);
  }
}

class LocalProductsTableData extends DataClass
    implements Insertable<LocalProductsTableData> {
  final int id;
  final String productCode;
  final String productName;
  final String? unit;
  final int quantity;
  final int purchasePrice;
  final String? stockInDate;
  final String? image;
  final String? category;
  final String? platform;
  final String? brand;
  final bool isDeleted;
  final String? offlineTempCode;
  final DateTime createdAt;
  final DateTime? syncedAt;
  const LocalProductsTableData({
    required this.id,
    required this.productCode,
    required this.productName,
    this.unit,
    required this.quantity,
    required this.purchasePrice,
    this.stockInDate,
    this.image,
    this.category,
    this.platform,
    this.brand,
    required this.isDeleted,
    this.offlineTempCode,
    required this.createdAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_code'] = Variable<String>(productCode);
    map['product_name'] = Variable<String>(productName);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    map['quantity'] = Variable<int>(quantity);
    map['purchase_price'] = Variable<int>(purchasePrice);
    if (!nullToAbsent || stockInDate != null) {
      map['stock_in_date'] = Variable<String>(stockInDate);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || platform != null) {
      map['platform'] = Variable<String>(platform);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || offlineTempCode != null) {
      map['offline_temp_code'] = Variable<String>(offlineTempCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  LocalProductsTableCompanion toCompanion(bool nullToAbsent) {
    return LocalProductsTableCompanion(
      id: Value(id),
      productCode: Value(productCode),
      productName: Value(productName),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      quantity: Value(quantity),
      purchasePrice: Value(purchasePrice),
      stockInDate: stockInDate == null && nullToAbsent
          ? const Value.absent()
          : Value(stockInDate),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      platform: platform == null && nullToAbsent
          ? const Value.absent()
          : Value(platform),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      isDeleted: Value(isDeleted),
      offlineTempCode: offlineTempCode == null && nullToAbsent
          ? const Value.absent()
          : Value(offlineTempCode),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory LocalProductsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProductsTableData(
      id: serializer.fromJson<int>(json['id']),
      productCode: serializer.fromJson<String>(json['productCode']),
      productName: serializer.fromJson<String>(json['productName']),
      unit: serializer.fromJson<String?>(json['unit']),
      quantity: serializer.fromJson<int>(json['quantity']),
      purchasePrice: serializer.fromJson<int>(json['purchasePrice']),
      stockInDate: serializer.fromJson<String?>(json['stockInDate']),
      image: serializer.fromJson<String?>(json['image']),
      category: serializer.fromJson<String?>(json['category']),
      platform: serializer.fromJson<String?>(json['platform']),
      brand: serializer.fromJson<String?>(json['brand']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      offlineTempCode: serializer.fromJson<String?>(json['offlineTempCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productCode': serializer.toJson<String>(productCode),
      'productName': serializer.toJson<String>(productName),
      'unit': serializer.toJson<String?>(unit),
      'quantity': serializer.toJson<int>(quantity),
      'purchasePrice': serializer.toJson<int>(purchasePrice),
      'stockInDate': serializer.toJson<String?>(stockInDate),
      'image': serializer.toJson<String?>(image),
      'category': serializer.toJson<String?>(category),
      'platform': serializer.toJson<String?>(platform),
      'brand': serializer.toJson<String?>(brand),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'offlineTempCode': serializer.toJson<String?>(offlineTempCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  LocalProductsTableData copyWith({
    int? id,
    String? productCode,
    String? productName,
    Value<String?> unit = const Value.absent(),
    int? quantity,
    int? purchasePrice,
    Value<String?> stockInDate = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> platform = const Value.absent(),
    Value<String?> brand = const Value.absent(),
    bool? isDeleted,
    Value<String?> offlineTempCode = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => LocalProductsTableData(
    id: id ?? this.id,
    productCode: productCode ?? this.productCode,
    productName: productName ?? this.productName,
    unit: unit.present ? unit.value : this.unit,
    quantity: quantity ?? this.quantity,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    stockInDate: stockInDate.present ? stockInDate.value : this.stockInDate,
    image: image.present ? image.value : this.image,
    category: category.present ? category.value : this.category,
    platform: platform.present ? platform.value : this.platform,
    brand: brand.present ? brand.value : this.brand,
    isDeleted: isDeleted ?? this.isDeleted,
    offlineTempCode: offlineTempCode.present
        ? offlineTempCode.value
        : this.offlineTempCode,
    createdAt: createdAt ?? this.createdAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  LocalProductsTableData copyWithCompanion(LocalProductsTableCompanion data) {
    return LocalProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      productCode: data.productCode.present
          ? data.productCode.value
          : this.productCode,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      unit: data.unit.present ? data.unit.value : this.unit,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      stockInDate: data.stockInDate.present
          ? data.stockInDate.value
          : this.stockInDate,
      image: data.image.present ? data.image.value : this.image,
      category: data.category.present ? data.category.value : this.category,
      platform: data.platform.present ? data.platform.value : this.platform,
      brand: data.brand.present ? data.brand.value : this.brand,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      offlineTempCode: data.offlineTempCode.present
          ? data.offlineTempCode.value
          : this.offlineTempCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductsTableData(')
          ..write('id: $id, ')
          ..write('productCode: $productCode, ')
          ..write('productName: $productName, ')
          ..write('unit: $unit, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('stockInDate: $stockInDate, ')
          ..write('image: $image, ')
          ..write('category: $category, ')
          ..write('platform: $platform, ')
          ..write('brand: $brand, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('offlineTempCode: $offlineTempCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productCode,
    productName,
    unit,
    quantity,
    purchasePrice,
    stockInDate,
    image,
    category,
    platform,
    brand,
    isDeleted,
    offlineTempCode,
    createdAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProductsTableData &&
          other.id == this.id &&
          other.productCode == this.productCode &&
          other.productName == this.productName &&
          other.unit == this.unit &&
          other.quantity == this.quantity &&
          other.purchasePrice == this.purchasePrice &&
          other.stockInDate == this.stockInDate &&
          other.image == this.image &&
          other.category == this.category &&
          other.platform == this.platform &&
          other.brand == this.brand &&
          other.isDeleted == this.isDeleted &&
          other.offlineTempCode == this.offlineTempCode &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt);
}

class LocalProductsTableCompanion
    extends UpdateCompanion<LocalProductsTableData> {
  final Value<int> id;
  final Value<String> productCode;
  final Value<String> productName;
  final Value<String?> unit;
  final Value<int> quantity;
  final Value<int> purchasePrice;
  final Value<String?> stockInDate;
  final Value<String?> image;
  final Value<String?> category;
  final Value<String?> platform;
  final Value<String?> brand;
  final Value<bool> isDeleted;
  final Value<String?> offlineTempCode;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  const LocalProductsTableCompanion({
    this.id = const Value.absent(),
    this.productCode = const Value.absent(),
    this.productName = const Value.absent(),
    this.unit = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.stockInDate = const Value.absent(),
    this.image = const Value.absent(),
    this.category = const Value.absent(),
    this.platform = const Value.absent(),
    this.brand = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.offlineTempCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  LocalProductsTableCompanion.insert({
    this.id = const Value.absent(),
    required String productCode,
    required String productName,
    this.unit = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.stockInDate = const Value.absent(),
    this.image = const Value.absent(),
    this.category = const Value.absent(),
    this.platform = const Value.absent(),
    this.brand = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.offlineTempCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : productCode = Value(productCode),
       productName = Value(productName);
  static Insertable<LocalProductsTableData> custom({
    Expression<int>? id,
    Expression<String>? productCode,
    Expression<String>? productName,
    Expression<String>? unit,
    Expression<int>? quantity,
    Expression<int>? purchasePrice,
    Expression<String>? stockInDate,
    Expression<String>? image,
    Expression<String>? category,
    Expression<String>? platform,
    Expression<String>? brand,
    Expression<bool>? isDeleted,
    Expression<String>? offlineTempCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productCode != null) 'product_code': productCode,
      if (productName != null) 'product_name': productName,
      if (unit != null) 'unit': unit,
      if (quantity != null) 'quantity': quantity,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (stockInDate != null) 'stock_in_date': stockInDate,
      if (image != null) 'image': image,
      if (category != null) 'category': category,
      if (platform != null) 'platform': platform,
      if (brand != null) 'brand': brand,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (offlineTempCode != null) 'offline_temp_code': offlineTempCode,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  LocalProductsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? productCode,
    Value<String>? productName,
    Value<String?>? unit,
    Value<int>? quantity,
    Value<int>? purchasePrice,
    Value<String?>? stockInDate,
    Value<String?>? image,
    Value<String?>? category,
    Value<String?>? platform,
    Value<String?>? brand,
    Value<bool>? isDeleted,
    Value<String?>? offlineTempCode,
    Value<DateTime>? createdAt,
    Value<DateTime?>? syncedAt,
  }) {
    return LocalProductsTableCompanion(
      id: id ?? this.id,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      stockInDate: stockInDate ?? this.stockInDate,
      image: image ?? this.image,
      category: category ?? this.category,
      platform: platform ?? this.platform,
      brand: brand ?? this.brand,
      isDeleted: isDeleted ?? this.isDeleted,
      offlineTempCode: offlineTempCode ?? this.offlineTempCode,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<int>(purchasePrice.value);
    }
    if (stockInDate.present) {
      map['stock_in_date'] = Variable<String>(stockInDate.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (offlineTempCode.present) {
      map['offline_temp_code'] = Variable<String>(offlineTempCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('productCode: $productCode, ')
          ..write('productName: $productName, ')
          ..write('unit: $unit, ')
          ..write('quantity: $quantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('stockInDate: $stockInDate, ')
          ..write('image: $image, ')
          ..write('category: $category, ')
          ..write('platform: $platform, ')
          ..write('brand: $brand, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('offlineTempCode: $offlineTempCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $RetailTransactionsTableTable extends RetailTransactionsTable
    with TableInfo<$RetailTransactionsTableTable, RetailTransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RetailTransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productCodeMeta = const VerificationMeta(
    'productCode',
  );
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
    'product_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extraDataMeta = const VerificationMeta(
    'extraData',
  );
  @override
  late final GeneratedColumn<String> extraData = GeneratedColumn<String>(
    'extra_data',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productCode,
    productName,
    quantity,
    total,
    createdAt,
    extraData,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retail_transactions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RetailTransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_code')) {
      context.handle(
        _productCodeMeta,
        productCode.isAcceptableOrUnknown(
          data['product_code']!,
          _productCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('extra_data')) {
      context.handle(
        _extraDataMeta,
        extraData.isAcceptableOrUnknown(data['extra_data']!, _extraDataMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RetailTransactionsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RetailTransactionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_code'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      extraData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extra_data'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $RetailTransactionsTableTable createAlias(String alias) {
    return $RetailTransactionsTableTable(attachedDatabase, alias);
  }
}

class RetailTransactionsTableData extends DataClass
    implements Insertable<RetailTransactionsTableData> {
  final int id;
  final String productCode;
  final String? productName;
  final int quantity;
  final int total;
  final DateTime createdAt;
  final String? extraData;
  final DateTime? syncedAt;
  const RetailTransactionsTableData({
    required this.id,
    required this.productCode,
    this.productName,
    required this.quantity,
    required this.total,
    required this.createdAt,
    this.extraData,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_code'] = Variable<String>(productCode);
    if (!nullToAbsent || productName != null) {
      map['product_name'] = Variable<String>(productName);
    }
    map['quantity'] = Variable<int>(quantity);
    map['total'] = Variable<int>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || extraData != null) {
      map['extra_data'] = Variable<String>(extraData);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  RetailTransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return RetailTransactionsTableCompanion(
      id: Value(id),
      productCode: Value(productCode),
      productName: productName == null && nullToAbsent
          ? const Value.absent()
          : Value(productName),
      quantity: Value(quantity),
      total: Value(total),
      createdAt: Value(createdAt),
      extraData: extraData == null && nullToAbsent
          ? const Value.absent()
          : Value(extraData),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory RetailTransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RetailTransactionsTableData(
      id: serializer.fromJson<int>(json['id']),
      productCode: serializer.fromJson<String>(json['productCode']),
      productName: serializer.fromJson<String?>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      total: serializer.fromJson<int>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      extraData: serializer.fromJson<String?>(json['extraData']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productCode': serializer.toJson<String>(productCode),
      'productName': serializer.toJson<String?>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'total': serializer.toJson<int>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'extraData': serializer.toJson<String?>(extraData),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  RetailTransactionsTableData copyWith({
    int? id,
    String? productCode,
    Value<String?> productName = const Value.absent(),
    int? quantity,
    int? total,
    DateTime? createdAt,
    Value<String?> extraData = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => RetailTransactionsTableData(
    id: id ?? this.id,
    productCode: productCode ?? this.productCode,
    productName: productName.present ? productName.value : this.productName,
    quantity: quantity ?? this.quantity,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
    extraData: extraData.present ? extraData.value : this.extraData,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  RetailTransactionsTableData copyWithCompanion(
    RetailTransactionsTableCompanion data,
  ) {
    return RetailTransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      productCode: data.productCode.present
          ? data.productCode.value
          : this.productCode,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      extraData: data.extraData.present ? data.extraData.value : this.extraData,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RetailTransactionsTableData(')
          ..write('id: $id, ')
          ..write('productCode: $productCode, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('extraData: $extraData, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productCode,
    productName,
    quantity,
    total,
    createdAt,
    extraData,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RetailTransactionsTableData &&
          other.id == this.id &&
          other.productCode == this.productCode &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.total == this.total &&
          other.createdAt == this.createdAt &&
          other.extraData == this.extraData &&
          other.syncedAt == this.syncedAt);
}

class RetailTransactionsTableCompanion
    extends UpdateCompanion<RetailTransactionsTableData> {
  final Value<int> id;
  final Value<String> productCode;
  final Value<String?> productName;
  final Value<int> quantity;
  final Value<int> total;
  final Value<DateTime> createdAt;
  final Value<String?> extraData;
  final Value<DateTime?> syncedAt;
  const RetailTransactionsTableCompanion({
    this.id = const Value.absent(),
    this.productCode = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.extraData = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  RetailTransactionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String productCode,
    this.productName = const Value.absent(),
    required int quantity,
    required int total,
    required DateTime createdAt,
    this.extraData = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : productCode = Value(productCode),
       quantity = Value(quantity),
       total = Value(total),
       createdAt = Value(createdAt);
  static Insertable<RetailTransactionsTableData> custom({
    Expression<int>? id,
    Expression<String>? productCode,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<int>? total,
    Expression<DateTime>? createdAt,
    Expression<String>? extraData,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productCode != null) 'product_code': productCode,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
      if (extraData != null) 'extra_data': extraData,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  RetailTransactionsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? productCode,
    Value<String?>? productName,
    Value<int>? quantity,
    Value<int>? total,
    Value<DateTime>? createdAt,
    Value<String?>? extraData,
    Value<DateTime?>? syncedAt,
  }) {
    return RetailTransactionsTableCompanion(
      id: id ?? this.id,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      extraData: extraData ?? this.extraData,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (extraData.present) {
      map['extra_data'] = Variable<String>(extraData.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RetailTransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('productCode: $productCode, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('extraData: $extraData, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $InventoryAdjustmentsTableTable extends InventoryAdjustmentsTable
    with
        TableInfo<
          $InventoryAdjustmentsTableTable,
          InventoryAdjustmentsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryAdjustmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productCodeMeta = const VerificationMeta(
    'productCode',
  );
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
    'product_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adjustmentMeta = const VerificationMeta(
    'adjustment',
  );
  @override
  late final GeneratedColumn<int> adjustment = GeneratedColumn<int>(
    'adjustment',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [productCode, adjustment];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_adjustments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryAdjustmentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_code')) {
      context.handle(
        _productCodeMeta,
        productCode.isAcceptableOrUnknown(
          data['product_code']!,
          _productCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('adjustment')) {
      context.handle(
        _adjustmentMeta,
        adjustment.isAcceptableOrUnknown(data['adjustment']!, _adjustmentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productCode};
  @override
  InventoryAdjustmentsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryAdjustmentsTableData(
      productCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_code'],
      )!,
      adjustment: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}adjustment'],
      )!,
    );
  }

  @override
  $InventoryAdjustmentsTableTable createAlias(String alias) {
    return $InventoryAdjustmentsTableTable(attachedDatabase, alias);
  }
}

class InventoryAdjustmentsTableData extends DataClass
    implements Insertable<InventoryAdjustmentsTableData> {
  final String productCode;
  final int adjustment;
  const InventoryAdjustmentsTableData({
    required this.productCode,
    required this.adjustment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_code'] = Variable<String>(productCode);
    map['adjustment'] = Variable<int>(adjustment);
    return map;
  }

  InventoryAdjustmentsTableCompanion toCompanion(bool nullToAbsent) {
    return InventoryAdjustmentsTableCompanion(
      productCode: Value(productCode),
      adjustment: Value(adjustment),
    );
  }

  factory InventoryAdjustmentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryAdjustmentsTableData(
      productCode: serializer.fromJson<String>(json['productCode']),
      adjustment: serializer.fromJson<int>(json['adjustment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productCode': serializer.toJson<String>(productCode),
      'adjustment': serializer.toJson<int>(adjustment),
    };
  }

  InventoryAdjustmentsTableData copyWith({
    String? productCode,
    int? adjustment,
  }) => InventoryAdjustmentsTableData(
    productCode: productCode ?? this.productCode,
    adjustment: adjustment ?? this.adjustment,
  );
  InventoryAdjustmentsTableData copyWithCompanion(
    InventoryAdjustmentsTableCompanion data,
  ) {
    return InventoryAdjustmentsTableData(
      productCode: data.productCode.present
          ? data.productCode.value
          : this.productCode,
      adjustment: data.adjustment.present
          ? data.adjustment.value
          : this.adjustment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryAdjustmentsTableData(')
          ..write('productCode: $productCode, ')
          ..write('adjustment: $adjustment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productCode, adjustment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryAdjustmentsTableData &&
          other.productCode == this.productCode &&
          other.adjustment == this.adjustment);
}

class InventoryAdjustmentsTableCompanion
    extends UpdateCompanion<InventoryAdjustmentsTableData> {
  final Value<String> productCode;
  final Value<int> adjustment;
  final Value<int> rowid;
  const InventoryAdjustmentsTableCompanion({
    this.productCode = const Value.absent(),
    this.adjustment = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryAdjustmentsTableCompanion.insert({
    required String productCode,
    this.adjustment = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productCode = Value(productCode);
  static Insertable<InventoryAdjustmentsTableData> custom({
    Expression<String>? productCode,
    Expression<int>? adjustment,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productCode != null) 'product_code': productCode,
      if (adjustment != null) 'adjustment': adjustment,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryAdjustmentsTableCompanion copyWith({
    Value<String>? productCode,
    Value<int>? adjustment,
    Value<int>? rowid,
  }) {
    return InventoryAdjustmentsTableCompanion(
      productCode: productCode ?? this.productCode,
      adjustment: adjustment ?? this.adjustment,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (adjustment.present) {
      map['adjustment'] = Variable<int>(adjustment.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryAdjustmentsTableCompanion(')
          ..write('productCode: $productCode, ')
          ..write('adjustment: $adjustment, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OfflineQueueTableTable extends OfflineQueueTable
    with TableInfo<$OfflineQueueTableTable, OfflineQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflineQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _queueKeyMeta = const VerificationMeta(
    'queueKey',
  );
  @override
  late final GeneratedColumn<String> queueKey = GeneratedColumn<String>(
    'queue_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    queueKey,
    payload,
    createdAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_queue_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfflineQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('queue_key')) {
      context.handle(
        _queueKeyMeta,
        queueKey.isAcceptableOrUnknown(data['queue_key']!, _queueKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_queueKeyMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflineQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflineQueueTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      queueKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queue_key'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $OfflineQueueTableTable createAlias(String alias) {
    return $OfflineQueueTableTable(attachedDatabase, alias);
  }
}

class OfflineQueueTableData extends DataClass
    implements Insertable<OfflineQueueTableData> {
  final int id;
  final String queueKey;
  final String payload;
  final DateTime createdAt;
  final DateTime? syncedAt;
  const OfflineQueueTableData({
    required this.id,
    required this.queueKey,
    required this.payload,
    required this.createdAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['queue_key'] = Variable<String>(queueKey);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  OfflineQueueTableCompanion toCompanion(bool nullToAbsent) {
    return OfflineQueueTableCompanion(
      id: Value(id),
      queueKey: Value(queueKey),
      payload: Value(payload),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory OfflineQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflineQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      queueKey: serializer.fromJson<String>(json['queueKey']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'queueKey': serializer.toJson<String>(queueKey),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  OfflineQueueTableData copyWith({
    int? id,
    String? queueKey,
    String? payload,
    DateTime? createdAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => OfflineQueueTableData(
    id: id ?? this.id,
    queueKey: queueKey ?? this.queueKey,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  OfflineQueueTableData copyWithCompanion(OfflineQueueTableCompanion data) {
    return OfflineQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      queueKey: data.queueKey.present ? data.queueKey.value : this.queueKey,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflineQueueTableData(')
          ..write('id: $id, ')
          ..write('queueKey: $queueKey, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, queueKey, payload, createdAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflineQueueTableData &&
          other.id == this.id &&
          other.queueKey == this.queueKey &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt);
}

class OfflineQueueTableCompanion
    extends UpdateCompanion<OfflineQueueTableData> {
  final Value<int> id;
  final Value<String> queueKey;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  const OfflineQueueTableCompanion({
    this.id = const Value.absent(),
    this.queueKey = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  OfflineQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String queueKey,
    required String payload,
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : queueKey = Value(queueKey),
       payload = Value(payload);
  static Insertable<OfflineQueueTableData> custom({
    Expression<int>? id,
    Expression<String>? queueKey,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (queueKey != null) 'queue_key': queueKey,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  OfflineQueueTableCompanion copyWith({
    Value<int>? id,
    Value<String>? queueKey,
    Value<String>? payload,
    Value<DateTime>? createdAt,
    Value<DateTime?>? syncedAt,
  }) {
    return OfflineQueueTableCompanion(
      id: id ?? this.id,
      queueKey: queueKey ?? this.queueKey,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (queueKey.present) {
      map['queue_key'] = Variable<String>(queueKey.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflineQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('queueKey: $queueKey, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $AppStateTableTable extends AppStateTable
    with TableInfo<$AppStateTableTable, AppStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_state_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppStateTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppStateTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppStateTableData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppStateTableTable createAlias(String alias) {
    return $AppStateTableTable(attachedDatabase, alias);
  }
}

class AppStateTableData extends DataClass
    implements Insertable<AppStateTableData> {
  final String key;
  final String value;
  const AppStateTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppStateTableCompanion toCompanion(bool nullToAbsent) {
    return AppStateTableCompanion(key: Value(key), value: Value(value));
  }

  factory AppStateTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppStateTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppStateTableData copyWith({String? key, String? value}) =>
      AppStateTableData(key: key ?? this.key, value: value ?? this.value);
  AppStateTableData copyWithCompanion(AppStateTableCompanion data) {
    return AppStateTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppStateTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppStateTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class AppStateTableCompanion extends UpdateCompanion<AppStateTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppStateTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppStateTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppStateTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppStateTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppStateTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppStateTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalProductsTableTable localProductsTable =
      $LocalProductsTableTable(this);
  late final $RetailTransactionsTableTable retailTransactionsTable =
      $RetailTransactionsTableTable(this);
  late final $InventoryAdjustmentsTableTable inventoryAdjustmentsTable =
      $InventoryAdjustmentsTableTable(this);
  late final $OfflineQueueTableTable offlineQueueTable =
      $OfflineQueueTableTable(this);
  late final $AppStateTableTable appStateTable = $AppStateTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localProductsTable,
    retailTransactionsTable,
    inventoryAdjustmentsTable,
    offlineQueueTable,
    appStateTable,
  ];
}

typedef $$LocalProductsTableTableCreateCompanionBuilder =
    LocalProductsTableCompanion Function({
      Value<int> id,
      required String productCode,
      required String productName,
      Value<String?> unit,
      Value<int> quantity,
      Value<int> purchasePrice,
      Value<String?> stockInDate,
      Value<String?> image,
      Value<String?> category,
      Value<String?> platform,
      Value<String?> brand,
      Value<bool> isDeleted,
      Value<String?> offlineTempCode,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
    });
typedef $$LocalProductsTableTableUpdateCompanionBuilder =
    LocalProductsTableCompanion Function({
      Value<int> id,
      Value<String> productCode,
      Value<String> productName,
      Value<String?> unit,
      Value<int> quantity,
      Value<int> purchasePrice,
      Value<String?> stockInDate,
      Value<String?> image,
      Value<String?> category,
      Value<String?> platform,
      Value<String?> brand,
      Value<bool> isDeleted,
      Value<String?> offlineTempCode,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
    });

class $$LocalProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProductsTableTable> {
  $$LocalProductsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stockInDate => $composableBuilder(
    column: $table.stockInDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offlineTempCode => $composableBuilder(
    column: $table.offlineTempCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProductsTableTable> {
  $$LocalProductsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stockInDate => $composableBuilder(
    column: $table.stockInDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offlineTempCode => $composableBuilder(
    column: $table.offlineTempCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProductsTableTable> {
  $$LocalProductsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stockInDate => $composableBuilder(
    column: $table.stockInDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get offlineTempCode => $composableBuilder(
    column: $table.offlineTempCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$LocalProductsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalProductsTableTable,
          LocalProductsTableData,
          $$LocalProductsTableTableFilterComposer,
          $$LocalProductsTableTableOrderingComposer,
          $$LocalProductsTableTableAnnotationComposer,
          $$LocalProductsTableTableCreateCompanionBuilder,
          $$LocalProductsTableTableUpdateCompanionBuilder,
          (
            LocalProductsTableData,
            BaseReferences<
              _$AppDatabase,
              $LocalProductsTableTable,
              LocalProductsTableData
            >,
          ),
          LocalProductsTableData,
          PrefetchHooks Function()
        > {
  $$LocalProductsTableTableTableManager(
    _$AppDatabase db,
    $LocalProductsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productCode = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> purchasePrice = const Value.absent(),
                Value<String?> stockInDate = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> offlineTempCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => LocalProductsTableCompanion(
                id: id,
                productCode: productCode,
                productName: productName,
                unit: unit,
                quantity: quantity,
                purchasePrice: purchasePrice,
                stockInDate: stockInDate,
                image: image,
                category: category,
                platform: platform,
                brand: brand,
                isDeleted: isDeleted,
                offlineTempCode: offlineTempCode,
                createdAt: createdAt,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productCode,
                required String productName,
                Value<String?> unit = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> purchasePrice = const Value.absent(),
                Value<String?> stockInDate = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> offlineTempCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => LocalProductsTableCompanion.insert(
                id: id,
                productCode: productCode,
                productName: productName,
                unit: unit,
                quantity: quantity,
                purchasePrice: purchasePrice,
                stockInDate: stockInDate,
                image: image,
                category: category,
                platform: platform,
                brand: brand,
                isDeleted: isDeleted,
                offlineTempCode: offlineTempCode,
                createdAt: createdAt,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalProductsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalProductsTableTable,
      LocalProductsTableData,
      $$LocalProductsTableTableFilterComposer,
      $$LocalProductsTableTableOrderingComposer,
      $$LocalProductsTableTableAnnotationComposer,
      $$LocalProductsTableTableCreateCompanionBuilder,
      $$LocalProductsTableTableUpdateCompanionBuilder,
      (
        LocalProductsTableData,
        BaseReferences<
          _$AppDatabase,
          $LocalProductsTableTable,
          LocalProductsTableData
        >,
      ),
      LocalProductsTableData,
      PrefetchHooks Function()
    >;
typedef $$RetailTransactionsTableTableCreateCompanionBuilder =
    RetailTransactionsTableCompanion Function({
      Value<int> id,
      required String productCode,
      Value<String?> productName,
      required int quantity,
      required int total,
      required DateTime createdAt,
      Value<String?> extraData,
      Value<DateTime?> syncedAt,
    });
typedef $$RetailTransactionsTableTableUpdateCompanionBuilder =
    RetailTransactionsTableCompanion Function({
      Value<int> id,
      Value<String> productCode,
      Value<String?> productName,
      Value<int> quantity,
      Value<int> total,
      Value<DateTime> createdAt,
      Value<String?> extraData,
      Value<DateTime?> syncedAt,
    });

class $$RetailTransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RetailTransactionsTableTable> {
  $$RetailTransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extraData => $composableBuilder(
    column: $table.extraData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RetailTransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RetailTransactionsTableTable> {
  $$RetailTransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extraData => $composableBuilder(
    column: $table.extraData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RetailTransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RetailTransactionsTableTable> {
  $$RetailTransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get extraData =>
      $composableBuilder(column: $table.extraData, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$RetailTransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RetailTransactionsTableTable,
          RetailTransactionsTableData,
          $$RetailTransactionsTableTableFilterComposer,
          $$RetailTransactionsTableTableOrderingComposer,
          $$RetailTransactionsTableTableAnnotationComposer,
          $$RetailTransactionsTableTableCreateCompanionBuilder,
          $$RetailTransactionsTableTableUpdateCompanionBuilder,
          (
            RetailTransactionsTableData,
            BaseReferences<
              _$AppDatabase,
              $RetailTransactionsTableTable,
              RetailTransactionsTableData
            >,
          ),
          RetailTransactionsTableData,
          PrefetchHooks Function()
        > {
  $$RetailTransactionsTableTableTableManager(
    _$AppDatabase db,
    $RetailTransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RetailTransactionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RetailTransactionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RetailTransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productCode = const Value.absent(),
                Value<String?> productName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> extraData = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => RetailTransactionsTableCompanion(
                id: id,
                productCode: productCode,
                productName: productName,
                quantity: quantity,
                total: total,
                createdAt: createdAt,
                extraData: extraData,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productCode,
                Value<String?> productName = const Value.absent(),
                required int quantity,
                required int total,
                required DateTime createdAt,
                Value<String?> extraData = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => RetailTransactionsTableCompanion.insert(
                id: id,
                productCode: productCode,
                productName: productName,
                quantity: quantity,
                total: total,
                createdAt: createdAt,
                extraData: extraData,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RetailTransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RetailTransactionsTableTable,
      RetailTransactionsTableData,
      $$RetailTransactionsTableTableFilterComposer,
      $$RetailTransactionsTableTableOrderingComposer,
      $$RetailTransactionsTableTableAnnotationComposer,
      $$RetailTransactionsTableTableCreateCompanionBuilder,
      $$RetailTransactionsTableTableUpdateCompanionBuilder,
      (
        RetailTransactionsTableData,
        BaseReferences<
          _$AppDatabase,
          $RetailTransactionsTableTable,
          RetailTransactionsTableData
        >,
      ),
      RetailTransactionsTableData,
      PrefetchHooks Function()
    >;
typedef $$InventoryAdjustmentsTableTableCreateCompanionBuilder =
    InventoryAdjustmentsTableCompanion Function({
      required String productCode,
      Value<int> adjustment,
      Value<int> rowid,
    });
typedef $$InventoryAdjustmentsTableTableUpdateCompanionBuilder =
    InventoryAdjustmentsTableCompanion Function({
      Value<String> productCode,
      Value<int> adjustment,
      Value<int> rowid,
    });

class $$InventoryAdjustmentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentsTableTable> {
  $$InventoryAdjustmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get adjustment => $composableBuilder(
    column: $table.adjustment,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryAdjustmentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentsTableTable> {
  $$InventoryAdjustmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get adjustment => $composableBuilder(
    column: $table.adjustment,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryAdjustmentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryAdjustmentsTableTable> {
  $$InventoryAdjustmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get adjustment => $composableBuilder(
    column: $table.adjustment,
    builder: (column) => column,
  );
}

class $$InventoryAdjustmentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryAdjustmentsTableTable,
          InventoryAdjustmentsTableData,
          $$InventoryAdjustmentsTableTableFilterComposer,
          $$InventoryAdjustmentsTableTableOrderingComposer,
          $$InventoryAdjustmentsTableTableAnnotationComposer,
          $$InventoryAdjustmentsTableTableCreateCompanionBuilder,
          $$InventoryAdjustmentsTableTableUpdateCompanionBuilder,
          (
            InventoryAdjustmentsTableData,
            BaseReferences<
              _$AppDatabase,
              $InventoryAdjustmentsTableTable,
              InventoryAdjustmentsTableData
            >,
          ),
          InventoryAdjustmentsTableData,
          PrefetchHooks Function()
        > {
  $$InventoryAdjustmentsTableTableTableManager(
    _$AppDatabase db,
    $InventoryAdjustmentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryAdjustmentsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InventoryAdjustmentsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InventoryAdjustmentsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> productCode = const Value.absent(),
                Value<int> adjustment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryAdjustmentsTableCompanion(
                productCode: productCode,
                adjustment: adjustment,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String productCode,
                Value<int> adjustment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryAdjustmentsTableCompanion.insert(
                productCode: productCode,
                adjustment: adjustment,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryAdjustmentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryAdjustmentsTableTable,
      InventoryAdjustmentsTableData,
      $$InventoryAdjustmentsTableTableFilterComposer,
      $$InventoryAdjustmentsTableTableOrderingComposer,
      $$InventoryAdjustmentsTableTableAnnotationComposer,
      $$InventoryAdjustmentsTableTableCreateCompanionBuilder,
      $$InventoryAdjustmentsTableTableUpdateCompanionBuilder,
      (
        InventoryAdjustmentsTableData,
        BaseReferences<
          _$AppDatabase,
          $InventoryAdjustmentsTableTable,
          InventoryAdjustmentsTableData
        >,
      ),
      InventoryAdjustmentsTableData,
      PrefetchHooks Function()
    >;
typedef $$OfflineQueueTableTableCreateCompanionBuilder =
    OfflineQueueTableCompanion Function({
      Value<int> id,
      required String queueKey,
      required String payload,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
    });
typedef $$OfflineQueueTableTableUpdateCompanionBuilder =
    OfflineQueueTableCompanion Function({
      Value<int> id,
      Value<String> queueKey,
      Value<String> payload,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
    });

class $$OfflineQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $OfflineQueueTableTable> {
  $$OfflineQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queueKey => $composableBuilder(
    column: $table.queueKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OfflineQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OfflineQueueTableTable> {
  $$OfflineQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queueKey => $composableBuilder(
    column: $table.queueKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfflineQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfflineQueueTableTable> {
  $$OfflineQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get queueKey =>
      $composableBuilder(column: $table.queueKey, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$OfflineQueueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfflineQueueTableTable,
          OfflineQueueTableData,
          $$OfflineQueueTableTableFilterComposer,
          $$OfflineQueueTableTableOrderingComposer,
          $$OfflineQueueTableTableAnnotationComposer,
          $$OfflineQueueTableTableCreateCompanionBuilder,
          $$OfflineQueueTableTableUpdateCompanionBuilder,
          (
            OfflineQueueTableData,
            BaseReferences<
              _$AppDatabase,
              $OfflineQueueTableTable,
              OfflineQueueTableData
            >,
          ),
          OfflineQueueTableData,
          PrefetchHooks Function()
        > {
  $$OfflineQueueTableTableTableManager(
    _$AppDatabase db,
    $OfflineQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflineQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflineQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflineQueueTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> queueKey = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => OfflineQueueTableCompanion(
                id: id,
                queueKey: queueKey,
                payload: payload,
                createdAt: createdAt,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String queueKey,
                required String payload,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => OfflineQueueTableCompanion.insert(
                id: id,
                queueKey: queueKey,
                payload: payload,
                createdAt: createdAt,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OfflineQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfflineQueueTableTable,
      OfflineQueueTableData,
      $$OfflineQueueTableTableFilterComposer,
      $$OfflineQueueTableTableOrderingComposer,
      $$OfflineQueueTableTableAnnotationComposer,
      $$OfflineQueueTableTableCreateCompanionBuilder,
      $$OfflineQueueTableTableUpdateCompanionBuilder,
      (
        OfflineQueueTableData,
        BaseReferences<
          _$AppDatabase,
          $OfflineQueueTableTable,
          OfflineQueueTableData
        >,
      ),
      OfflineQueueTableData,
      PrefetchHooks Function()
    >;
typedef $$AppStateTableTableCreateCompanionBuilder =
    AppStateTableCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppStateTableTableUpdateCompanionBuilder =
    AppStateTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppStateTableTable> {
  $$AppStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppStateTableTable> {
  $$AppStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppStateTableTable> {
  $$AppStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppStateTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppStateTableTable,
          AppStateTableData,
          $$AppStateTableTableFilterComposer,
          $$AppStateTableTableOrderingComposer,
          $$AppStateTableTableAnnotationComposer,
          $$AppStateTableTableCreateCompanionBuilder,
          $$AppStateTableTableUpdateCompanionBuilder,
          (
            AppStateTableData,
            BaseReferences<
              _$AppDatabase,
              $AppStateTableTable,
              AppStateTableData
            >,
          ),
          AppStateTableData,
          PrefetchHooks Function()
        > {
  $$AppStateTableTableTableManager(_$AppDatabase db, $AppStateTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppStateTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppStateTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  AppStateTableCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppStateTableCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppStateTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppStateTableTable,
      AppStateTableData,
      $$AppStateTableTableFilterComposer,
      $$AppStateTableTableOrderingComposer,
      $$AppStateTableTableAnnotationComposer,
      $$AppStateTableTableCreateCompanionBuilder,
      $$AppStateTableTableUpdateCompanionBuilder,
      (
        AppStateTableData,
        BaseReferences<_$AppDatabase, $AppStateTableTable, AppStateTableData>,
      ),
      AppStateTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalProductsTableTableTableManager get localProductsTable =>
      $$LocalProductsTableTableTableManager(_db, _db.localProductsTable);
  $$RetailTransactionsTableTableTableManager get retailTransactionsTable =>
      $$RetailTransactionsTableTableTableManager(
        _db,
        _db.retailTransactionsTable,
      );
  $$InventoryAdjustmentsTableTableTableManager get inventoryAdjustmentsTable =>
      $$InventoryAdjustmentsTableTableTableManager(
        _db,
        _db.inventoryAdjustmentsTable,
      );
  $$OfflineQueueTableTableTableManager get offlineQueueTable =>
      $$OfflineQueueTableTableTableManager(_db, _db.offlineQueueTable);
  $$AppStateTableTableTableManager get appStateTable =>
      $$AppStateTableTableTableManager(_db, _db.appStateTable);
}
