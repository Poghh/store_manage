class AppStrings {
  // === SYSTEM ===
  static const String VIET_NAM_LOCALE = 'vi_VN';
  static const String VIET_NAM_DONG_CURRENCY = '₫';
  static const String VIET_NAM_DONG_TEXT = 'VNĐ';
  static const String ACCESSTOKEN = 'access_token';
  static const String USERID = 'id';

  // === AUTH ===
  static const String USERNAME = 'Tên đăng nhập';
  static const String PASSWORD = 'Mật khẩu';
  static const String LOGIN = 'Đăng nhập';

  // === HOME ===
  static const String homeGreetingPrefix = 'Xin chào, ';
  static const String homeGreetingName = 'Thanh Phong';
  static const String homeDateDisplay = '19/01/2026';
  static const String homeRetailTitle = 'BÁN LẺ';
  static const String homeRetailSubtitle = 'Nhập nhanh';
  static const String homeStockInTitle = 'NHẬP HÀNG';
  static const String homeStockInSubtitle = 'Tìm kiếm';
  static const String homeProductSearchPlaceholder = 'Tìm sản phẩm';
  static const String todayRevenueLabel = 'Doanh thu hôm nay';
  static const String todayRevenueValue = '36.000.000 đ';
  static const String homeTabHome = 'Trang chủ';
  static const String homeTabTransactions = 'Giao dịch';
  static const String homeTabInventory = 'Tồn kho';
  static const String homeTabReports = 'Báo cáo';
  static const String homeTabProfile = 'Cá nhân';

  // === STOCK IN ===
  static const String stockInTitle = 'Nhập Hàng';
  static const String stockInSaveButton = 'LƯU NHẬP HÀNG';
  static const String stockInSearchPlaceholder = 'Tìm mã / tên sản phẩm';
  static const String stockInProductCodeLabel = 'Mã sản phẩm';
  static const String stockInProductNameLabel = 'Tên sản phẩm';
  static const String stockInCategoryLabel = 'Danh mục sản phẩm';
  static const String stockInPlatformLabel = 'Nền tảng / Dòng máy';
  static const String stockInModelLineLabel = 'Dòng máy';
  static const String stockInBrandLabel = 'Thương hiệu';
  static const String stockInUnitLabel = 'Đơn vị';
  static const String stockInQuantityLabel = 'Số lượng';
  static const String stockInPurchasePriceLabel = 'Giá nhập';
  static const String stockInDateLabel = 'Ngày nhập hàng';
  static const String stockInAutoCodeValue = 'Tự động';
  static const String stockInProductNameHint = 'Nhập tên sản phẩm';
  static const String stockInQuantityHint = 'Nhập số lượng';
  static const String stockInPriceHint = 'Nhập giá nhập';
  static const String stockInDatePlaceholder = 'Chọn ngày nhập';

  static const String stockInCategoryDevice = 'Thiết bị';
  static const String stockInCategoryAccessory = 'Phụ kiện';
  static const String stockInCategoryService = 'Dịch vụ';
  static const String stockInCategoryOther = 'Khác';

  static const String stockInPlatformAndroid = 'Android';
  static const String stockInPlatformIos = 'iOS';
  static const String stockInPlatformNone = 'Không';

  static const String stockInBrandApple = 'Apple';
  static const String stockInBrandSamsung = 'Samsung';
  static const String stockInBrandXiaomi = 'Xiaomi';
  static const String stockInBrandOppo = 'Oppo';
  static const String stockInBrandNone = 'Không thương hiệu';

  static const String stockInUnitPiece = 'cái';
  static const String stockInUnitBox = 'hộp';
  static const String stockInUnitSet = 'bộ';
  static const String stockInUnitKg = 'kg';

  static const String stockInValidationRequired = 'Vui lòng nhập thông tin';
  static const String stockInValidationPositiveNumber = 'Giá trị phải lớn hơn 0';
  static const String stockInValidationPositiveInteger = 'Số lượng phải lớn hơn 0';
  static const String stockInValidationFutureDate = 'Ngày nhập không được ở tương lai';
  static const String stockInSubmitSuccess = 'Lưu nhập hàng thành công';
  static const String stockInSubmitError = 'Lưu nhập hàng thất bại';
  static const String stockInApiNotConfigured = 'Chưa cấu hình API nhập hàng';
  static const String stockInQueued = 'Đã lưu offline, sẽ gửi khi có internet';

  // === PRODUCT DETAILS ===
  static const String productDetailsTitle = 'Chi Tiết Sản Phẩm';
  static const String productDetailsStockLabel = 'Tồn';
  static const String productDetailsSampleCode = 'SP-2026011102000';
  static const String productDetailsSampleName = 'iPhone 17';
  static const String productDetailsSampleCategory = 'Thiết bị';
  static const String productDetailsSamplePlatform = 'iOS';
  static const String productDetailsSampleBrand = 'Apple';
  static const String productDetailsSampleUnit = 'cái';
  static const String productDetailsSampleQuantity = '1';
  static const String productDetailsSamplePrice = '36.000.000 đ';
  static const String productDetailsSampleDate = '19/01/2026';
  static const String productDetailsSellButton = 'BÁN HÀNG';
  static const String productDetailsStockInButton = 'NHẬP THÊM';

  // === RETAIL ===
  static const String retailTitle = 'Bán Lẻ';
  static const String retailSearchPlaceholder = 'Tìm mã / tên sản phẩm';
  static const String retailQuantityLabel = 'Số lượng';
  static const String retailPriceLabel = 'Giá bán';
  static const String retailPriceHint = 'Nhập giá bán';
  static const String retailCashLabel = 'Tiền mặt';
  static const String retailTransferLabel = 'Chuyển khoản';
  static const String retailTotalLabel = 'Tổng tiền:';
  static const String retailConfirmButton = 'XÁC NHẬN BÁN';
  static const String retailSubmitSuccess = 'Đã lưu bán lẻ thành công';
  static const String retailSubmitError = 'Lưu bán lẻ thất bại';
  static const String retailQueued = 'Đã lưu bán lẻ offline, sẽ gửi khi có internet';
  static const String retailValidationSelectProduct = 'Vui lòng chọn sản phẩm';
  static const String retailValidationPrice = 'Vui lòng nhập giá bán';
}
