// import 'package:ecommerce_app/common/bloc/common_state.dart';
// import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
// import 'package:ecommerce_app/common/custom_theme.dart';
// import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
// import 'package:ecommerce_app/common/utils/snackbar_utils.dart';
// import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
// import 'package:ecommerce_app/features/checkout/cubit/checkout_cubit.dart';
// import 'package:ecommerce_app/features/checkout/ui/widgets/order_confirm_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:loading_overlay/loading_overlay.dart';

// class CheckoutWidgets extends StatefulWidget {
//   const CheckoutWidgets({super.key});

//   @override
//   State<CheckoutWidgets> createState() => _CheckoutWidgetsState();
// }

// class _CheckoutWidgetsState extends State<CheckoutWidgets> {
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _fullNameController = TextEditingController();
//   bool _isloading = false;

//   @override
//   void initState() {
//     super.initState();
//     final _userRepo = RepositoryProvider.of<UserRepository>(context).user;
//     if (_userRepo != null) {
//       _addressController.text = _userRepo.address;
//       _fullNameController.text = _userRepo.name;
//       _phoneNumberController.text = _userRepo.phone;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CheckoutCubit, CommonState>(
//       listener: (context, state) {
//         if (state is CommonLoadingState) {
//           setState(() {
//             _isloading = true;
//           });
//         } else {
//           setState(() {
//             _isloading = false;
//           });
//         }

//         if (state is CommonErrorState) {
//           SnackbarUtils.showSnackBar(context: context, message: state.message);
//         } else if (state is CommonSuccessState) {
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) {
//               return OrderConfirmDialog();
//             },
//           );
//         }
//       },
//       child: LoadingOverlay(
//         isLoading: _isloading,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: CustomTheme.primaryColor,
//             title: Text(
//               "Checkout",
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           body: Container(
//             child: SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 20),
//                     CustomTextField(
//                       label: "Full Name",
//                       hintText: "Full Name",
//                       controller: _fullNameController,
//                     ),
//                     CustomTextField(
//                       label: "Phone Number",
//                       controller: _phoneNumberController,
//                       hintText: "Phone Number",
//                     ),
//                     CustomTextField(
//                       label: "City",
//                       hintText: "City",
//                       controller: _cityController,
//                     ),
//                     CustomTextField(
//                       label: "Address",
//                       hintText: "Address",
//                       controller: _addressController,
//                     ),
//                     CustomRoundedButtom(
//                       title: "Confirm Order",
//                       onPressed: () {
//                         context.read<CheckoutCubit>().checkout(
//                               name: _fullNameController.text,
//                               address: _addressController.text,
//                               phone: _phoneNumberController.text,
//                               city: _cityController.text,
//                             );
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:ecommerce_project/features/home/model/product_model.dart';

// class Cart {
//   String id;
//   int quantity;
//   Product product;
//   Cart({
//     required this.id ,
//     required this.quantity,
//     required this.product,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'quantity': quantity,
//       'product': product.toMap(),
//     };
//   }

//   factory Cart.fromMap(Map<String, dynamic> map) {
//     return Cart(
//       id: map['id'] as String,
//       quantity: map['quantity'] as int,
//       product: Product.fromMap(map['product'] as Map<String,dynamic>),
//     );
//   }

  
// }
