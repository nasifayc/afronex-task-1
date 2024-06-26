import 'package:afronex_shop_app/models/cart/cart_model.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final collection = FirebaseFirestore.instance.collection('cart');
  final double shippingCost = 10;
  final double taxRate = 0.1;

  List<CartModel> cartItems = <CartModel>[].obs;

  RxDouble subTotalPrice = 0.0.obs;
  RxDouble totalPrice = 0.0.obs;

  Future<void> loadCartItems({required String userId}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await collection.doc(userId).get();

    final Map<String, dynamic>? data = snapshot.data();

    if (data != null && data.containsKey('items')) {
      final List<dynamic> itemsData = data['items'];
      try {
        final List<CartModel> fetchedCartItems = itemsData
            .map<CartModel>((json) => CartModel.fromSnapshot(json))
            .toList();
        cartItems.assignAll(fetchedCartItems);
        calculateTotalPrice();
        update();
      } catch (e) {
        showToast(message: "$e");
      }
    } else {
      cartItems.clear();
      update();
    }
  }

  Future<void> addItemsToCart(CartModel cartItem, String userId) async {
    cartItems.add(cartItem);
    await createCart(userId: userId);
    calculateTotalPrice();
    update();
  }

  Future<void> saveData({required String userId}) async {
    try {
      await collection.doc(userId).update({
        'items': cartItems.map((item) => item.toJson()).toList(),
      });
    } catch (e) {
      showToast(message: 'Saving Error: $e');
    }
  }

  Future<void> createCart({required String userId}) async {
    try {
      await collection.doc(userId).set({
        'items': cartItems.map((item) => item.toJson()).toList(),
      });
    } catch (e) {
      showToast(message: 'Creating data Error: $e');
    }
  }


  
  void calculateTotalPrice() {
    subTotalPrice.value = cartItems.fold(
        0.0,
        (previousValue, cartItem) =>
            previousValue + (cartItem.item.price! * cartItem.quantity));
    totalPrice.value =
        (subTotalPrice.value + (subTotalPrice.value * taxRate)) + shippingCost;
  }

  void increaseQuantity(CartModel item, String userId) {
    if (item.quantity < 10) {
      ++item.quantity;
      calculateTotalPrice();
      saveData(userId: userId);
      update();
    }
  }

  void decreaseQuantity(CartModel item, String userId) {
    if (item.quantity > 1) {
      --item.quantity;
      calculateTotalPrice();
      saveData(userId: userId);
      update();
    }
  }

  Future<void> deleteItem(
      {required String userId, required CartModel item}) async {
    cartItems.remove(item);
    await saveData(userId: userId);
    calculateTotalPrice();
    update();
  }
}
