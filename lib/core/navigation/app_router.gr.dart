// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ForgotPinPage]
class ForgotPinRoute extends PageRouteInfo<void> {
  const ForgotPinRoute({List<PageRouteInfo>? children})
    : super(ForgotPinRoute.name, initialChildren: children);

  static const String name = 'ForgotPinRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPinPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [HomeTabsPage]
class HomeTabsRoute extends PageRouteInfo<void> {
  const HomeTabsRoute({List<PageRouteInfo>? children})
    : super(HomeTabsRoute.name, initialChildren: children);

  static const String name = 'HomeTabsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeTabsPage();
    },
  );
}

/// generated route for
/// [PhoneInputPage]
class PhoneInputRoute extends PageRouteInfo<void> {
  const PhoneInputRoute({List<PageRouteInfo>? children})
    : super(PhoneInputRoute.name, initialChildren: children);

  static const String name = 'PhoneInputRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PhoneInputPage();
    },
  );
}

/// generated route for
/// [PinInputPage]
class PinInputRoute extends PageRouteInfo<PinInputRouteArgs> {
  PinInputRoute({
    Key? key,
    required String phoneNumber,
    List<PageRouteInfo>? children,
  }) : super(
         PinInputRoute.name,
         args: PinInputRouteArgs(key: key, phoneNumber: phoneNumber),
         initialChildren: children,
       );

  static const String name = 'PinInputRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PinInputRouteArgs>();
      return PinInputPage(key: args.key, phoneNumber: args.phoneNumber);
    },
  );
}

class PinInputRouteArgs {
  const PinInputRouteArgs({this.key, required this.phoneNumber});

  final Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'PinInputRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PinInputRouteArgs) return false;
    return key == other.key && phoneNumber == other.phoneNumber;
  }

  @override
  int get hashCode => key.hashCode ^ phoneNumber.hashCode;
}

/// generated route for
/// [ProductDetailsPage]
class ProductDetailsRoute extends PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    Key? key,
    String productCode = '',
    String productName = '',
    String category = '',
    String platform = '',
    String brand = '',
    String unit = '',
    String quantity = '',
    String purchasePrice = '',
    String stockInDate = '',
    String? imageUrl,
    int? stockQuantityValue,
    int? priceValue,
    List<PageRouteInfo>? children,
  }) : super(
         ProductDetailsRoute.name,
         args: ProductDetailsRouteArgs(
           key: key,
           productCode: productCode,
           productName: productName,
           category: category,
           platform: platform,
           brand: brand,
           unit: unit,
           quantity: quantity,
           purchasePrice: purchasePrice,
           stockInDate: stockInDate,
           imageUrl: imageUrl,
           stockQuantityValue: stockQuantityValue,
           priceValue: priceValue,
         ),
         initialChildren: children,
       );

  static const String name = 'ProductDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>(
        orElse: () => const ProductDetailsRouteArgs(),
      );
      return ProductDetailsPage(
        key: args.key,
        productCode: args.productCode,
        productName: args.productName,
        category: args.category,
        platform: args.platform,
        brand: args.brand,
        unit: args.unit,
        quantity: args.quantity,
        purchasePrice: args.purchasePrice,
        stockInDate: args.stockInDate,
        imageUrl: args.imageUrl,
        stockQuantityValue: args.stockQuantityValue,
        priceValue: args.priceValue,
      );
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    this.productCode = '',
    this.productName = '',
    this.category = '',
    this.platform = '',
    this.brand = '',
    this.unit = '',
    this.quantity = '',
    this.purchasePrice = '',
    this.stockInDate = '',
    this.imageUrl,
    this.stockQuantityValue,
    this.priceValue,
  });

  final Key? key;

  final String productCode;

  final String productName;

  final String category;

  final String platform;

  final String brand;

  final String unit;

  final String quantity;

  final String purchasePrice;

  final String stockInDate;

  final String? imageUrl;

  final int? stockQuantityValue;

  final int? priceValue;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productCode: $productCode, productName: $productName, category: $category, platform: $platform, brand: $brand, unit: $unit, quantity: $quantity, purchasePrice: $purchasePrice, stockInDate: $stockInDate, imageUrl: $imageUrl, stockQuantityValue: $stockQuantityValue, priceValue: $priceValue}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailsRouteArgs) return false;
    return key == other.key &&
        productCode == other.productCode &&
        productName == other.productName &&
        category == other.category &&
        platform == other.platform &&
        brand == other.brand &&
        unit == other.unit &&
        quantity == other.quantity &&
        purchasePrice == other.purchasePrice &&
        stockInDate == other.stockInDate &&
        imageUrl == other.imageUrl &&
        stockQuantityValue == other.stockQuantityValue &&
        priceValue == other.priceValue;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      productCode.hashCode ^
      productName.hashCode ^
      category.hashCode ^
      platform.hashCode ^
      brand.hashCode ^
      unit.hashCode ^
      quantity.hashCode ^
      purchasePrice.hashCode ^
      stockInDate.hashCode ^
      imageUrl.hashCode ^
      stockQuantityValue.hashCode ^
      priceValue.hashCode;
}

