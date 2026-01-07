import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/cart_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers/auth_provider.dart';
import '../../core/widgets/custom_button.dart';
import '../../data/models/order.dart';
import '../../data/models/cart_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user != null) {
      _addressController.text = user.address;
      _phoneController.text = user.phone;
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _cardNumberController.dispose();
    _cardNameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // sahte ödeme işlemi (2 saniye bekle)
    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Sipariş numarası oluştur
      final orderNumber = DateTime.now().millisecondsSinceEpoch
          .toString()
          .substring(7);

      // Sepetteki ürünlerin kopyasını al (sepet temizlenince silinmesin diye)
      final orderItems = cartProvider.cartItems.map((item) {
        return CartItem(product: item.product, quantity: item.quantity);
      }).toList();

      // Siparişi oluştur ve kaydet
      final order = Order(
        id: DateTime.now().toString(),
        orderNumber: orderNumber,
        items: orderItems,
        totalPrice: cartProvider.totalPrice,
        address: _addressController.text,
        phone: _phoneController.text,
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
      );

      authProvider.addOrder(order);

      // Sepeti temizle
      cartProvider.clearCart();

      // Başarı ekranına git (sipariş numarasını gönder)
      Navigator.pushReplacementNamed(
        context,
        '/order-success',
        arguments: orderNumber,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundBlue,
      appBar: AppBar(title: Text('ÖDEME')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildSection(
              title: 'TESLİMAT BİLGİLERİ',
              children: [
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Adres',
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Adres gerekli';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefon',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Telefon gerekli';
                    }
                    return null;
                  },
                ),
              ],
            ),

            SizedBox(height: 24),

            _buildSection(
              title: 'KART BİLGİLERİ',
              children: [
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Kart Numarası',
                    prefixIcon: Icon(Icons.credit_card),
                    hintText: '1234 5678 9012 3456',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 19,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kart numarası gerekli';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _cardNameController,
                  decoration: InputDecoration(
                    labelText: 'Kart Üzerindeki İsim',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'İsim gerekli';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryController,
                        decoration: InputDecoration(
                          labelText: 'Son Kullanma',
                          hintText: 'AA/YY',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tarih gerekli';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          hintText: '123',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'CVV gerekli';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 24),

            _buildOrderSummary(cart),

            SizedBox(height: 24),

            CustomButton(
              text: 'ÖDEMEYİ TAMAMLA',
              onPressed: _processPayment,
              isLoading: _isLoading,
            ),

            SizedBox(height: 16),

            Text(
              '🔒 Güvenli Ödeme',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cart) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SİPARİŞ ÖZETİ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ara Toplam:', style: TextStyle(color: Colors.grey[700])),
              Text('${cart.totalPrice.toStringAsFixed(2)} TL'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kargo:', style: TextStyle(color: Colors.grey[700])),
              Text('Ücretsiz', style: TextStyle(color: Colors.green)),
            ],
          ),
          Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Toplam:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${cart.totalPrice.toStringAsFixed(2)} TL',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7A9EAF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
