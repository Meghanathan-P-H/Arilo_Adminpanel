import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmouts = <OrderStatus, double>{}.obs;

  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0912',
      status: OrderStatus.processing,
      totalAmount: 265,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
      deliveryDate: DateTime.now().add(const Duration(days: 2)),
    ),
    OrderModel(
      id: 'CWT0925',
      status: OrderStatus.shipped,
      totalAmount: 369,
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
      deliveryDate: DateTime.now().add(const Duration(days: 1)),
    ),
    OrderModel(
      id: 'CWT9152',
      status: OrderStatus.delivered,
      totalAmount: 254,
      orderDate: DateTime.now().subtract(const Duration(days: 3)),
      deliveryDate: DateTime.now(),
    ),
    OrderModel(
      id: 'CWT0265',
      status: OrderStatus.delivered,
      totalAmount: 355,
      orderDate: DateTime.now().subtract(const Duration(days: 4)),
      deliveryDate: DateTime.now(),
    ),
    OrderModel(
      id: 'CWT1536',
      status: OrderStatus.delivered,
      totalAmount: 115,
      orderDate: DateTime.now().subtract(const Duration(days: 5)),
      deliveryDate: DateTime.now(),
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  void _calculateWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      int dayIndex = order.orderDate.weekday - 1;
      weeklySales[dayIndex] += order.totalAmount;

      print(
        'Added ${order.totalAmount} to day $dayIndex (${_getDayName(dayIndex)})',
      );
    }

    print('Final Weekly Sales: $weeklySales');
  }

  void _calculateOrderStatusData() {
    orderStatusData.clear();

    totalAmouts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      totalAmouts[status] = (totalAmouts[status] ?? 0) + order.totalAmount;
    }
  }

  String _getDayName(int index) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[index];
  }
}

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime deliveryDate;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.deliveryDate,
  });
}
