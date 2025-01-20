import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../API/API_Connection.dart';
import '../../Model/product_Fetch_Model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<FetchProduct> productList = []; // Complete product list
  List<FetchProduct> searchResults = []; // Filtered products for search
  bool isLoading = true;

  // Fetch all products
  fetchProductDetailForSearch() async {
    try {
      var response = await http.post(
        Uri.parse(APIConnection.fetchProductAPI),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody["success"]) {
          List resBodyData = responseBody["data"];
          for (var item in resBodyData) {
            productList.add(
              FetchProduct(
                product_id: item["product_id"],
                productName: item["product_name"],
                productDescription: item["product_description"],
                productPrice: item["product_price"],
                productModel: item["product_model"],
                productRating: item["product_rating"],
                productStock: item["product_stock"],
                productColor: item["product_color"],
                productWarranty: item["product_warranty"],
                productCategory: item["product_category"],
                imageName: "${APIConnection.hostConnectImage}/${item["image_name"]}",
              ),
            );
          }
          // Initially, show all products
          setState(() {
            searchResults = List.from(productList);
            isLoading = false;
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
    fetchProductDetailForSearch();
  }

  // Filter products based on the search query
  void filterSearchResults(String query) {
    List<FetchProduct> results = [];
    if (query.isNotEmpty) {
      results = productList
          .where((product) => product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      results = List.from(productList); // Show all products if search is cleared
    }
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //     elevation: 0, // Removes shadow effect
    //     centerTitle: true,
    //     title: Text(
    //       "Search Products",
    //       style: TextStyle(
    //         color: Theme.of(context).highlightColor,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //   body: isLoading
    //       ? Center(
    //     child: CircularProgressIndicator(),
    //   )
    //       : SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: TextField(
    //             onChanged: (value) => filterSearchResults(value),
    //             decoration: InputDecoration(
    //               labelText: "Search",
    //               hintText: "Search products",
    //               prefixIcon: const Icon(Icons.search),
    //               border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //             ),
    //           ),
    //         ),
    //         ListView.builder(
    //           shrinkWrap: true,
    //           physics: NeverScrollableScrollPhysics(), // Prevent internal scrolling
    //           itemCount: searchResults.length,
    //           itemBuilder: (context, index) {
    //             var product = searchResults[index];
    //             return ListTile(
    //               leading: Image.network(
    //                 product.imageName,
    //                 width: 50,
    //                 height: 50,
    //                 fit: BoxFit.cover,
    //               ),
    //               title: Text(product.productName),
    //               subtitle: Text("\$${product.productPrice}"),
    //               trailing: IconButton(
    //                 icon: const Icon(Icons.add_shopping_cart),
    //                 onPressed: () {
    //                   Fluttertoast.showToast(
    //                       msg: "${product.productName} added to cart!");
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Search Product",
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            child: TextField(
              onChanged: (value) => filterSearchResults(value),
              style: TextStyle(
                color: Theme.of(context).disabledColor,
              ),
              cursorColor: Theme.of(context).disabledColor,
              decoration: InputDecoration(
                  labelText: "Search",
                  labelStyle: TextStyle(
                    color: Theme.of(context).disabledColor
                  ),
                  hintText: "Search products",
                hintStyle: TextStyle(
                  color: Theme.of(context).disabledColor
                ),
                prefixIcon: Icon(Icons.search,color: Theme.of(context).highlightColor,),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).highlightColor),
                  borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).highlightColor),
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                searchResults[index].imageName
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10,left: 10),
                                child: SizedBox(
                                  width: 180,
                                  child: Text(
                                    searchResults[index].productName,
                                    style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 10),
                                child: SizedBox(
                                  width: 180,
                                  child: Text(
                                    searchResults[index].productModel,
                                    style: TextStyle(
                                        color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5,left: 15),
                                child: SizedBox(
                                  width: 180,
                                  child: Row(
                                    children: [
                                      Text(
                                          searchResults[index].productRating,
                                        style: TextStyle(
                                          color: Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(Icons.star,size: 16,color: Colors.amber,)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
            ),
          )
        ],
      ),
    );
  }
}
