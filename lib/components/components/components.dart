import 'package:flutter/material.dart';
import 'package:shopin/style/fonts.dart';



void navigateTo(context, widget) {
   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
void navigateToAndRemove(context, Widget widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);

}

class DiscountContainer extends StatelessWidget {
  final size;
  final product;
  final bool productScreen;
  DiscountContainer(this.size, this.product, this.productScreen);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4.1),
      padding: productScreen? EdgeInsets.symmetric(horizontal: 6, vertical: 4): EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: productScreen
            ? BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )
            : BorderRadius.only(
                bottomRight: Radius.circular(10),
              ),
      ),
      child: Text(
        'Discount ${product.toString()}%',
        style: tajawal.copyWith(
            fontSize: size.width / 32,
            color: Colors.white,
            fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }
}
