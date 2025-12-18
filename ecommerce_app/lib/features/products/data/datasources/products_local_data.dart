abstract class ProductsLocalData {
  Future<List<Map<String, dynamic>>> getLastProduct();
  Future<void> cacheProduct(List<Map<String, dynamic>> products);
}