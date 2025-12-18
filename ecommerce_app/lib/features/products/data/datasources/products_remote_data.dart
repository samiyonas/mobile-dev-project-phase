abstract class ProductsRemoteData {
  Future<List<Map<String, dynamic>>> viewAllProducts();
  Future<Map<String, dynamic>> getProduct(int id);
  Future<Map<String, dynamic>> insertProduct(Map<String, dynamic> product);
  Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> product);
  Future<void> deleteProduct(int id);
}