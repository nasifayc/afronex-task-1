import 'package:afronex_shop_app/controller/product/cart_controller.dart';
import 'package:afronex_shop_app/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartSummary extends StatelessWidget {
  CartSummary({super.key});

  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartItems = _cartController.cartItems;
      return Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 246, 243, 243),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StyledText(
              title: 'Order Summary',
              isBold: true,
              fontSize: 18,
              color: Colors.black,
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const StyledText(
                            title: 'Items: ',
                            isBold: false,
                            fontSize: 18,
                            color: Colors.grey),
                        const Spacer(),
                        StyledText(
                          title: cartItems.length.toString(),
                          isBold: true,
                          fontSize: 18,
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const StyledText(
                            title: 'Shipping Cost: ',
                            isBold: false,
                            fontSize: 18,
                            color: Colors.grey),
                        const Spacer(),
                        StyledText(
                          title: '\$${_cartController.shippingCost}',
                          isBold: true,
                          fontSize: 18,
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const StyledText(
                            title: 'Vat: ',
                            isBold: false,
                            fontSize: 18,
                            color: Colors.grey),
                        const Spacer(),
                        StyledText(
                          title: '${_cartController.taxRate * 100}%',
                          isBold: true,
                          fontSize: 18,
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const StyledText(
                            title: 'Sub Total: ',
                            isBold: false,
                            fontSize: 18,
                            color: Colors.grey),
                        const Spacer(),
                        StyledText(
                          title: '\$${_cartController.subTotalPrice}',
                          isBold: true,
                          fontSize: 18,
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const StyledText(
                            title: 'Total: ',
                            isBold: false,
                            fontSize: 18,
                            color: Colors.grey),
                        const Spacer(),
                        StyledText(
                          title: '\$${_cartController.totalPrice}',
                          isBold: true,
                          fontSize: 18,
                          color: Colors.black,
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      );
    });
  }
}
