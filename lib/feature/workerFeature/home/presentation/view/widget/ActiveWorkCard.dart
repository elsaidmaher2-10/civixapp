// import 'package:citifix/core/resource/colormanager.dart';
// import 'package:citifix/core/resource/screenutilsmaanger.dart';
// import 'package:citifix/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ActiveWorkCard extends StatelessWidget {
//   ActiveWorkCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: ColorManger.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(ScreenUtilsManager.s16),
//         boxShadow: [
//           BoxShadow(
//             color: ColorManger.onSurface.withOpacity(0.04),
//             blurRadius: ScreenUtilsManager.s32,
//             offset: Offset(ScreenUtilsManager.w0, ScreenUtilsManager.h12),
//           ),
//         ],
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(
//             'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?q=80&w=2070',
//             height: ScreenUtilsManager.h160,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(ScreenUtilsManager.s24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       S.of(context).fix_water_leak,
//                       style: GoogleFonts.cairo(
//                         fontSize: ScreenUtilsManager.s24,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: ScreenUtilsManager.w8,
//                         vertical: ScreenUtilsManager.h4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.shade50,
//                         borderRadius: BorderRadius.circular(
//                           ScreenUtilsManager.s4,
//                         ),
//                       ),
//                       child: Text(
//                         S.of(context).urgent,
//                         style: GoogleFonts.cairo(
//                           fontSize: ScreenUtilsManager.s11,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.orange.shade700,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: ScreenUtilsManager.h8),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.pin_drop,
//                       size: ScreenUtilsManager.s16,
//                       color: ColorManger.onSurfaceVariant,
//                     ),
//                     SizedBox(width: ScreenUtilsManager.w8),
//                     Expanded(
//                       child: Text(
//                         S.of(context).sample_address,
//                         style: GoogleFonts.cairo(
//                           fontSize: ScreenUtilsManager.s14,
//                           fontWeight: FontWeight.w500,
//                           color: ColorManger.onSurfaceVariant,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: ScreenUtilsManager.h16),
//                 Text(
//                   S.of(context).sample_description,
//                   style: GoogleFonts.cairo(
//                     color: ColorManger.onSurfaceVariant,
//                     fontSize: ScreenUtilsManager.s14,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: ScreenUtilsManager.h24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF954400), Color(0xFFFF7B04)],
//                       ),
//                       borderRadius: BorderRadius.circular(
//                         ScreenUtilsManager.s8,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: ColorManger.primaryColor.withOpacity(0.2),
//                           blurRadius: ScreenUtilsManager.s10,
//                           offset: Offset(
//                             ScreenUtilsManager.w0,
//                             ScreenUtilsManager.h4,
//                           ),
//                         ),
//                       ],
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         padding: EdgeInsets.symmetric(
//                           vertical: ScreenUtilsManager.h16,
//                         ),
//                       ),
//                       child: Text(
//                         S.of(context).view_details,
//                         style: GoogleFonts.cairo(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
