import 'package:flutter/material.dart';

class AriloHelperFunctions {
  
  static DateTime getStartOfWeek(DateTime date) {
    final int daysUntilMonday = date.weekday - 1;
    final DateTime startOfWeek = date.subtract(Duration(days: daysUntilMonday));
    return DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
      0, 0, 0, 0,
    );
  }

  /// Returns a color based on the order status
  static Color getOrderStatusColor(OrderStatus value) {
    switch (value) {
      case OrderStatus.pending:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.orange;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      }
  }
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}