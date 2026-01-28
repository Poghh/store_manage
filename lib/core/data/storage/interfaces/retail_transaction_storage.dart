abstract class RetailTransactionStorage {
  Future<void> addTransaction(Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> getAll();
}
