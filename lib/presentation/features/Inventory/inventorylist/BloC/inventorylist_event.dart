import 'package:equatable/equatable.dart';

/// Kelas dasar untuk semua event Inventory List.
abstract class InventoryListEvent extends Equatable {
  const InventoryListEvent();

  @override
  List<Object> get props => [];
}

/// Event untuk memicu pengambilan data Inventory List.
class FetchInventoryList extends InventoryListEvent {
  // Parameter paginasi dapat ditambahkan di sini jika diperlukan.
  const FetchInventoryList();

  @override
  List<Object> get props => [];
}
