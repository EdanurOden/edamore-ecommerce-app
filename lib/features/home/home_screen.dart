import '../../data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/product_provider.dart';
import '../../data/providers/cart_provider.dart';
import '../../core/widgets/product_card.dart';
import 'widgets/search_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          SearchBarWidget(),
          SizedBox(height: 8),
          _buildResultInfo(),
          SizedBox(height: 8),
          Expanded(child: _buildProductGrid()),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        'EDAMORE',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        // Profil İkonu
        Consumer<AuthProvider>(
          builder: (context, auth, child) {
            return IconButton(
              icon: Icon(
                auth.isLoggedIn ? Icons.person : Icons.person_outline,
                color: Colors.black,
              ),
              onPressed: () async {
                if (auth.isLoggedIn) {
                  Navigator.pushNamed(context, '/profile');
                } else {
                  final result = await Navigator.pushNamed(context, '/login');
                  if (result == true && context.mounted) {
                    Navigator.pushNamed(context, '/profile');
                  }
                }
              },
            );
          },
        ),

        Consumer<CartProvider>(
          builder: (context, cart, child) {
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
                  onPressed: () => Navigator.pushNamed(context, '/cart'),
                ),
                if (cart.cartCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${cart.cartCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF6C8F9E)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'KATEGORİLER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          _buildCategoryTile(context, ' Kolye', 'Kolye'),
          _buildCategoryTile(context, ' Bileklik', 'Bileklik'),
          _buildCategoryTile(context, ' Çanta', 'Çanta'),
          _buildCategoryTile(context, ' Lego', 'Lego'),
          _buildCategoryTile(context, ' Figürler', 'Figürler'),
          _buildCategoryTile(context, ' Charm', 'charm'),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context,
    String title,
    String category,
  ) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.pop(context);
        final productProvider = Provider.of<ProductProvider>(
          context,
          listen: false,
        );
        productProvider.selectSingleCategory(category);
      },
    );
  }

  Widget _buildResultInfo() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Geri butonu (kategorileme aktifse göster)
              if (provider.filterOptions.hasActiveFilters) ...[
                GestureDetector(
                  onTap: () => provider.clearFilters(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF6C8F9E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'GERİ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
              ],
              // Ürün sayısı
              Text(
                '${provider.productCount} ürün bulundu',
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductGrid() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  'Ürün bulunamadı',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () => provider.clearFilters(),
                  child: Text(
                    'Filtreleri Temizle',
                    style: TextStyle(color: Color(0xFF6C8F9E)),
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          key: PageStorageKey('product_grid'),
          padding: EdgeInsets.all(16),
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            final product = provider.products[index];
            return ProductCard(
              key: ValueKey('product_${product.id}_$index'),
              product: product,
            );
          },
        );
      },
    );
  }
}
