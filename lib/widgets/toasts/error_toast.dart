// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:usainua/resources/app_fonts.dart';

// class ErrorToast {
//   static showErrorToast({
//     required String errorMessage,
//     Duration duration = const Duration(seconds: 3),
//     required FToast fToast,
//   }) {
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 24,
//         vertical: 18,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: const Color.fromARGB(255, 204, 60, 60),
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.error_outline_outlined,
//             color: Colors.white,
//           ),
//           const SizedBox(
//             width: 15,
//           ),
//           Text(
//             errorMessage,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: AppFonts.sizeXSmall,
//               fontWeight: AppFonts.bold,
//             ),
//           ),
//         ],
//       ),
//     );

//     if (errorMessage != '') {
//       fToast.showToast(
//         child: toast,
//         toastDuration: duration,
//       );
//     }
//   }
// }
