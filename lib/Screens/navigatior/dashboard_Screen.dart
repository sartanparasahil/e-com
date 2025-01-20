import 'dart:convert';
import 'package:e_com/API/API_Connection.dart';
import 'package:e_com/Model/product_Fetch_Model.dart';
import 'package:e_com/Screens/Other/product_Detail.dart';
import 'package:e_com/Screens/navigatior/cart_Screen.dart';
import 'package:e_com/Screens/navigatior/favorite_Screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({super.key});

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  List<FetchProduct> ProductDetail = [];
  List<bool> isSelectedList = [];
  List<bool> isInCartList = [];
  bool isLoading = true;
  List<FetchProduct> favoriteProducts = []; // List to hold favorite products
  List<FetchProduct> cartProducts = []; // hold to cart

  // Function to fetch product data
  fetchProductDetail() async {
    try {
      var response = await http.post(
        Uri.parse(APIConnection.fetchProductAPI),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody["success"]) {
          // Clear all lists before repopulating
          ProductDetail.clear();
          isSelectedList.clear();
          isInCartList.clear();

          List resBodyData = responseBody["data"];
          for (int i = 0; i < resBodyData.length; i++) {
            ProductDetail.add(
              FetchProduct(
                product_id: resBodyData[i]["product_id"],
                productName: resBodyData[i]["product_name"],
                productDescription: resBodyData[i]["product_description"],
                productPrice: resBodyData[i]["product_price"],
                productModel: resBodyData[i]["product_model"],
                productRating: resBodyData[i]["product_rating"],
                productStock: resBodyData[i]["product_stock"],
                productColor: resBodyData[i]["product_color"],
                productWarranty: resBodyData[i]["product_warranty"],
                productCategory: resBodyData[i]["product_category"],
                imageName:
                    "${APIConnection.hostConnectImage}/${resBodyData[i]["image_name"]}",
              ),
            );
            isSelectedList.add(false); // Initially set all items as not liked
            isInCartList.add(false);
          }
          setState(() {
            isLoading = false; // Data loaded, stop showing loading state
          });
        } else {
          Fluttertoast.showToast(msg: "Data not fetched");
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProductDetail(); // Fetch data on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tech-Nest",
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen(
                favoriteProducts: favoriteProducts,
              ),
              )
              );
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor),
                    child: Center(
                      child: Icon(
                        Icons.favorite_border,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 23,
                    top: 2,
                    child: Container(
                      // height: 17,
                      // width: 17,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          favoriteProducts.length.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).highlightColor),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cartProducts: cartProducts,),));
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 23,
                    top: 2,
                    child: Container(
                      // height: 17,
                      // width: 17,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          cartProducts.length.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).highlightColor),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).highlightColor,
              ),
            ) // Show loading indicator while data is being fetched
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Text(
                      "${ProductDetail.length} Products",
                      style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 620,
                    width: MediaQuery.of(context).size.width.toDouble(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GridView.builder(
                        itemCount: ProductDetail.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 240,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          // Check if both lists have the same length
                          if (index >= ProductDetail.length ||
                              index >= isSelectedList.length) {
                            return Container(); // Return empty container if there is an index out of bounds
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(Products: ProductDetail[index],)));
                            },
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 150,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "\$${ProductDetail[index].productPrice}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ProductDetail[index].productName,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).highlightColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "Model:${ProductDetail[index].productModel}",
                                          style: TextStyle(
                                              color: Theme.of(context).hintColor,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 140,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 17,
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                        ProductDetail[index].imageName),
                                  ),
                                ),
                                Positioned(
                                    top: 10,
                                    left: 115,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isSelectedList[index] = !isSelectedList[
                                                  index]; // Toggle selection for the clicked product
                                              if (isSelectedList[index]) {
                                                favoriteProducts
                                                    .add(ProductDetail[index]);
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Item added to favorites");
                                              } else {
                                                favoriteProducts
                                                    .remove(ProductDetail[index]);
                                              }
                                            }
                                            );
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius: const BorderRadius.only(
                                                    topRight: Radius.circular(14),
                                                    topLeft:
                                                        Radius.circular(14)
                                                )
                                            ),
                                            child: Center(
                                              child: isSelectedList[index]
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: Theme.of(context)
                                                          .highlightColor,
                                                    )
                                                  : Icon(
                                                      Icons.favorite_border,
                                                      color: Theme.of(context)
                                                          .highlightColor,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                Positioned(
                                    top: 45,
                                    left: 115,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isInCartList[index] =
                                                  !isInCartList[index];
                                              if (isInCartList[index]) {
                                                cartProducts
                                                    .add(ProductDetail[index]);
                                                Fluttertoast.showToast(
                                                    msg: "Item added to cart");
                                              } else {
                                                cartProducts
                                                    .remove(ProductDetail[index]);
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Item removed from cart");
                                              }
                                            }
                                            );
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius: const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(14),
                                                    bottomLeft:
                                                        Radius.circular(14))),
                                            child: Center(
                                              child: isInCartList[index]
                                                  ? Icon(
                                                      Icons.shopping_cart,
                                                      color: Theme.of(context)
                                                          .highlightColor,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      color: Theme.of(context)
                                                          .highlightColor,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
