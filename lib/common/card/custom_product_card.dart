import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  // final Product product;
  final String image;
  final String name;
  final String brandName;
  final String price;
  void Function()? onPressed;

   CustomProductCard(
      {super.key,
      required this.image,
      required this.name,
      required this.brandName,
      required this.price,
      required this.onPressed, 
     // required this.product,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 5,
        shadowColor: Colors.white,
        color: Colors.grey.shade400,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          //margin: const EdgeInsets.all(10.0),,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                brandName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
