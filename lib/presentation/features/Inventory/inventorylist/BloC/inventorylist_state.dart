import 'package:equatable/equatable.dart';
import '../models/inventorylist_model.dart';

/// Kelas dasar untuk semua state Inventory List.
abstract class InventoryListState extends Equatable {
  const InventoryListState();

  @override
  List<Object> get props => [];
}

/// State awal sebelum ada operasi yang dilakukan.
class InventoryListInitial extends InventoryListState {}

/// State saat data sedang dimuat (menampilkan loading indicator).
class InventoryListLoading extends InventoryListState {}

/// State saat data berhasil dimuat.
class InventoryListLoaded extends InventoryListState {
  final List<InventorylistModel> inventory;

  const InventoryListLoaded({required this.inventory});

  @override
  List<Object> get props => [inventory];
}

/// State saat terjadi error dalam pengambilan data.
class InventoryListError extends InventoryListState {
  final String message;

  const InventoryListError({required this.message});

  @override
  List<Object> get props => [message];
}
