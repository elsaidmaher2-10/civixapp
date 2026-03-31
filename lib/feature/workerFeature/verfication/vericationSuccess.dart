import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationCompleteScreen extends StatelessWidget {
  const VerificationCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSuccessHero(),
                  const SizedBox(height: 48),
                  _buildSummaryGrid(),
                  const SizedBox(height: 16),
                  _buildStatusDetails(),
                  const SizedBox(height: 40),
                  _buildTransactionalIllustration(),
                  const SizedBox(height: 40),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- App Bar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManger.background.withOpacity(0.9),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: ColorManger.surfaceVariant, height: 1.0),
      ),
      title: Row(
        children: [
          const Icon(Icons.security, color: ColorManger.primary),
          const SizedBox(width: 12),
          Text(
            'Global Gate',
            style: GoogleFonts.cairo(
              color: ColorManger.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: ColorManger.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 18,
              color: ColorManger.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessHero() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManger.success.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: ColorManger.success.withOpacity(0.3),
                    blurRadius: 40,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: ColorManger.success,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 56,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Verification Complete',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: ColorManger.onSurface,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(
          width: 280,
          child: Text(
            'Your digital credentials have been successfully authenticated.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: ColorManger.secondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            label: 'CONFIRMED ZONE',
            value: 'Zone Alpha',
            icon: Icons.location_on,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoCard(
            label: 'DEPARTMENT',
            value: 'Engineering',
            icon: Icons.domain,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManger.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManger.surfaceVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: ColorManger.secondary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, color: ColorManger.primary, size: 20),
              const SizedBox(width: 8),
              // Wrap the Text in an Expanded widget so it doesn't overflow!
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.onSurface,
                  ),
                  // Optional: adds an ellipsis (...) if the text is still too long
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDetails() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManger.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManger.surfaceVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.badge,
              color: ColorManger.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digital ID Issued',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Expires Oct 2025',
                  style: TextStyle(fontSize: 12, color: ColorManger.secondary),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: ColorManger.secondary.withOpacity(0.4),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionalIllustration() {
    return Container(
      height: 128,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManger.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ColorManger.surfaceVariant),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManger.primary.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Bottom right circle accent
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorManger.primary.withOpacity(0.05),
                  width: 20,
                ),
              ),
            ),
          ),
          // Top left pill accents
          Positioned(
            top: 16,
            left: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ColorManger.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 96,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ColorManger.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          // Center Icon
          const Center(
            child: Icon(
              Icons.verified,
              size: 72,
              color: Color(0x1AFF7A00), // 10% opacity primary
            ),
          ),
        ],
      ),
    );
  }

  // --- Buttons ---
  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManger.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: ColorManger.primary.withOpacity(0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue to App',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: ColorManger.onSurface,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'View Digital Badge',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
