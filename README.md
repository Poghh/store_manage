# Store Manage

## 1) Giới thiệu dự án

- Ứng dụng quản lý cửa hàng với các luồng chính: Trang chủ, Nhập hàng, Tồn kho, Bán lẻ, Chi tiết sản phẩm.
- Tìm kiếm sản phẩm dùng chung `ProductSearchBar` với overlay autocomplete.
- Bán lẻ có giá bán nhập tay, hiển thị giá nhập (disable), chọn phương thức thanh toán.

## 2) Công nghệ sử dụng

- Flutter (Dart SDK ^3.10.7 theo pubspec).
- Quản lý state: flutter_bloc (Cubit).
- Thư viện chính:
  - auto_route (định tuyến).
  - persistent_bottom_nav_bar (bottom tabs).
  - dio (network client).
  - get_it (DI).
  - flutter_secure_storage, encrypted_shared_preferences (lưu trữ).
  - logger (logging).
  - flutter_svg (SVG assets).
  - intl (format).
  - freezed_annotation, json_serializable + build_runner (codegen).

## 3) Cấu trúc project

- Theo kiểu feature-based + layered:
  - lib/core
    - constants: AppColors, AppFonts, AppFontSizes, AppNumbers, AppStrings.
    - theme: AppTheme.
    - navigation: auto_route router + route_observer.
    - DI: get_it setup.
    - network: NetworkClient.
    - storage: SecureStorage.
  - lib/feature
    - home
      - presentation/page: HomePage, HomeTabsPage.
      - presentation/widgets: UI widgets + ProductSearchBar.
      - presentation/cubit: HomeCubit + HomeState.
    - product
      - data: Product model + repository.
      - presentation/page: ProductDetailsPage, InventoryPage.
      - presentation/widgets: product header, info row, inventory widgets.
      - presentation/cubit: ProductSearchCubit.
    - stock_in
      - data: StockInRepository.
      - presentation/page: StockInPage.
      - presentation/widgets: StockInBody, StockInForm, StockInSearchBar, StockInSubmitButton.
      - presentation/cubit: StockInCubit + StockInState.
    - retail
      - presentation/page: RetailPage.
      - presentation/widgets: RetailContent + form widgets.

## 4) Kiến trúc quản lý state

- Cubit được khai báo trong `feature/*/presentation/cubit`.
- Trang dùng `BlocProvider`/`MultiBlocProvider` để inject Cubit.
- `BlocListener` dùng cho phản hồi submit (Stock In), `BlocBuilder` dùng khi cần phản ứng theo state.

## 5) Hướng dẫn chạy project

1. Cài Flutter SDK phù hợp (Dart SDK ^3.10.7).
2. Cài dependencies:
   - flutter pub get
3. Chạy ứng dụng:
   - flutter run -t lib/main.dart
   - flutter run -t lib/main_dev.dart
   - flutter run -t lib/main_stg.dart
4. Khi thay đổi route (auto_route):
   - dart run build_runner build --delete-conflicting-outputs

## 6) Quy ước phát triển

- Tên file: snake_case, class: PascalCase.
- Thêm màn hình mới:
  1. Tạo page trong feature/<feature>/presentation/page.
  2. Gắn @RoutePage và đăng ký trong AppRouter.
  3. Chạy build_runner để cập nhật route.
- Thêm widget UI dùng chung: đặt trong feature/<feature>/presentation/widgets.
- String hiển thị phải dùng AppStrings; màu sắc dùng AppColors; kích thước dùng AppNumbers/AppFontSizes.

## 7) Lưu ý quan trọng

- Không hard-code màu sắc, kích thước, text hiển thị; dùng constants trong core/constants.
- Tuân thủ cấu trúc feature-based + layered như hiện tại.
