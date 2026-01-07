import 'cart_item.dart';

class Order {
  final String id;
  final String orderNumber;
  final List<CartItem> items;
  final double totalPrice;
  final String address;
  final String phone;
  final DateTime orderDate;
  final OrderStatus status;

  Order({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.totalPrice,
    required this.address,
    required this.phone,
    required this.orderDate,
    this.status = OrderStatus.pending,
  });

  // Sipariş durumu güncelleme için copyWith
  Order copyWith({OrderStatus? status}) {
    return Order(
      id: id,
      orderNumber: orderNumber,
      items: items,
      totalPrice: totalPrice,
      address: address,
      phone: phone,
      orderDate: orderDate,
      status: status ?? this.status,
    );
  }
}

// Sipariş durumları
enum OrderStatus {
  pending('Hazırlanıyor'),
  shipped('Kargoda'),
  delivered('Teslim Edildi'),
  cancelled('İptal Edildi');

  final String label;
  const OrderStatus(this.label);
}
