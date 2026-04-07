import 'package:citifix/feature/workerFeature/profile/action_list_tile.dart';
import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:citifix/feature/workerFeature/profile/document_tile.dart';
import 'package:citifix/feature/workerFeature/profile/info_card.dart';
import 'package:citifix/feature/workerFeature/profile/logout_button.dart';
import 'package:citifix/feature/workerFeature/profile/profile_header.dart';
import 'package:citifix/feature/workerFeature/profile/stat_card.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── 1. Header ─────────────────────────────────────────────
            const ProfileHeader(
              name: 'Alex Rivera',
              rating: 4.8,
              reviewCount: 124,
              avatarUrl:
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200',
            ),

            // ── 2. Stats ──────────────────────────────────────────────
            const SizedBox(height: 32),
            const StatsScrollRow(
              stats: [
                StatCardData(
                  icon: Icons.assignment_turned_in,
                  value: '124',
                  label: 'TASKS COMPLETED',
                ),
                StatCardData(
                  icon: Icons.timer,
                  value: '850',
                  label: 'HOURS WORKED',
                ),
                StatCardData(
                  icon: Icons.social_distance,
                  value: '2,400',
                  label: 'KM DISTANCE',
                ),
                StatCardData(
                  icon: Icons.payments,
                  value: '\$12,450',
                  label: 'TOTAL EARNINGS',
                  useGradient: true,
                ),
              ],
            ),

            // ── 3. Info Cards ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
              child: Column(
                children: [
                  // Personal Info
                  InfoCard(
                    icon: Icons.person_outline,
                    title: 'Personal Info',
                    children: const [
                      InfoField(
                        label: 'FULL NAME',
                        value: 'Alex Rivera Rodriguez',
                      ),
                      SizedBox(height: 24),
                      InfoField(label: 'PHONE', value: '+1 (555) 092-4412'),
                      SizedBox(height: 24),
                      InfoField(
                        label: 'EMAIL',
                        value: 'alex.rivera@fieldops.io',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Vehicle & Fleet
                  InfoCard(
                    icon: Icons.local_shipping_outlined,
                    title: 'Vehicle & Fleet',
                    children: [
                      const VehicleChip(
                        label: 'ASSIGNED VEHICLE',
                        vehicleName: 'Toyota Hilux',
                        details: 'KNJ-442 • Silver Metallic',
                      ),
                      const SizedBox(height: 24),
                      const IconTextRow(
                        icon: Icons.verified_user_outlined,
                        text: 'Insurance Active until Oct 2024',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── 4. Documents ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Compliance Documents',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.onSurface,
                        ),
                  ),
                  const SizedBox(height: 24),
                  const DocumentsRow(
                    documents: [
                      DocumentTileData(
                        title: 'National ID Front',
                        icon: Icons.badge_outlined,
                        status: DocumentStatus.approved,
                      ),
                      DocumentTileData(
                        title: 'National ID Back',
                        icon: Icons.badge_outlined,
                        status: DocumentStatus.approved,
                      ),
                      DocumentTileData(
                        title: 'Personal Photo',
                        icon: Icons.face_outlined,
                        status: DocumentStatus.approved,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── 5. Actions ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 48),
              child: ActionList(
                actions: [
                  ActionListTileData(
                    icon: Icons.edit_outlined,
                    label: 'Edit Profile',
                    onTap: () {},
                  ),
                  ActionListTileData(
                    icon: Icons.lock_outline,
                    label: 'Change Password',
                    onTap: () {},
                  ),
                  ActionListTileData(
                    icon: Icons.cloud_upload_outlined,
                    label: 'Upload Documents',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // ── 6. Logout ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 48,
                bottom: 48,
              ),
              child: LogoutButton(onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
