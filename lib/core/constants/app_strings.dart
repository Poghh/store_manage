class AppStrings {
  // === CHANGE PIN ===
  static const String changePinTitle = 'Đổi mã PIN';
  static const String changePinOldPinLabel = 'Mã PIN hiện tại';
  static const String changePinOldPin = 'Nhập mã PIN cũ';
  static const String changePinNewPinLabel = 'Mã PIN mới';
  static const String changePinNewPin = 'Nhập mã PIN mới';
  static const String changePinConfirmPinLabel = 'Xác nhận mã PIN';
  static const String changePinConfirmPin = 'Xác nhận mã PIN mới';
  static const String changePinButton = 'Đổi mã PIN';
  static const String changePinPinLength = 'Mã PIN phải đủ 4 số';
  static const String changePinConfirmNotMatch = 'Xác nhận mã PIN không khớp';
  static const String changePinOldPinIncorrect = 'Mã PIN cũ không đúng';
  static const String changePinSuccessTitle = 'Thành công';
  static const String changePinSuccessMessage = 'Đổi mã PIN thành công!';
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

  // === LOGIN ===
  static const String loginPhoneTitle = 'Nhập số điện thoại';
  static const String loginPhoneSubtitle = 'Vui lòng nhập số điện thoại để tiếp tục';
  static const String loginPhoneHint = 'Số điện thoại';
  static const String loginPhoneContinueButton = 'Tiếp tục';
  static const String loginPinTitle = 'Nhập mã PIN';
  static const String loginPinSubtitle = 'Nhập mã PIN 4 số để đăng nhập';
  static const String loginPinButton = 'Đăng nhập';
  static const String loginPinForgotButton = 'Quên mã PIN?';
  static const String loginForgotPinDialogTitle = 'Quên mã PIN?';
  static const String loginForgotPinDialogMessage =
      'Bạn sẽ cần xác minh lại số điện thoại và tạo mã PIN mới. Tiếp tục?';
  static const String loginForgotPinDialogCancel = 'Hủy';
  static const String loginForgotPinDialogConfirm = 'Xác nhận';
  static const String forgotPinPageTitle = 'Đặt lại mã PIN';
  static const String forgotPinPageDescription = 'Chọn cách bạn muốn khôi phục tài khoản:';
  static const String forgotPinOptionVerifyTitle = 'Xác minh số điện thoại';
  static const String forgotPinOptionVerifyDesc = 'Nhập đúng số điện thoại đã đăng ký để tạo mã PIN mới';
  static const String forgotPinOptionResetTitle = 'Xóa toàn bộ dữ liệu';
  static const String forgotPinOptionResetDesc = 'Không nhớ số điện thoại? Xóa tất cả dữ liệu và bắt đầu lại';
  static const String forgotPinCancelButton = 'Quay lại';
  static const String forgotPinResetDialogTitle = 'Xóa toàn bộ dữ liệu?';
  static const String forgotPinResetDialogMessage =
      'Hành động này sẽ xóa tất cả dữ liệu của ứng dụng bao gồm thông tin đăng nhập, giao dịch offline và cài đặt. Bạn không thể hoàn tác.';
  static const String forgotPinResetDialogCancel = 'Hủy';
  static const String forgotPinResetDialogConfirm = 'Xóa tất cả';
  static const String verifyPhoneTitle = 'Xác minh số điện thoại';
  static const String verifyPhoneSubtitle = 'Nhập số điện thoại bạn đã dùng để đăng ký';
  static const String verifyPhoneButton = 'Xác minh';
  static const String verifyPhoneError = 'Số điện thoại không khớp';
  static const String loginPinError = 'Mã PIN không đúng';
  static const String loginPinCreateSubtitle = 'Tạo mã PIN 4 số để đăng nhập';

  // === HOME ===
  static const String homeGreetingPrefix = 'Xin chào, ';
  static const String homeGreetingName = 'Thanh Phong';
  static const String homeRetailTitle = 'BÁN LẺ';
  static const String homeRetailSubtitle = 'Nhập nhanh';
  static const String homeStockInTitle = 'NHẬP HÀNG';
  static const String homeStockInSubtitle = 'Tìm kiếm';
  static const String homeProductSearchPlaceholder = 'Tìm sản phẩm';
  static const String todayRevenueLabel = 'Doanh thu hôm nay';
  static const String homeTabHome = 'Trang chủ';
  static const String homeTabTransactions = 'Giao dịch';
  static const String homeTabInventory = 'Tồn kho';
  static const String homeTabReports = 'Báo cáo';
  static const String homeTabProfile = 'Cá nhân';
  static const String homeRevenueYesterdayLabel = 'Doanh thu hôm qua';
  static String homeRevenueDateLabel(String date) => 'Doanh thu ngày $date';
  static const String homeMoneyTransactionTitle = 'CHUYỂN / RÚT TIỀN';
  static const String homeMoneyTransactionSubtitle = 'Giao dịch';

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
  static const String stockInImageLabel = 'Hình ảnh sản phẩm';
  static const String stockInImagePickButton = 'Chọn ảnh';
  static const String stockInImageRemoveButton = 'Xóa ảnh';
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
  static const String stockInLotChangeTitle = 'Xác nhận lô nhập';
  static const String stockInLotChangeMessage =
      'Giá nhập hoặc ngày nhập khác lô hiện có. Bạn muốn tạo lô mới hay cập nhật lô hiện tại?';
  static const String stockInLotCreateButton = 'Tạo lô mới';
  static const String stockInLotUpdateButton = 'Cập nhật lô hiện tại';
  static const String stockInLotCancelButton = 'Hủy';

  // === PRODUCT DETAILS ===
  static const String productDetailsTitle = 'Chi Tiết Sản Phẩm';
  static const String productDetailsStockLabel = 'Tồn';
  static const String productDetailsSellButton = 'BÁN HÀNG';
  static const String productDetailsStockInButton = 'NHẬP THÊM';
  static const String productEditButton = 'CHỈNH SỬA THÔNG TIN';
  static const String productDeleteButton = 'XÓA SẢN PHẨM';
  static const String productEditTitle = 'Chỉnh sửa sản phẩm';
  static const String productEditSaveButton = 'LƯU THAY ĐỔI';
  static const String productDeleteConfirmTitle = 'Xóa sản phẩm';
  static const String productDeleteConfirmMessage = 'Bạn có chắc muốn xóa sản phẩm này không?';
  static const String productDeleteCancel = 'Hủy';
  static const String productDeleteConfirm = 'Xóa';
  static const String productDeleteSuccess = 'Đã xóa sản phẩm';
  static const String productDeleteQueued = 'Đã lưu xóa offline, sẽ gửi khi có internet';
  static const String productDeleteError = 'Xóa sản phẩm thất bại';
  static const String productAdjustButton = 'ĐIỀU CHỈNH TỒN KHO';
  static const String productAdjustTitle = 'Điều chỉnh tồn kho';
  static const String productAdjustIncrease = 'Tăng';
  static const String productAdjustDecrease = 'Giảm';
  static const String productAdjustQuantityHint = 'Nhập số lượng';
  static const String productAdjustCancel = 'Hủy';
  static const String productAdjustConfirm = 'Xác nhận';
  static const String productAdjustInvalid = 'Số lượng không hợp lệ';
  static const String productAdjustExceed = 'Không thể giảm quá tồn hiện tại';
  static const String productAdjustSuccess = 'Đã điều chỉnh tồn kho';

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
  static const String retailValidationQuantityExceed = 'Số lượng bán vượt tồn kho';

  // === TRANSACTIONS ===
  static const String transactionsSelectDate = 'Chọn ngày';
  static const String transactionsEmptySelectDate = 'Vui lòng chọn ngày';
  static const String transactionsEmptyNoData = 'Không có dữ liệu giao dịch trong ngày này';
  static const String transactionsTotalRevenueLabel = 'Tổng doanh thu';
  static const String transactionsItemQuantitySoldLabel = 'SL bán';
  static const String transactionsItemPriceLabel = 'Giá bán';
  static const String transactionsItemTotalLabel = 'Thành tiền';

  // === REPORTS ===
  static const String reportSummaryTitle = 'Tóm tắt doanh thu';
  static const String reportTodayLabel = 'Hôm nay';
  static const String reportYesterdayLabel = 'Hôm qua';
  static const String reportCompareYesterday = 'so với hôm qua';
  static const String reportNoData = 'Chưa có dữ liệu';
  static String reportGrowthLabel(double percentage) {
    final sign = percentage >= 0 ? '+' : '';
    return '$sign${percentage.toStringAsFixed(1)}% so với hôm qua';
  }

  static const String reportAiTitle = 'AI phân tích & gợi ý';
  static const String reportSuggestionTitle = 'Đề xuất';
  static const String reportBulletPrefix = '• ';

  // === PROFILE ===
  static const String profileName = 'Thanh Phong';
  static const String profileEmail = 'thanhphong@store.vn';
  static const String profileSectionAccount = 'Tài khoản';
  static const String profileSectionSettings = 'Cài đặt';
  static const String profileSectionSupport = 'Hỗ trợ';
  static const String profileItemPersonalInfo = 'Thông tin cá nhân';
  static const String profileItemChangePassword = 'Đổi mật khẩu';
  static const String profileItemNotifications = 'Thông báo';
  static const String profileItemLanguage = 'Ngôn ngữ';
  static const String profileItemTheme = 'Giao diện';
  static const String profileItemHelpCenter = 'Trung tâm trợ giúp';
  static const String profileItemContactSupport = 'Liên hệ hỗ trợ';
  static const String profileLogout = 'Đăng xuất';

  // === CONNECTIVITY ===
  static const String connectivityOnline = 'Đã kết nối internet';
  static const String connectivityOffline = 'Mất kết nối internet';

  // === PERMISSIONS ===
  static const String photoPermissionDenied = 'Không có quyền truy cập ảnh';

  // === MONEY TRANSACTION ===
  static const moneyTransactionTitle = 'Chuyển / Rút tiền';
  static const transferMoney = 'Chuyển tiền';
  static const withdrawCash = 'Rút tiền mặt';
  static const amountLabel = 'Số tiền';
  static const bankLabel = 'Ngân hàng';
  static const transactionFeeLabel = 'Phí giao dịch (0.5%)';
  static const totalAmountLabel = 'Tổng tiền';
  static const confirmTransaction = 'Xác nhận giao dịch';

  // === LOGOUT ===
  static const String logoutTitle = 'Đăng xuất';
  static const String logoutMessage = 'Bạn có chắc muốn đăng xuất?';
  static const String logoutConfirm = 'Đăng xuất';
  static const String logoutCancel = 'Hủy';

  // === SETUP PROFILE ===
  static const String setupProfileTitle = 'Thiết lập thông tin';
  static const String setupProfileSubtitle = 'Nhập thông tin cá nhân để tiếp tục';
  static const String setupProfileNameLabel = 'Tên của bạn';
  static const String setupProfileNameHint = 'Nhập tên của bạn';
  static const String setupProfileStoreLabel = 'Tên cửa hàng';
  static const String setupProfileStoreHint = 'Nhập tên cửa hàng';
  static const String setupProfileButton = 'Hoàn tất';
  static const String setupProfileNameRequired = 'Vui lòng nhập tên';
  static const String setupProfileStoreRequired = 'Vui lòng nhập tên cửa hàng';

  // === EDIT PROFILE ===
  static const String editProfileTitle = 'Thông tin cá nhân';
  static const String editProfileSaveButton = 'Lưu thay đổi';
  static const String editProfileSaveSuccess = 'Đã lưu thông tin';
  static const String editProfileAvatarLabel = 'Ảnh đại diện';
  static const String editProfileAvatarChangeButton = 'Đổi ảnh';
  static const String editProfileAvatarRemoveButton = 'Xóa ảnh';
  static const String editProfileNameLabel = 'Tên của bạn';
  static const String editProfileStoreLabel = 'Tên cửa hàng';
}
