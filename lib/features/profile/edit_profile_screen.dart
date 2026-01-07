import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/auth_provider.dart';
import '../../core/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Üyelik Bilgileri Controllers
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _tcController;
  late TextEditingController _phoneController;
  late TextEditingController _postalCodeController;
  late TextEditingController _cityController;
  late TextEditingController _districtController;
  late TextEditingController _addressController;

  // Şifre Bilgileri Controllers
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();

    // Controller'ları initialize et
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _emailController = TextEditingController();
    _tcController = TextEditingController();
    _phoneController = TextEditingController();
    _postalCodeController = TextEditingController();
    _cityController = TextEditingController();
    _districtController = TextEditingController();
    _addressController = TextEditingController();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Her açılışta verileri yükle
    _loadUserData();
  }

  void _loadUserData() {
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;

    if (user != null) {
      // Ad ve soyadı ayır
      final nameParts = user.name.trim().split(' ');
      _nameController.text = nameParts.first;
      _surnameController.text = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : '';

      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _addressController.text = user.address;
      _tcController.text = user.tcNo ?? '';
      _postalCodeController.text = user.postalCode ?? '';
      _cityController.text = user.city ?? '';
      _districtController.text = user.district ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _tcController.dispose();
    _phoneController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _addressController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Validation
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Lütfen adınızı girin!', Colors.red);
      return;
    }

    if (_surnameController.text.trim().isEmpty) {
      _showSnackBar('Lütfen soyadınızı girin!', Colors.red);
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _showSnackBar('Lütfen e-posta adresinizi girin!', Colors.red);
      return;
    }

    // Profil güncelleme - TÜM ALANLARI KAYDET
    authProvider.updateProfile(
      name: '${_nameController.text.trim()} ${_surnameController.text.trim()}',
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      tcNo: _tcController.text.trim(),
      postalCode: _postalCodeController.text.trim(),
      city: _cityController.text.trim(),
      district: _districtController.text.trim(),
    );

    _showSnackBar('✓ Bilgileriniz başarıyla güncellendi!', Colors.green);
  }

  void _updatePassword() {
    if (_currentPasswordController.text.isEmpty) {
      _showSnackBar('Lütfen mevcut şifrenizi girin!', Colors.red);
      return;
    }

    if (_newPasswordController.text.isEmpty) {
      _showSnackBar('Lütfen yeni şifrenizi girin!', Colors.red);
      return;
    }

    if (_newPasswordController.text.length < 6) {
      _showSnackBar('Şifre en az 6 karakter olmalıdır!', Colors.red);
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showSnackBar('Yeni şifreler eşleşmiyor!', Colors.red);
      return;
    }

    _showSnackBar('✓ Şifreniz başarıyla güncellendi!', Colors.green);

    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'EDAMORE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // ÜYELİK BİLGİLERİM BÖLÜMÜ
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Üyelik Bilgilerim',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  _buildTextField(_nameController, 'Ad*'),
                  SizedBox(height: 12),

                  _buildTextField(_surnameController, 'Soyad*'),
                  SizedBox(height: 12),

                  _buildTextField(
                    _emailController,
                    'E-posta*',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12),

                  _buildTextField(
                    _tcController,
                    'T.C kimlik No*',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 12),

                  _buildTextField(
                    _phoneController,
                    'Telefon No*',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 12),

                  _buildTextField(
                    _postalCodeController,
                    'Posta Kodu*',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 12),

                  _buildTextField(_cityController, 'İl*'),
                  SizedBox(height: 12),

                  _buildTextField(_districtController, 'İlçe*'),
                  SizedBox(height: 12),

                  _buildTextField(_addressController, 'Adres*', maxLines: 3),
                  SizedBox(height: 20),

                  // GÜNCELLE Butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'GÜNCELLE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // ŞİFRE BİLGİLERİM BÖLÜMÜ
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Şifre Bilgilerim',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  _buildTextField(
                    _currentPasswordController,
                    'Mevcut Şifre*',
                    obscureText: true,
                  ),
                  SizedBox(height: 12),

                  _buildTextField(
                    _newPasswordController,
                    'Yeni Şifre*',
                    obscureText: true,
                  ),
                  SizedBox(height: 12),

                  _buildTextField(
                    _confirmPasswordController,
                    'Yeni Şifre Tekrar*',
                    obscureText: true,
                  ),
                  SizedBox(height: 20),

                  // GÜNCELLE Butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updatePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'GÜNCELLE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppTheme.primaryBlue, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
