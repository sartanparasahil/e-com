import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Model/product_Fetch_Model.dart';

class FavoriteScreen extends StatefulWidget {
  final List<FetchProduct> favoriteProducts;
  const FavoriteScreen({
    super.key,
    required this.favoriteProducts
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).highlightColor),
        title: Text(
          "Tech-Nest Favorites",
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 630,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: widget.favoriteProducts.length,
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisExtent: 270
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.network(widget.favoriteProducts[index].imageName),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: SizedBox(
                                height: 20,
                                width: 150,
                                child: Text(
                                    widget.favoriteProducts[index].productName,
                                  style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                  width: 150,
                                  height: 20,
                                  child: Text(
                                      widget.favoriteProducts[index].productModel,
                                    style: TextStyle(
                                      color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 15),
                              child: Row(
                                children: [
                                  Text(
                                    widget.favoriteProducts[index].productRating,
                                    style: TextStyle(color: Theme.of(context).highlightColor,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const Icon(Icons.star,color: Colors.amber,size: 16,),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                      "\$${widget.favoriteProducts[index].productPrice}",
                                    style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).highlightColor,
                fixedSize: const Size(275,45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
                onPressed: () {
                Fluttertoast.showToast(msg: "Currently this feature not available");
                },
                label: Text(
                    "Add To Cart",
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              icon: Icon(
                  Icons.shopping_cart,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          )
        ],
      )
    );
  }
}
