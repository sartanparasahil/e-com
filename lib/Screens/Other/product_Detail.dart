import 'package:flutter/material.dart';

import '../../Model/product_Fetch_Model.dart';
import 'order_Place_Screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final FetchProduct Products;
  ProductDetailScreen({
    super.key,
    required this.Products
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            height: 730,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 400,
                        width: 300,
                        child: Image.network(
                            widget.Products.imageName
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            widget.Products.productModel,
                            style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Rating: ${widget.Products.productRating}",
                            style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                          Icon(Icons.star,color: Colors.amber,size: 16,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.Products.productName,
                        style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 20),
                      child: Text(
                        "Discretion:",
                        style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 6),
                      child: Text(
                        widget.Products.productDescription,
                        style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 20),
                      child: Text(
                        "Color: ${widget.Products.productColor} ",
                        style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Warranty: ${widget.Products.productWarranty}",
                        style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Category: ${widget.Products.productCategory}",
                        style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                      "\$ ${widget.Products.productPrice}",
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(200, 45)
                    ),
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPlaceScreen(),));
                      },
                      label: Text(
                          "Buy Now",
                        style: TextStyle(color: Colors.black),
                      ),
                    icon: Icon(
                        Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
