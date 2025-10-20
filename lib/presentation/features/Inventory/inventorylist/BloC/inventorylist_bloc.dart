import 'package:flutter_bloc/flutter_bloc.dart';
import 'inventorylist_event.dart';
import 'inventorylist_state.dart';
import '../service/inventorylist_services.dart';
import '../models/inventorylist_model.dart'; // Model tidak langsung dipakai di BLoC, tapi di state

class InventoryListBloc extends Bloc<InventoryListEvent, InventoryListState> {
  // Dependency Injection: Inisialisasi service yang akan dipanggil
  final InventoryService inventoryService;

  InventoryListBloc({required this.inventoryService})
      : super(InventoryListInitial()) {

    // Daftarkan handler untuk event FetchInventoryList
    on<FetchInventoryList>(_onFetchInventoryList);
  }

  /// Handler yang menangani event FetchInventoryList.
  Future<void> _onFetchInventoryList(
      FetchInventoryList event,
      Emitter<InventoryListState> emit,
      ) async {
    // 1. Emit Loading state
    emit(InventoryListLoading());

    try {
      // 2. Panggil service untuk mengambil data
      final inventoryList = await inventoryService.fetchInventoryList();

      // 3. Emit Loaded state jika berhasil
      emit(InventoryListLoaded(inventory: inventoryList));
    } catch (e) {
      // 4. Emit Error state jika terjadi kesalahan (termasuk kesalahan jaringan atau API)
      print('BLoC Error fetching inventorylist: $e');
      emit(InventoryListError(message: e.toString()));
    }
  }
}
