import 'package:e_com/Screens/Other/order_Place_Screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Model/product_Fetch_Model.dart';

class CartScreen extends StatefulWidget {
  final List<FetchProduct> cartProducts;
  CartScreen({super.key, required this.cartProducts});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> counters = [];

  @override
  void initState() {
    super.initState();
    counters = List<int>.filled(widget.cartProducts.length, 1); // Initialize counters
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0.0;
    for (int i = 0; i < widget.cartProducts.length; i++) {
      totalAmount += double.parse(widget.cartProducts[i].productPrice) * counters[i];
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).highlightColor,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "My Cart",
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 90,
                            width: 90,
                            child: Image.network(
                              widget.cartProducts[index].imageName,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.cartProducts[index].productName.length > 16
                                    ? '${widget.cartProducts[index].productName.substring(0, 16)}...'
                                    : widget.cartProducts[index].productName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).highlightColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "\$${(double.parse(widget.cartProducts[index].productPrice) * counters[index]).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counters[index] > 1) {
                                      counters[index]--;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: counters[index] > 1 ? Theme.of(context).highlightColor:Theme.of(context).cardColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                counters[index].toString(),
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counters[index] < 10) {
                                      counters[index]++;
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Maximum 10 orders allowed!");
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                      "Total",
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "\$${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).highlightColor,
                fixedSize: const Size(275, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
                onPressed: () {
                  setState(() {
                    widget.cartProducts.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OrderPlaceScreen(),));
                  });
                }, 
                label: Text(
                  "Check Out",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor
                  ),
                ),
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
            )
          ],
        ),
      ),
    );
  }
}
