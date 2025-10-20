import 'package:flutter/material.dart';

class InventorylistModel {
  final String id;
  final String category;
  final String name;
  final int qty;
  final String unit;
  final int weight;
  final String priceFormatted;

  InventorylistModel({
    required this.id,
    required this.category,
    required this.name,
    required this.qty,
    required this.unit,
    required this.weight,
    required this.priceFormatted,
  });

  factory InventorylistModel.fromJson(Map<String, dynamic> json) {
    return InventorylistModel(
      id: json['id']?.toString() ?? '',
      category: json['category'] as String? ?? 'N/A',
      name: json['name'] as String? ?? 'Unknown Item',
      qty: (json['qty'] is String) ? int.tryParse(json['qty']) ?? 0 : json['qty'] as int? ?? 0,
      unit: json['unit'] as String? ?? 'Pcs',
      weight: (json['weight'] is String) ? int.tryParse(json['weight']) ?? 0 : json['weight'] as int? ?? 0,
      priceFormatted: json['priceFormatted'] as String? ?? 'Rp 0,00',
    );
  }
}

final List<InventorylistModel> dummyInventory = [
  InventorylistModel(id: '0000001', category: 'Eksplorasi', name: 'Batu Asah', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000002', category: 'Eksplorasi', name: 'Baut 10', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000003', category: 'Eksplorasi', name: 'Baut 17', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000004', category: 'Eksplorasi', name: 'Baut 24', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000005', category: 'Eksplorasi', name: 'Borax Las Powder', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000001', category: 'Eksplorasi', name: 'Batu Asah', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000002', category: 'Eksplorasi', name: 'Baut 10', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000003', category: 'Eksplorasi', name: 'Baut 17', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000004', category: 'Eksplorasi', name: 'Baut 24', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000005', category: 'Eksplorasi', name: 'Borax Las Powder', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000001', category: 'Eksplorasi', name: 'Batu Asah', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000002', category: 'Eksplorasi', name: 'Baut 10', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000003', category: 'Eksplorasi', name: 'Baut 17', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000004', category: 'Eksplorasi', name: 'Baut 24', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000005', category: 'Eksplorasi', name: 'Borax Las Powder', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000001', category: 'Eksplorasi', name: 'Batu Asah', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000002', category: 'Eksplorasi', name: 'Baut 10', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000003', category: 'Eksplorasi', name: 'Baut 17', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000004', category: 'Eksplorasi', name: 'Baut 24', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
  InventorylistModel(id: '0000005', category: 'Eksplorasi', name: 'Borax Las Powder', qty: 1, unit: 'Pcs', weight: 1, priceFormatted: 'Rp 0,00'),
];