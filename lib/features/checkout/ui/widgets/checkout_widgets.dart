import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/dialog_box/confirm_order_dialog.dart';
import 'package:ecommerce_project/common/button/custom_rounded_buttom.dart';
import 'package:ecommerce_project/common/text_field/custom_text_form_field.dart';
import 'package:ecommerce_project/common/utils/snakbar_utils.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/checkout/cubit/create_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CheckoutWidgets extends StatefulWidget {
  const CheckoutWidgets({super.key});

  @override
  State<CheckoutWidgets> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutWidgets> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final userRepo = context.read<UserRepository>();
    if (userRepo.userModel != null) {
      _fullNameController.text = userRepo.userModel!.name;
      _phoneNumberController.text = userRepo.userModel!.phone;
      _addressController.text = userRepo.userModel!.address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Check Out"),
          centerTitle: true,
          backgroundColor: Colors.grey.shade400,
        ),
        body: BlocListener<CreateOrderCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
            if (state is CommonErrorState) {
              SnakbarUtils.showMessage(
                  context: context, message: state.message);
            } else if (state is CommonSuccessState) {
              showDialog(
                context: context,
                builder: (context) => const OrderConfirmDialog(),
              );
            }
          },
          child: Container(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: "Full Name",
                        // hintText: "Full Name",
                        controller: _fullNameController,
                      ),
                      CustomTextFormField(
                        label: "Phone Number",
                        controller: _phoneNumberController,
                        // hintText: "Phone Number",
                      ),
                      CustomTextFormField(
                        label: "City",
                        // hintText: "City",
                        controller: _cityController,
                      ),
                      CustomTextFormField(
                        label: "Address",
                        // hintText: "Address",
                        controller: _addressController,
                      ),
                      CustomRoundedButton(
                        title: "Confirm Order",
                        onPressed: () {
                          context.read<CreateOrderCubit>().create(
                                fullName: _fullNameController.text,
                                address: _addressController.text,
                                city: _cityController.text,
                                phone: _phoneNumberController.text,
                              );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
