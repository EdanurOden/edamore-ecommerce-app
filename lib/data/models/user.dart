class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? profileImage;
  final String? tcNo;
  final String? postalCode;
  final String? city;
  final String? district;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.profileImage,
    this.tcNo,
    this.postalCode,
    this.city,
    this.district,
  });

  // kullanıcı çıkış yapana kadar güncel
  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? profileImage,
    String? tcNo,
    String? postalCode,
    String? city,
    String? district,
  }) {
    return User(
      id: id, // ID sabit kalır
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profileImage: profileImage ?? this.profileImage,
      tcNo: tcNo ?? this.tcNo,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }
}

// MOCK USER
final User mockUser = User(
  id: '1',
  name: 'Edanur Öden',
  email: 'test@test.com',
  phone: '+90 545 625 77 77',
  address: 'Atatürk Cad. No:123, Dinar, Afyonkarahisar',
  profileImage: null,
  tcNo: null,
  postalCode: null,
  city: null,
  district: null,
);
