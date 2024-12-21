import 'package:flutter/material.dart';

import '../../Model/product_Fetch_Model.dart';

class favoritScreen extends StatefulWidget {
  final List<FetchProduct> favorites;

  const favoritScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  State<favoritScreen> createState() => _favoritScreenState();
}

class _favoritScreenState extends State<favoritScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: widget.favorites.isEmpty
          ? Center(child: Text("No favorites yet."))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: widget.favorites.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              final product = widget.favorites[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.imageName, height: 150),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("\$${product.productPrice}"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

