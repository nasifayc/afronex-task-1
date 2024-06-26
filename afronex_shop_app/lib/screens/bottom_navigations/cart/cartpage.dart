import 'package:afronex_shop_app/controller/product/cart_controller.dart';
import 'package:afronex_shop_app/screens/bottom_navigations/cart/cart_summary.dart';
import 'package:afronex_shop_app/screens/routes/checkout/checkout.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/cart_card.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(builder: (_) {
        final cartItems = _cartController.cartItems;
        if (cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "asset/animations/welcome.json",
                  width: Get.width * 0.7,
                ),
                const StyledText(
                    title: 'No Items Add',
                    color: Colors.grey,
                    fontSize: 16,
                    isBold: true),
              ],
            ),
          );
        } else {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(Get.width * 0.025),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: Get.height,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CartCard(item: cartItems[index]),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.05,
                maxChildSize: 0.9,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.all(Get.width * 0.025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CartSummary(),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () => Get.to(() => CheckOutPage()),
                              child: Button(
                                title: 'Check Out',
                                width: double.infinity,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}
