import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF7A00);
  static const onPrimary = Color(0xFFFFFFFF);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF5F5F5);
  static const onSurface = Color(0xFF222222);
  static const secondary = Color(0xFF777777);
  static const error = Color(0xFFFF3B30);
  static const success = Color(0xFF34C759);
  static const outline = Color(0xFFD1D1D1);
  static const surfaceVariant = Color(0xFFE0E0E0);
  static const Color primaryFixed = Color(0xFFFF7A00);
  static const Color surfaceLowest = Color(0xFFFFFFFF);
  static const Color onSurfaceVariant = Color(0xFF5A5C5C);
  static const Color surfaceContainerHighest = Color(0xFFDBDDDD);
  static const Color surfaceContainer = Color(0xFFE7E8E8);
  static const Color errorContainer = Color(0xFFF95630);
  static const Color onErrorContainer = Color(0xFF520C00);
  static const Color availableContainer = Color(0xFFF9BD26);
  static const Color onAvailableContainer = Color(0xFF543C00);
  static const Color inProgressContainer = Color(0xFFFF7B04);
  static const Color onInProgressContainer = Color(0xFF3D1800);
  static const LinearGradient kineticGradient = LinearGradient(
    colors: [primary, primaryFixed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class VerificationFailedScreen extends StatelessWidget {
  const VerificationFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeroSection(),
                const SizedBox(height: 48),
                _buildErrorSummaryBox(),
                const SizedBox(height: 40),
                _buildUpdateDocumentsSection(),
                const SizedBox(height: 48),
                _buildActionButtons(),
                const SizedBox(height: 32),
                _buildHelpLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background.withOpacity(0.9),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.surface, height: 1.0),
      ),
      title: const Row(
        children: [
          Icon(Icons.security, color: AppColors.primary),
          SizedBox(width: 8),
          Text(
            'Global Gate',
            style: TextStyle(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Verification',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Support',
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.warning_rounded,
              color: AppColors.error,
              size: 36,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Verification Failed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(
          width: 400,
          child: Text(
            "We couldn't verify your identity based on the documents provided. Please review the details below.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.secondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorSummaryBox() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: AppColors.error, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.report, color: AppColors.error, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Attention Required',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                _buildErrorBulletItem('ID not clear'),
                const SizedBox(height: 8),
                _buildErrorBulletItem('Missing data'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBulletItem(String text) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.error,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateDocumentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Update Documents',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        _buildReuploadCard(),
        const SizedBox(height: 20),
        _buildEditableInputsCard(),
      ],
    );
  }

  // Document Reupload Card
  Widget _buildReuploadCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Passport Photo Page',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Image Blurry',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload, size: 16),
                label: const Text('Re-upload'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.network(
                      'https://picsum.photos/seed/passport/400/225', // Placeholder
                      fit: BoxFit.cover,
                      color: Colors.grey, // Grayscale effect
                      colorBlendMode: BlendMode.saturation,
                    ),
                  ),
                  Container(color: AppColors.onSurface.withOpacity(0.4)),
                  const Center(
                    child: Icon(
                      Icons.hide_source,
                      color: AppColors.background,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInputsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.outline, height: 1),
          const SizedBox(height: 20),

          _buildInputGroup(
            label: 'Document Number',
            initialValue: 'A1234567',
            hasError: true,
            errorMessage: "Number didn't match the image provided",
            iconColor: AppColors.primary,
          ),
          const SizedBox(height: 24),
          _buildInputGroup(
            label: 'Full Legal Name',
            hintText: 'Enter as shown on ID',
            hasError: false,
            iconColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildInputGroup({
    required String label,
    String? initialValue,
    String? hintText,
    required bool hasError,
    String? errorMessage,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: Icon(Icons.edit, size: 20, color: iconColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError
                    ? AppColors.error
                    : AppColors.primary.withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
          style: const TextStyle(color: AppColors.onSurface, fontSize: 16),
        ),
        if (hasError && errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 4.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: AppColors.error,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Resubmit Verification',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 12),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.secondary,
            minimumSize: const Size(double.infinity, 56),
            side: const BorderSide(color: AppColors.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Contact Global Support',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildHelpLink() {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 14, color: AppColors.secondary),
          children: [
            TextSpan(text: 'Need help? Visit our '),
            TextSpan(
              text: 'Verification Guide',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Color(0x4DFF7A00),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
