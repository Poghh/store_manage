import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_strings.dart';
import 'package:store_manage/core/services/inventory_adjustment_service.dart';
import 'package:store_manage/core/widgets/app_page_header.dart';
import 'package:store_manage/feature/product/data/repositories/product_repository.dart';
import 'package:store_manage/feature/product/data/models/product.dart';
import 'package:store_manage/feature/product/presentation/widgets/inventory_body.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = const [];
  List<Product> _filteredProducts = const [];
  bool _isLoading = true;
  late final InventoryAdjustmentService _inventoryService;
  late final ValueListenable _inventoryBoxListenable;

  @override
  void initState() {
    super.initState();
    _inventoryService = di<InventoryAdjustmentService>();
    _inventoryBoxListenable = _inventoryService.listenable;
    _inventoryBoxListenable.addListener(_handleInventoryChange);
    _loadProducts();
  }

  @override
  void dispose() {
    _inventoryBoxListenable.removeListener(_handleInventoryChange);
    _searchController.dispose();
    super.dispose();
  }

  void _handleInventoryChange() {
    if (!mounted) return;
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
