import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/services/notification_services.dart';
import 'package:ecommerce_project/features/auth/ui/pages/login_page.dart';
import 'package:ecommerce_project/features/dashboard/ui/pages/dashboard_page.dart';
import 'package:ecommerce_project/features/splash/cubit/startup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SplashWidgets extends StatefulWidget {
  const SplashWidgets({
    super.key,
  });

  @override
  State<SplashWidgets> createState() => _SplashWidgetsState();
}

class _SplashWidgetsState extends State<SplashWidgets> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<StartUpCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState<({bool isLoggedIn})>) {
            if (state.item.isLoggedIn) {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                      child: const DashboardPage(),
                      type: PageTransitionType.fade),
                  (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                      child: const LoginPage(), type: PageTransitionType.fade),
                  (route) => false);
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/splash.jpg",
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "ecommerce",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
