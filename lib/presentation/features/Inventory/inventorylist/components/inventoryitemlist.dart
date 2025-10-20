import 'package:flutter/material.dart';
import '../models/inventorylist_model.dart';

class InventoryItemList extends StatelessWidget {
  final InventorylistModel item;
  const InventoryItemList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('ID: ${item.id} - QTY: ${item.qty} - UNIT: ${item.unit}'),
          Text('WEIGHT: ${item.weight} - PRICE: ${item.priceFormatted}'),
        ],
      ),
    );
  }
}