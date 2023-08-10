// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecommerce_project/features/dashboard/ui/widgets/dashboard_widgets.dart';

class DashboardPage extends StatelessWidget {
 //final String product;
   const DashboardPage({
    Key? key,
   // required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DashboardWidgets(
     // product: product
    );
  }
}
