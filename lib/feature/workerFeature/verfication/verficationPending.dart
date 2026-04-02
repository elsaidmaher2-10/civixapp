import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderReviewScreen extends StatelessWidget {
  UnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeaderSection(),
                  SizedBox(height: 48),
                  _buildSummarySection(),
                  SizedBox(height: 32),
                  _buildWhatsNextSection(),
                  SizedBox(height: 32),
                  _buildActionButtons(),
                  SizedBox(height: 48),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(color: Color(0xFFF5F5F5), height: 1.0),
      ),
      title: Row(
        children: [
          Icon(Icons.security, color: Color(0xFFFF7A00)),
          SizedBox(width: 8),
          Text(
            'Global Gate',
            style: GoogleFonts.cairo(
              color: Color(0xFF222222),
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        // Hidden on mobile in the HTML, but added for completeness if viewed on wider screens
        Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: Text(
            'Verification',
            style: GoogleFonts.cairo(
              color: Color(0xFFFF7A00),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Color(0xFFFF7A00).withOpacity(0.1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Icon(Icons.schedule, size: 48, color: Color(0xFFFF7A00)),
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Documents Under Review',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF222222),
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Your documents are being reviewed by our security team. This usually takes between 2-4 business hours.',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 16,
            color: Color(0xFF777777),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Submission Summary',
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFFF7A00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'IN PROGRESS',
                  style: GoogleFonts.cairo(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7A00),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          // Using a Wrap to simulate the grid behaviour (stacking on mobile, side-by-side on tablet)
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              SizedBox(
                width: 250, // Approx half width for tablet
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoField(
                      'ACCESS ZONE',
                      'Tier 1 • High Security Data Center',
                    ),
                    SizedBox(height: 16),
                    _buildInfoField(
                      'DEPARTMENT',
                      'Infrastructure & Operations',
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IDENTITY DOCUMENTS',
                      style: GoogleFonts.cairo(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF777777),
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildDocumentPlaceholder()),
                        SizedBox(width: 12),
                        Expanded(child: _buildDocumentPlaceholder()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF777777),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Text(
            value,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentPlaceholder() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://picsum.photos/seed/doc/200/150',
                fit: BoxFit.cover,
                color: Colors.grey,
                colorBlendMode: BlendMode.saturation,
              ),
            ),
            Center(
              child: Icon(
                Icons.visibility_off,
                color: Color(0x66777777), // secondary with 40% opacity
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhatsNextSection() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFF7A00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.info_outline, color: Color(0xFFFF7A00)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What's next?",
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Once verified, you will receive a notification via the Global Gate app and a secure token will be issued for your mobile device.',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: Color(0xFF777777),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Opacity(
          opacity: 0.5,
          child: ElevatedButton(
            onPressed: null, // Disabled state
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF7A00),
              disabledBackgroundColor: Color(0xFFFF7A00),
              minimumSize: Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Submit Additional Info',
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Opacity(
          opacity: 0.4,
          child: OutlinedButton(
            onPressed: null, // Disabled state
            style: OutlinedButton.styleFrom(
              disabledForegroundColor: Color(0xFF222222),
              minimumSize: Size(double.infinity, 56),
              side: BorderSide(color: Color(0xFFE0E0E0)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel Application',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Text(
      'SECURE SESSION • 08:42:11 REMAINING',
      style: GoogleFonts.cairo(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Color(0xFF777777),
        letterSpacing: 2.0,
      ),
    );
  }
}
