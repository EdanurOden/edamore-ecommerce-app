import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sipariş numarasını al (checkout'tan gönderildi)
    final orderNumber = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, size: 80, color: Colors.green),
              ),

              SizedBox(height: 32),

              Text(
                'Siparişiniz Alındı!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),

              Text(
                'Ödemeniz başarıyla gerçekleştirildi. Siparişiniz en kısa sürede kargoya verilecektir.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48),

              // Sipariş numarası
              if (orderNumber != null)
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Sipariş Numaranız',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '#$orderNumber',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7A9EAF),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 48),

              CustomButton(
                text: 'ANA SAYFAYA DÖN',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
              ),

              SizedBox(height: 12),

              CustomButton(
                text: 'SİPARİŞLERİMİ GÖRÜNTÜLE',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                  // Profile sayfasına git ve oradan siparişlerim'e yönlendir
                  Future.delayed(Duration(milliseconds: 100), () {
                    Navigator.pushNamed(context, '/orders');
                  });
                },
                isOutlined: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
