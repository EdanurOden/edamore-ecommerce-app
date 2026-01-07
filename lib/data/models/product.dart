class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;
  final List<String> images;
  final bool inStock;

  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
    List<String>? images,
    this.inStock = true,

    this.rating = 4.5,
    this.reviewCount = 120,
  }) : images = images ?? [image];
}

final List<Product> mockProducts = [
  // LEGO
  Product(
    id: '1',
    name: 'Aslan Lego Figürü',
    price: 149.99,
    image: 'assets/products/aslan.jpeg',
    category: 'Lego',
    description:
        'Sevimli aslan karakterli lego figürü. Çocuklar için eğlenceli ve yaratıcı oyun deneyimi sunar.',
  ),
  Product(
    id: '2',
    name: 'Civciv Lego Figürü',
    price: 149.99,
    image: 'assets/products/civciv.jpeg',
    category: 'Lego',
    description:
        'Minik civciv lego karakteri. Renkli ve eğlenceli tasarımı ile dikkat çeker.',
  ),
  Product(
    id: '3',
    name: 'Domuz Lego Figürü',
    price: 149.99,
    image: 'assets/products/domuz.jpeg',
    category: 'Lego',
    description:
        'Şirin domuz lego figürü. Dayanıklı yapısı ve kaliteli malzemesi ile uzun ömürlü kullanım sağlar.',
  ),
  Product(
    id: '4',
    name: 'Kaplan Lego Figürü',
    price: 149.99,
    image: 'assets/products/kaplan.jpeg',
    category: 'Lego',
    description:
        'Cesur kaplan karakterli lego. Çocukların hayal gücünü geliştiren eğlenceli bir oyuncak.',
  ),
  Product(
    id: '5',
    name: 'Kedi Lego Figürü',
    price: 149.99,
    image: 'assets/products/kedi.jpeg',
    category: 'Lego',
    description:
        'Sevimli kedi lego figürü. Detaylı tasarımı ile koleksiyoncular için ideal.',
  ),
  Product(
    id: '6',
    name: 'Pembefil Lego Figürü',
    price: 149.99,
    image: 'assets/products/pembeFil.jpeg',
    category: 'Lego',
    description:
        'Eğlenceli pembe Fil karakteri. Canlı renkleri ve sevimli görünümü ile çocukların favorisi.',
  ),
  Product(
    id: '7',
    name: 'Penguen Lego Figürü',
    price: 149.99,
    image: 'assets/products/penguen.jpeg',
    category: 'Lego',
    description:
        'Şık penguen lego figürü. Zarif duruşu ve kaliteli işçiliği ile öne çıkar.',
  ),
  Product(
    id: '8',
    name: 'Tavşan Lego Figürü',
    price: 149.99,
    image: 'assets/products/tavsan.jpeg',
    category: 'Lego',
    description:
        'Sevimli tavşan lego karakteri. Yumuşak renkleri ve dostane tasarımı ile beğeni toplar.',
  ),
  Product(
    id: '9',
    name: 'Tilki Lego Figürü',
    price: 149.99,
    image: 'assets/products/tilki.jpeg',
    category: 'Lego',
    description:
        'Kurnaz tilki lego figürü. Zeki görünümü ve detaylı işçiliği ile dikkat çeker.',
  ),
  Product(
    id: '10',
    name: 'Timsah Lego Figürü',
    price: 149.99,
    image: 'assets/products/timsah.jpeg',
    category: 'Lego',
    description:
        'Güçlü timsah karakterli lego. Sağlam yapısı ve gerçekçi tasarımı ile macera severler için ideal.',
  ),

  // BİLEKLİK
  Product(
    id: '11',
    name: 'Zarif İnci Bileklik',
    price: 199.99,
    image: 'assets/products/bileklik1.jpeg',
    category: 'Bileklik',
    description:
        'Şık inci detaylı bileklik. Zarif tasarımı ile özel günlerde kullanım için ideal.',
  ),
  Product(
    id: '12',
    name: 'Doğal Taş Bileklik',
    price: 179.99,
    image: 'assets/products/bileklik2.jpeg',
    category: 'Bileklik',
    description:
        'Doğal taşlardan oluşan bileklik. Her bir taş özenle seçilmiş ve işlenmiştir.',
  ),
  Product(
    id: '13',
    name: 'Kristal Taşlı Bileklik',
    price: 229.99,
    image: 'assets/products/bileklik3.jpeg',
    category: 'Bileklik',
    description:
        'Işıltılı kristal taşlarla süslenmiş bileklik. Zarif ve göz alıcı tasarım.',
  ),
  Product(
    id: '14',
    name: 'Altın Kaplama Bileklik',
    price: 249.99,
    image: 'assets/products/bileklik4.jpeg',
    category: 'Bileklik',
    description:
        'Altın kaplama detaylı bileklik. Klasik ve zamansız tasarımı ile her stile uyum sağlar.',
  ),

  // KOLYE
  Product(
    id: '15',
    name: 'Minimal Zincir Kolye',
    price: 189.99,
    image: 'assets/products/kolye1.jpeg',
    category: 'Kolye',
    description:
        'Sade ve şık zincir kolye. Günlük kullanım için ideal minimalist tasarım.',
  ),
  Product(
    id: '16',
    name: 'Altın Zincir Kolye',
    price: 279.99,
    image: 'assets/products/kolye2.jpeg',
    category: 'Kolye',
    description:
        'Zarif altın rengi zincir kolye. İnce işçiliği ve parlak görünümü ile dikkat çeker.',
  ),
  Product(
    id: '17',
    name: 'Yeşil Taşlı Kolye',
    price: 299.99,
    image: 'assets/products/kolye3.jpeg',
    category: 'Kolye',
    description:
        'Yeşil doğal taş detaylı kolye. Benzersiz tasarımı ile özel günler için mükemmel seçim.',
  ),
  Product(
    id: '18',
    name: 'İnci Detaylı Kolye',
    price: 249.99,
    image: 'assets/products/kolye4.jpeg',
    category: 'Kolye',
    description: 'Zarif inci detaylı kolye. Klasik ve sofistike görünüm sunar.',
  ),
  Product(
    id: '19',
    name: 'Uzun Zincir Kolye',
    price: 219.99,
    image: 'assets/products/kolye5.jpg',
    category: 'Kolye',
    description:
        'Modern uzun zincir kolye. Şık ve göz alıcı tasarımı ile stil sahibi kadınlar için ideal.',
  ),
  Product(
    id: '20',
    name: 'Altın Kalp Kolye',
    price: 289.99,
    image: 'assets/products/kolye6.jpg',
    category: 'Kolye',
    description:
        'Kalp motifli altın kolye. Romantik ve zarif tasarımı ile hediye için mükemmel.',
  ),

  // ÇANTA
  Product(
    id: '21',
    name: 'Kahverengi Deri Çanta',
    price: 399.99,
    image: 'assets/products/canta1.jpeg',
    category: 'Çanta',
    description:
        'Klasik kahverengi deri çanta. Geniş iç hacmi ve şık tasarımı ile günlük kullanım için ideal.',
  ),
  Product(
    id: '22',
    name: 'Siyah Kapitone Çanta',
    price: 449.99,
    image: 'assets/products/canta2.jpeg',
    category: 'Çanta',
    description:
        'Zarif kapitone detaylı siyah çanta. Modern ve şık tasarımı ile her ortama uyum sağlar.',
  ),
  Product(
    id: '23',
    name: 'Yeşil Desenli Çanta',
    price: 429.99,
    image: 'assets/products/canta3.jpeg',
    category: 'Çanta',
    description:
        'Canlı yeşil desenli çanta. Farklı ve dikkat çekici tasarımı ile stil yaratır.',
  ),
  Product(
    id: '24',
    name: 'Bordo Deri Çanta',
    price: 419.99,
    image: 'assets/products/canta4.jpeg',
    category: 'Çanta',
    description:
        'Şık bordo renkli deri çanta. Zarif ve klasik görünümü ile öne çıkar.',
  ),
  Product(
    id: '25',
    name: 'Kahve Büyük Boy Çanta',
    price: 479.99,
    image: 'assets/products/canta5.jpeg',
    category: 'Çanta',
    description:
        'Büyük boy kahverengi çanta. Geniş iç hacmi ile pratik kullanım sağlar.',
  ),
  Product(
    id: '26',
    name: 'Haki Deri Çanta',
    price: 389.99,
    image: 'assets/products/canta6.jpeg',
    category: 'Çanta',
    description:
        'Modern haki renkli deri çanta. Günlük kullanım için rahat ve şık tasarım.',
  ),

  // CHARM
  Product(
    id: '27',
    name: 'Renkli Charm Seti',
    price: 89.99,
    image: 'assets/products/charm1.jpeg',
    category: 'charm',
    description:
        'Eğlenceli renkli charm seti. Çantalarınıza ve anahtarlıklarınıza şık bir dokunuş katar.',
  ),
  Product(
    id: '28',
    name: 'Çiçek Motifli Charm',
    price: 79.99,
    image: 'assets/products/charm2.jpeg',
    category: 'charm',
    description:
        'Zarif çiçek desenli charm. Sevimli ve dikkat çekici tasarımı ile öne çıkar.',
  ),
  Product(
    id: '29',
    name: 'Mini Figür Charm',
    price: 99.99,
    image: 'assets/products/charm3.jpeg',
    category: 'charm',
    description:
        'Minik figür charm aksesuarı. Canlı renkleri ve sevimli tasarımı ile dikkat çeker.',
  ),
  Product(
    id: '30',
    name: 'Kalp Charm Seti',
    price: 84.99,
    image: 'assets/products/charm4.jpeg',
    category: 'charm',
    description:
        'Kalp motifli charm seti. Romantik ve şirin tasarımı ile hediye için ideal.',
  ),
  Product(
    id: '31',
    name: 'Kristal Taşlı Charm',
    price: 94.99,
    image: 'assets/products/charm5.jpeg',
    category: 'charm',
    description:
        'Işıltılı kristal taşlı charm. Zarif ve göz alıcı detayları ile özel günler için mükemmel.',
  ),

  // FİGÜRLER
  Product(
    id: '32',
    name: 'BB Zilli Adam',
    price: 199.99,
    image: 'assets/products/figür1.jpeg',
    category: 'Figürler',
    description:
        'Özel pop figür koleksiyonu. Koleksiyoncular için ideal, detaylı işçilikli figür.',
  ),
  Product(
    id: '33',
    name: 'BB Çılgın WalterW',
    price: 199.99,
    image: 'assets/products/figür2.jpeg',
    category: 'Figürler',
    description:
        'Benzersiz pop figür serisi. Yüksek kaliteli malzeme ve özenli tasarımı ile öne çıkar.',
  ),
  Product(
    id: '34',
    name: 'BB baddie Jesse',
    price: 199.99,
    image: 'assets/products/figür3.jpeg',
    category: 'Figürler',
    description:
        'Koleksiyonluk pop figür. Orijinal ambalajında, koleksiyoncular için vazgeçilmez.',
  ),
  Product(
    id: '35',
    name: 'BB saaul goodman',
    price: 199.99,
    image: 'assets/products/figür4.jpeg',
    category: 'Figürler',
    description:
        'Özel seri pop figür. Detaylı boyama ve kaliteli yapısı ile dikkat çeker.',
  ),
  Product(
    id: '36',
    name: 'winx layka',
    price: 179.99,
    image: 'assets/products/figür5.jpeg',
    category: 'Figürler',
    description:
        'Nadir bulunan pop figür. Koleksiyonunuza değer katacak özel bir parça.',
  ),
  Product(
    id: '37',
    name: 'winx bluuume',
    price: 179.99,
    image: 'assets/products/figür6.jpeg',
    category: 'Figürler',
    description:
        'Sınırlı sayıda üretilen pop figür. Koleksiyoncular için özel ve değerli bir ürün.',
  ),
  Product(
    id: '38',
    name: 'winx stellaa',
    price: 179.99,
    image: 'assets/products/figür7.jpeg',
    category: 'Figürler',
    description:
        'Premium pop figür serisi. Mükemmel detayları ve kaliteli yapısı ile koleksiyonun yıldızı.',
  ),
];
