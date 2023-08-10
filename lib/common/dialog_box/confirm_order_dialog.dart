import 'package:ecommerce_project/common/button/custom_rounded_buttom.dart';
import 'package:flutter/material.dart';

class OrderConfirmDialog extends StatelessWidget {
  const OrderConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Order Confirmed Successfully",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: Image.asset(
        "assets/images/splash.jpg",
        height: 200,
        width: 200,
      ),
      actions: [
        CustomRoundedButton(
          title: "DONE",
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        )
      ],
    );
  }
}