/// generated route for
/// [RetailPage]
class RetailRoute extends PageRouteInfo<RetailRouteArgs> {
  RetailRoute({
    Key? key,
    String productCode = '',
    String productName = '',
    int stockQuantity = 0,
    int price = 0,
    String? imageUrl,
    List<PageRouteInfo>? children,
  }) : super(
         RetailRoute.name,
         args: RetailRouteArgs(
           key: key,
           productCode: productCode,
           productName: productName,
           stockQuantity: stockQuantity,
           price: price,
           imageUrl: imageUrl,
         ),
         initialChildren: children,
       );

  static const String name = 'RetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RetailRouteArgs>(
        orElse: () => const RetailRouteArgs(),
      );
      return RetailPage(
        key: args.key,
        productCode: args.productCode,
        productName: args.productName,
        stockQuantity: args.stockQuantity,
        price: args.price,
        imageUrl: args.imageUrl,
      );
    },
  );
}

class RetailRouteArgs {
  const RetailRouteArgs({
    this.key,
    this.productCode = '',
    this.productName = '',
    this.stockQuantity = 0,
    this.price = 0,
    this.imageUrl,
  });

  final Key? key;

  final String productCode;

  final String productName;

  final int stockQuantity;

  final int price;

  final String? imageUrl;

  @override
  String toString() {
    return 'RetailRouteArgs{key: $key, productCode: $productCode, productName: $productName, stockQuantity: $stockQuantity, price: $price, imageUrl: $imageUrl}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RetailRouteArgs) return false;
    return key == other.key &&
        productCode == other.productCode &&
        productName == other.productName &&
        stockQuantity == other.stockQuantity &&
        price == other.price &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      productCode.hashCode ^
      productName.hashCode ^
      stockQuantity.hashCode ^
      price.hashCode ^
      imageUrl.hashCode;
}

/// generated route for
/// [StockInPage]
class StockInRoute extends PageRouteInfo<StockInRouteArgs> {
  StockInRoute({
    Key? key,
    String? productCode,
    String? productName,
    String? category,
    String? platform,
    String? brand,
    String? unit,
    int? quantity,
    int? purchasePrice,
    String? stockInDate,
    List<PageRouteInfo>? children,
  }) : super(
         StockInRoute.name,
         args: StockInRouteArgs(
           key: key,
           productCode: productCode,
           productName: productName,
           category: category,
           platform: platform,
           brand: brand,
           unit: unit,
           quantity: quantity,
           purchasePrice: purchasePrice,
           stockInDate: stockInDate,
         ),
         initialChildren: children,
       );

  static const String name = 'StockInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StockInRouteArgs>(
        orElse: () => const StockInRouteArgs(),
      );
      return StockInPage(
        key: args.key,
        productCode: args.productCode,
        productName: args.productName,
        category: args.category,
        platform: args.platform,
        brand: args.brand,
        unit: args.unit,
        quantity: args.quantity,
        purchasePrice: args.purchasePrice,
        stockInDate: args.stockInDate,
      );
    },
  );
}

class StockInRouteArgs {
  const StockInRouteArgs({
    this.key,
    this.productCode,
    this.productName,
    this.category,
    this.platform,
    this.brand,
    this.unit,
    this.quantity,
    this.purchasePrice,
    this.stockInDate,
  });

  final Key? key;

  final String? productCode;

  final String? productName;

  final String? category;

  final String? platform;

  final String? brand;

  final String? unit;

  final int? quantity;

  final int? purchasePrice;

  final String? stockInDate;

  @override
  String toString() {
    return 'StockInRouteArgs{key: $key, productCode: $productCode, productName: $productName, category: $category, platform: $platform, brand: $brand, unit: $unit, quantity: $quantity, purchasePrice: $purchasePrice, stockInDate: $stockInDate}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StockInRouteArgs) return false;
    return key == other.key &&
        productCode == other.productCode &&
        productName == other.productName &&
        category == other.category &&
        platform == other.platform &&
        brand == other.brand &&
        unit == other.unit &&
        quantity == other.quantity &&
        purchasePrice == other.purchasePrice &&
        stockInDate == other.stockInDate;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      productCode.hashCode ^
      productName.hashCode ^
      category.hashCode ^
      platform.hashCode ^
      brand.hashCode ^
      unit.hashCode ^
      quantity.hashCode ^
      purchasePrice.hashCode ^
      stockInDate.hashCode;
}

/// generated route for
/// [VerifyPhonePage]
class VerifyPhoneRoute extends PageRouteInfo<void> {
  const VerifyPhoneRoute({List<PageRouteInfo>? children})
    : super(VerifyPhoneRoute.name, initialChildren: children);

  static const String name = 'VerifyPhoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerifyPhonePage();
    },
  );
}
