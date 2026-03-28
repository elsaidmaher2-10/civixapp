import 'dart:ui';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/tasks/Slivers.dart';
import 'package:citifix/feature/workerFeature/verfication/verficationinit.dart'
    hide ColorManger;
import 'package:flutter/material.dart';

class WorkerCard extends StatelessWidget {
  const WorkerCard({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        shadowColor: ColorManger.onSurface.withOpacity(0.04),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                    child: Image.network(
                      'https://i.pravatar.cc/150?img=11',
                      width: ScreenUtilsManager.w64,
                      height: ScreenUtilsManager.h64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: ScreenUtilsManager.w16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alex Rivera',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManger.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'VERIFIED ✅',
                          style: TextStyle(
                            fontSize: ScreenUtilsManager.s10,
                            fontWeight: FontWeight.w700,
                            color: ColorManger.green,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Online & Ready',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorManger.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsetsGeometry.all(0),
                      height: ScreenUtilsManager.h44,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF954400), Color(0xFFFF7B04)],
                        ),
                        borderRadius: BorderRadius.circular(
                          ScreenUtilsManager.r8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManger.primaryColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GlobalGateVerificationPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),

                        child: Text(
                          'Verify Now',
                          style: TextStyle(
                            fontSize: ScreenUtilsManager.s16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
