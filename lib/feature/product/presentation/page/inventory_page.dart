import 'package:flutter/material.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/navigation/home_tab_coordinator.dart';
import 'package:store_manage/core/widgets/app_page_header.dart';
import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/presentation/widgets/inventory_body.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _searchController = TextEditingController();
  late final HomeTabCoordinator _tabCoordinator;

  List<Product> _allProducts = const [];
  List<Product> _filteredProducts = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabCoordinator = di<HomeTabCoordinator>();
    _tabCoordinator.inventoryRefreshTrigger.addListener(_onRefreshTriggered);
    _loadProducts();
  }

  @override
  void dispose() {
    _tabCoordinator.inventoryRefreshTrigger.removeListener(_onRefreshTriggered);
    _searchController.dispose();
    super.dispose();
  }

  void _onRefreshTriggered() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    try {
      final items = await di<ProductRepository>().searchProducts('');
      setState(() {
        _allProducts = items;
        _filteredProducts = items;
        _isLoading = false;
      });
    } catch (_) {
      setState(() {
        _allProducts = const [];
        _filteredProducts = const [];
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String value) {
    final keyword = value.trim().toLowerCase();
    if (keyword.isEmpty) {
      setState(() => _filteredProducts = _allProducts);
      return;
    }

    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.productCode.toLowerCase().contains(keyword) ||
            product.productName.toLowerCase().contains(keyword);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppPageHeader(title: AppStrings.homeTabInventory),
      body: SafeArea(
        child: InventoryBody(
          searchController: _searchController,
          onSearchChanged: _onSearchChanged,
          isLoading: _isLoading,
          products: _filteredProducts,
        ),
      ),
    );
  }
}
