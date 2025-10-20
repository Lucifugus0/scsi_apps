import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/constants/api_constants.dart'; // Pastikan path ini benar
import '../models/inventorylist_model.dart'; // Pastikan path model ini benar

class InventoryService {
  Future<List<InventorylistModel>> fetchInventoryList() async {
    final url = Uri.parse(ApiLink.inventoryList);
    const String serviceName = "INVENTORY_LIST";

    // Log URL yang dipanggil
    print("➡️ $serviceName: Fetching inventorylist list for URL: $url ");


    http.Response response;

    try {
      response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache',
        // Tambahkan header otorisasi jika diperlukan di sini:
        // 'Authorization': 'Bearer $yourAuthToken',
      });
    } catch (e) {
      print('❌ $serviceName: Network error or server unreachable: $e');
      throw Exception('Tidak dapat terhubung ke server untuk mengambil daftar inventaris: $e');
    }

    // ------------------------------------
    // DEBUGGING UNTUK KODE STATUS DAN BODY RESPONS
    // ------------------------------------
    print('✅ $serviceName: Response Status Code: ${response.statusCode}');
    // Mencetak seluruh response body. Hati-hati dengan respons yang sangat panjang.
    print('ℹ️ $serviceName: Full Response Body:\n${response.body}\n');
    // ------------------------------------


    final statusCode = response.statusCode;
    dynamic body;

    if (response.body.isNotEmpty) {
      try {
        body = json.decode(response.body);
      } catch (e) {
        print('❌ $serviceName: Gagal mengurai JSON response: $e');
        if (statusCode >= 200 && statusCode < 300) {
          throw Exception('Format respons server tidak valid untuk daftar inventaris.');
        }
      }
    }

    switch (statusCode) {
      case 200:
      case 201:
      // ASUMSI UTAMA: Data list inventaris berada di field 'data' dan merupakan List
        if (body != null && body['data'] is List) {
          print("✅ $serviceName: Successfully fetched inventorylist list. Total items: ${body['data'].length}");

          final List<InventorylistModel> inventoryList = (body['data'] as List)
              .map((jsonItem) => InventorylistModel.fromJson(jsonItem))
              .toList();

          return inventoryList;
        }
        // ASUMSI ALTERNATIF: API menggunakan format pagination { "data": { "data": [...] } }
        else if (body != null && body['data'] != null && body['data']['data'] is List) {
          print("✅ $serviceName: Successfully fetched inventorylist list (Paginated format). Total items: ${body['data']['data'].length}");

          final List<InventorylistModel> inventoryList = (body['data']['data'] as List)
              .map((jsonItem) => InventorylistModel.fromJson(jsonItem))
              .toList();

          return inventoryList;
        }
        // Kasus sukses tapi data list kosong atau format tidak terduga
        else {
          print('❌ $serviceName: Sukses tapi format data list tidak sesuai: ${response.body}');
          // Mengembalikan list kosong jika sukses tetapi data tidak ada/format berbeda
          return [];
        }

      case 400: // Bad Request
        print('❌ $serviceName: Error 400 - Permintaan Buruk: ${body?['message']}');
        throw Exception(body?['message'] ?? 'Permintaan tidak valid (400)');

      case 401: // Unauthorized
        print('❌ $serviceName: Error 401 - Tidak Terautentikasi.');
        throw Exception('Sesi Anda telah berakhir. Mohon login ulang (401).');

      case 403: // Forbidden
        print('❌ $serviceName: Error 403 - Dilarang.');
        throw Exception('Akses ditolak (403).');

      case 404: // Not Found (Endpoint salah)
        print('❌ $serviceName: Error 404 - Tidak Ditemukan. Endpoint API salah.');
        throw Exception('Daftar inventaris tidak ditemukan atau endpoint API salah (404).');

      case 422: // Unprocessable Entity (Validasi gagal pada query/filter)
        final errors = body?['errors'];
        if (errors != null && errors is Map) {
          final errorMessages = errors.values
              .map((e) => (e is List && e.isNotEmpty) ? e[0] : e.toString())
              .join(', ');
          print('❌ $serviceName: Error 422 - Validasi Gagal: $errorMessages');
          throw Exception(errorMessages);
        }
        print('❌ $serviceName: Error 422 - Entitas Tidak Dapat Diproses: ${body?['message']}');
        throw Exception(body?['message'] ?? 'Parameter yang dikirim tidak valid (422).');

      case 500: // Internal Server Error
        print('❌ $serviceName: Error 500 - Kesalahan Server Internal.');
        throw Exception('Terjadi kesalahan server internal (500).');

      default: // Status code lainnya
        print('❌ $serviceName: Error Tidak Terduga - Status Code: $statusCode, Pesan: ${body?['message']}');
        throw Exception('Terjadi kesalahan tidak terduga (${statusCode}): ${body?['message'] ?? 'Tidak diketahui'}.');
    }
  }
}