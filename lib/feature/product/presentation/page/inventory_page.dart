import 'package:flutter/material.dart';

import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/constants/app_colors.dart';
import 'package:store_manage/core/constants/app_font_sizes.dart';
import 'package:store_manage/core/constants/app_fonts.dart';
import 'package:store_manage/core/constants/app_numbers.dart';
import 'package:store_manage/core/constants/app_strings.dart';
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

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        return product.code.toLowerCase().contains(keyword) || product.name.toLowerCase().contains(keyword);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: AppNumbers.DOUBLE_0,
        scrolledUnderElevation: AppNumbers.DOUBLE_0,
        surfaceTintColor: AppColors.background,
        title: const Text(
          AppStrings.homeTabInventory,
          style: TextStyle(
            fontSize: AppFontSizes.fontSize18,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.inter,
            color: AppColors.textPrimary,
          ),
        ),
      ),
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
