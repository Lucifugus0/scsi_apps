class ApiLink{
  static const baseUrl = "https://mmp.integrated-os.cloud/api/v1";
  static const inventoryList = "$baseUrl/inventory";
  static const inventoryAdd = inventoryList;
  static const inventoryEdit = "$inventoryList/{id_barang}";
  static const inventoryDelete = "$inventoryList/{id_barang}/soft-delete";
}