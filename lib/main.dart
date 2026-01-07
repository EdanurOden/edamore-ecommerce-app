import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/providers/review_provider.dart';

// Providers
import 'data/providers/auth_provider.dart';
import 'data/providers/product_provider.dart';
import 'data/providers/cart_provider.dart';
import 'data/providers/product_review_provider.dart';

// Theme
import 'core/theme/app_theme.dart';

// Auth
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';

// Home & Product
import 'features/home/home_screen.dart';
import 'features/product/product_detail_screen.dart';

// Cart
import 'features/cart/cart_screen.dart';
import 'features/cart/checkout_screen.dart';
import 'features/cart/order_success_screen.dart';

// Profile
import 'features/profile/profile_screen.dart';
import 'features/profile/edit_profile_screen.dart';
import 'features/profile/messages_screen.dart';
import 'features/profile/addresses_screen.dart';
import 'features/profile/orders_screen.dart';
import 'features/profile/empty_page_screen.dart';

// Favorites
import 'features/favorites/favorites_screen.dart';

void main() {
  runApp(const EdamoreApp());
}

class EdamoreApp extends StatelessWidget {
  const EdamoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductReviewProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ],
      child: MaterialApp(
        title: 'EDAMORE',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
        routes: {
          // EMPTY PAGES
          '/stock-alert-empty': (context) => const EmptyPageScreen(
            title: 'Stok Alarm Listem',
            message: 'Henüz stok alarmı eklenmiş ürününüz bulunmamaktadır.',
            icon: Icons.notifications_outlined,
          ),

          '/return-empty': (context) => const EmptyPageScreen(
            title: 'Değişim / İade Taleplerim',
            message:
                'Henüz oluşturulmuş bir değişim veya iade talebiniz bulunmamaktadır.',
            icon: Icons.sync_alt,
          ),

          '/gift-empty': (context) => const EmptyPageScreen(
            title: 'Hediye Çeklerim',
            message: 'Henüz tanımlı bir hediye çekiniz bulunmamaktadır.',
            icon: Icons.card_giftcard_outlined,
          ),

          // Auth
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),

          // Main
          '/home': (context) => const HomeScreen(),
          '/product-detail': (context) => const ProductDetailScreen(),

          // Cart
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/order-success': (context) => const OrderSuccessScreen(),

          // Profile
          '/profile': (context) => const ProfileScreen(),
          '/edit-profile': (context) => const EditProfileScreen(),
          '/messages': (context) => const MessagesScreen(),
          '/addresses': (context) => const AddressesScreen(),
          '/orders': (context) => const OrdersScreen(),

          // Favorites
          '/favorites': (context) => const FavoritesScreen(),
        },
      ),
    );
  }
}
