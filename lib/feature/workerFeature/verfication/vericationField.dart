import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationFailedScreen extends StatelessWidget {
  VerificationFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeroSection(),
                SizedBox(height: 48),
                _buildErrorSummaryBox(),
                SizedBox(height: 40),
                _buildUpdateDocumentsSection(),
                SizedBox(height: 48),
                _buildActionButtons(),
                SizedBox(height: 32),
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
      backgroundColor: ColorManger.background.withOpacity(0.9),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(color: ColorManger.surface, height: 1.0),
      ),
      title: Row(
        children: [
          Icon(Icons.security, color: ColorManger.primary),
          SizedBox(width: 8),
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
        TextButton(
          onPressed: () {},
          child: Text(
            'Verification',
            style: GoogleFonts.cairo(
              color: ColorManger.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Support',
            style: GoogleFonts.cairo(
              color: ColorManger.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 16),
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
            color: ColorManger.error.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.warning_rounded,
              color: ColorManger.error,
              size: 36,
            ),
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Verification Failed',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 44,
            fontWeight: FontWeight.w800,
            color: ColorManger.onSurface,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 400,
          child: Text(
            "We couldn't verify your identity based on the documents provided. Please review the details below.",
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 18,
              color: ColorManger.secondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorSummaryBox() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: ColorManger.error, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.report, color: ColorManger.error, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attention Required',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.onSurface,
                  ),
                ),
                SizedBox(height: 8),
                _buildErrorBulletItem('ID not clear'),
                SizedBox(height: 8),
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
          decoration: BoxDecoration(
            color: ColorManger.error,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorManger.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateDocumentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Update Documents',
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorManger.onSurface,
          ),
        ),
        SizedBox(height: 16),
        _buildReuploadCard(),
        SizedBox(height: 20),
        _buildEditableInputsCard(),
      ],
    );
  }

  // Document Reupload Card
  Widget _buildReuploadCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManger.outline),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Passport Photo Page',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      color: ColorManger.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: ColorManger.error,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Image Blurry',
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorManger.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.upload, size: 16),
                label: Text('Re-upload'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManger.primary,
                  foregroundColor: ColorManger.onPrimary,
                  elevation: 2,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManger.surfaceVariant,
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
                  Container(color: ColorManger.onSurface.withOpacity(0.4)),
                  Center(
                    child: Icon(
                      Icons.hide_source,
                      color: ColorManger.background,
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
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManger.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Information',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              color: ColorManger.onSurface,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          Divider(color: ColorManger.outline, height: 1),
          SizedBox(height: 20),

          _buildInputGroup(
            label: 'Document Number',
            initialValue: 'A1234567',
            hasError: true,
            errorMessage: "Number didn't match the image provided",
            iconColor: ColorManger.primary,
          ),
          SizedBox(height: 24),
          _buildInputGroup(
            label: 'Full Legal Name',
            hintText: 'Enter as shown on ID',
            hasError: false,
            iconColor: ColorManger.secondary,
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
          padding: EdgeInsets.only(left: 4.0, bottom: 6.0),
          child: Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorManger.secondary,
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: ColorManger.background,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: Icon(Icons.edit, size: 20, color: iconColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? ColorManger.error : ColorManger.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError
                    ? ColorManger.error
                    : ColorManger.primary.withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
          style: GoogleFonts.cairo(color: ColorManger.onSurface, fontSize: 16),
        ),
        if (hasError && errorMessage != null)
          Padding(
            padding: EdgeInsets.only(left: 4.0, top: 4.0),
            child: Text(
              errorMessage,
              style: GoogleFonts.cairo(
                color: ColorManger.error,
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
            backgroundColor: ColorManger.primary,
            foregroundColor: ColorManger.onPrimary,
            minimumSize: Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Resubmit Verification',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
        SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: ColorManger.secondary,
            minimumSize: Size(double.infinity, 56),
            side: BorderSide(color: ColorManger.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Contact Global Support',
            style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildHelpLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.cairo(fontSize: 14, color: ColorManger.secondary),
          children: [
            TextSpan(text: 'Need help? Visit our '),
            TextSpan(
              text: 'Verification Guide',
              style: GoogleFonts.cairo(
                color: ColorManger.primary,
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
