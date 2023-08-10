import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ecommerce_project/common/services/notification_services.dart';
import 'package:ecommerce_project/common/text_field/search_text_field.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/auth/ui/pages/login_page.dart';
import 'package:ecommerce_project/features/cart/ui/pages/cart_page.dart';
import 'package:ecommerce_project/features/home/ui/pages/home_page.dart';
import 'package:ecommerce_project/features/order/ui/pages/order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class DashboardWidgets extends StatefulWidget {
  // final String product;
  const DashboardWidgets({
    super.key,
  });

  @override
  State<DashboardWidgets> createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  int _selectedIndex = 0;
  final TextEditingController _textController = TextEditingController();
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final textTheme = theme.textTheme;

    final userRepo = context.read<UserRepository>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        centerTitle: true,
        title: SizedBox(
          height: AppBar().preferredSize.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: SearchtextField(
                    controller: _textController,
                    onSearchPressed: () {},
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.search),
              // ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserRepository>().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: const LoginPage(), type: PageTransitionType.fade),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
              onPressed: () {
                LocalNotificationService().generatedNotification(
                  title: "my first Notification",
                  description: "test description",
                  payLoad: "from button",
                );
              },
              icon: const Icon(Icons.notification_add))
        ],
        leadingWidth: 60,
        leading: userRepo.userModel != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: FadeInImage(
                  placeholder: const AssetImage(
                    "assets/images/facebook.png",
                  ),
                  image: NetworkImage(
                    userRepo.userModel!.profile,
                  ),
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ))
            : null,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        iconSize: 22,
        items: [
          BottomNavyBarItem(
            icon: const Icon(CupertinoIcons.home),
            title: Container(
              padding: const EdgeInsets.only(left: 8),
              child: const Text('Home'),
            ),
            activeColor: Colors.grey.shade400,
          ),
          BottomNavyBarItem(
            icon: const Icon(CupertinoIcons.shopping_cart),
            title: Container(
              padding: const EdgeInsets.only(left: 8),
              child: const Text('Cart'),
            ),
            activeColor: Colors.grey.shade400,
          ),
          BottomNavyBarItem(
            icon: const Icon(CupertinoIcons.cube),
            title: Container(
              padding: const EdgeInsets.only(left: 8),
              child: const Text('Orders'),
            ),
            activeColor: Colors.grey.shade400,
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: const [
          HomePage(
              // productId: product.id,
              ),
          CartPage(),
          OrderPage(),
        ],
      ),
    );
  }
}
