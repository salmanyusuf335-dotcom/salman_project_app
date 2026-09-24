import 'package:flutter/material.dart';
import 'package:salman_project_app/day_19/models/product_model.dart';
import 'package:salman_project_app/day_19/services/product_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Tugas14App());
}

class Tugas14App extends StatelessWidget {
  const Tugas14App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 14 Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductService productService = ProductService();

  late Future<List<Product>> futureProducts;

  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  @override
  void initState() {
    super.initState();

    futureProducts = productService.fetchData();

    searchController.addListener(() {
      setState(() {
        searchText = searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> refreshProducts() async {
    setState(() {
      futureProducts = productService.fetchData();
    });

    await futureProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DummyJSON Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),

            child: TextField(
              controller: searchController,

              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: const Icon(Icons.search),

                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Product>>(
              future: futureProducts,

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const Icon(Icons.wifi_off_rounded, size: 70),

                          const SizedBox(height: 16),

                          const Text(
                            'Gagal Memuat Data',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            '${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 20),

                          ElevatedButton.icon(
                            onPressed: refreshProducts,

                            icon: const Icon(Icons.refresh),

                            label: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Data produk tidak tersedia.'),
                  );
                }

                final products = snapshot.data!;

                final filteredProducts = products.where((product) {
                  return product.title.toLowerCase().contains(searchText);
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      'Produk tidak ditemukan.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: refreshProducts,

                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),

                    itemCount: filteredProducts.length,

                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return ProductCard(product: product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductDetailPage(product: product);
              },
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: Image.network(
                  product.thumbnail,

                  width: 110,
                  height: 110,

                  fit: BoxFit.cover,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const SizedBox(
                      width: 110,
                      height: 110,

                      child: Center(child: CircularProgressIndicator()),
                    );
                  },

                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 110,
                      height: 110,

                      color: Colors.grey.shade300,

                      child: const Icon(Icons.image_not_supported, size: 40),
                    );
                  },
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      product.title,

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      product.category,

                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '\$${product.price.toStringAsFixed(2)}',

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(Icons.star, size: 18),

                        const SizedBox(width: 4),

                        Text(product.rating.toStringAsFixed(1)),

                        const SizedBox(width: 12),

                        Text(
                          'Stok: ${product.stock}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),

              child: Image.network(
                product.thumbnail,

                width: double.infinity,
                height: 280,

                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 280,

                    color: Colors.grey.shade300,

                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 60),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.title,

              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Chip(label: Text(product.category)),

            const SizedBox(height: 15),

            Text(
              '\$${product.price.toStringAsFixed(2)}',

              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.star),

                const SizedBox(width: 5),

                Text(product.rating.toStringAsFixed(1)),

                const SizedBox(width: 20),

                const Icon(Icons.inventory_2_outlined),

                const SizedBox(width: 5),

                Text('Stok ${product.stock}'),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Deskripsi Produk',

              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              product.description,

              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
