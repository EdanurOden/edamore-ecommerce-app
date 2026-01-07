import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        title: Text(
          'EDAMORE',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //  Profil Header
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Açık gri
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!, width: 1),
                ),
                child: Row(
                  children: [
                    // Profil İkonu
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey[500],
                      child: Icon(Icons.person, size: 45, color: Colors.white),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'İsim Soyisim',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            user?.email ?? 'email@test.com',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ÇIKIŞ Butonu
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Çıkış Yap'),
                              ],
                            ),
                            content: Text(
                              'Hesaptan çıkış yapmak istediğinize emin misiniz?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'İPTAL',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  authProvider.logout();
                                  Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text('ÇIKIŞ YAP'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey[600]!,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Kişisel Bilgilerim ve Mesajlarım
              Row(
                children: [
                  Expanded(
                    child: _buildTopButton(
                      context,
                      'KİŞİSEL\nBİLGİLERİM',
                      Color(0xFFD4A5B0),
                      () => Navigator.pushNamed(context, '/edit-profile'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildTopButton(
                      context,
                      'MESAJLARIM',
                      Colors.white,
                      () => Navigator.pushNamed(context, '/messages'),
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Sipariş Takip
              _buildWhiteCard(
                context,
                icon: Icons.local_shipping_outlined,
                title: 'SİPARİŞ TAKİP',
              ),

              SizedBox(height: 16),

              // Grid Butonlar
              Row(
                children: [
                  Expanded(
                    child: _buildGridButton(
                      context,
                      Icons.favorite_border,
                      'FAVORİLERİM',
                      '/favorites',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildGridButton(
                      context,
                      Icons.shopping_bag_outlined,
                      'SİPARİŞLERİM',
                      '/orders',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildGridButton(
                      context,
                      Icons.location_on_outlined,
                      'ADRESLERİM',
                      '/addresses',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),
              //empty
              Row(
                children: [
                  Expanded(
                    child: _buildGridButton(
                      context,
                      Icons.notifications_outlined,
                      'STOK ALARM\nLİSTEM',
                      '/stock-alert-empty',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildGridButton(
                      context,
                      Icons.sync_alt,
                      'DEĞİŞİM /\nİADE TALEBİ',
                      '/return-empty',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildGridButton(
                      context,
                      Icons.card_giftcard_outlined,
                      'HEDİYE\nÇEKLERİM',
                      '/gift-empty',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onTap, {
    Color textColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWhiteCard(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 28, color: Colors.black87),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Sipariş Numarası :',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'ARA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridButton(
    BuildContext context,
    IconData? icon,
    String title,
    String route, {
    String? customIconPath,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        height: 100,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (customIconPath != null)
              Image.asset(customIconPath, width: 28, height: 28)
            else
              Icon(icon, size: 28, color: Colors.black87),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
