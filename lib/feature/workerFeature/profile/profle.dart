import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  // --- Shared Colors & Constants ---
  static Color background = Color(0xFFF6F6F6);
  static Color surfaceLowest = Color(0xFFFFFFFF);
  static Color surfaceContainer = Color(0xFFE7E8E8);
  static Color surfaceContainerLow = Color(0xFFF0F1F1);
  static Color surfaceContainerHighest = Color(0xFFDBDDDD);
  static Color primary = Color(0xFF954400);
  static Color primaryContainer = Color(0xFFFF7B04);
  static Color onSurface = Color(0xFF2D2F2F);
  static Color onSurfaceVariant = Color(0xFF5A5C5C);
  static Color outlineVariant = Color(0xFFACADAD);
  static Color error = Color(0xFFB02500);
  static Color success = Color(0xFF4CAF50);

  static LinearGradient kineticGradient = LinearGradient(
    colors: [primary, primaryContainer],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ==========================================
      // MAIN CONTENT BODY (NO APP BAR)
      // ==========================================
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. PROFILE HEADER SECTION ---
            Container(
              width: double.infinity,
              color: surfaceLowest,
              // Increased top padding slightly to account for the missing app bar if needed
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 64,
                bottom: 40,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryContainer.withOpacity(0.2),
                            width: 4,
                          ),
                          color: surfaceContainer,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: success,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                            weight: 800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Alex Rivera',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: primaryContainer, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          color: primary,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(124 reviews)',
                        style: GoogleFonts.cairo(
                          color: onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- 2. KINETIC STATS HORIZONTAL SCROLL ---
            SizedBox(height: 32),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 24),
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  // Completed Tasks
                  Container(
                    width: 176,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: surfaceLowest,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: onSurface.withOpacity(0.04),
                          blurRadius: 32,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.assignment_turned_in,
                          color: primaryContainer,
                          size: 32,
                        ),
                        SizedBox(height: 12),
                        Text(
                          '124',
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: onSurface,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'TASKS COMPLETED',
                          style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: onSurfaceVariant,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Hours Worked
                  Container(
                    width: 176,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: surfaceLowest,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: onSurface.withOpacity(0.04),
                          blurRadius: 32,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.timer, color: primaryContainer, size: 32),
                        SizedBox(height: 12),
                        Text(
                          '850',
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: onSurface,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'HOURS WORKED',
                          style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: onSurfaceVariant,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Distance
                  Container(
                    width: 176,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: surfaceLowest,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: onSurface.withOpacity(0.04),
                          blurRadius: 32,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.social_distance,
                          color: primaryContainer,
                          size: 32,
                        ),
                        SizedBox(height: 12),
                        Text(
                          '2,400',
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: onSurface,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'KM DISTANCE',
                          style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: onSurfaceVariant,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Total Earnings
                  Container(
                    width: 176,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: kineticGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.15),
                          blurRadius: 32,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.payments, color: Colors.black, size: 32),
                        SizedBox(height: 12),
                        Text(
                          '\$12,450',
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'TOTAL EARNINGS',
                          style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- 3. BENTO GRID INFORMATION ---
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 32),
              child: Column(
                children: [
                  // Personal Info Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: surfaceLowest,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: primary,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Personal Info',
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: onSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text(
                          'FULL NAME',
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Alex Rivera Rodriguez',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: onSurface,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'PHONE',
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+1 (555) 092-4412',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: onSurface,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'EMAIL',
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'alex.rivera@fieldops.io',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Vehicle & Fleet Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: surfaceLowest,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              color: primary,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Vehicle & Fleet',
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: onSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: surfaceContainerLow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ASSIGNED VEHICLE',
                                style: GoogleFonts.cairo(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: onSurfaceVariant,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Toyota Hilux',
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'KNJ-442 • Silver Metallic',
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 20,
                              color: onSurfaceVariant,
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Insurance Active until Oct 2024',
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                color: onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- 4. DOCUMENTS SECTION ---
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Compliance Documents',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: onSurface,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      // Doc 1
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: surfaceLowest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: surfaceContainerLow,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.badge_outlined,
                                  color: outlineVariant,
                                  size: 32,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'National ID Front',
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: success,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'APPROVED',
                                    style: GoogleFonts.cairo(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: success,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Doc 2
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: surfaceLowest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: surfaceContainerLow,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.badge_outlined,
                                  color: outlineVariant,
                                  size: 32,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'National ID Back',
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: success,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'APPROVED',
                                    style: GoogleFonts.cairo(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: success,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Doc 3
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: surfaceLowest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: surfaceContainerLow,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.face_outlined,
                                  color: outlineVariant,
                                  size: 32,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Personal Photo',
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: success,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'APPROVED',
                                    style: GoogleFonts.cairo(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: success,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- 5. ACTIONS LIST ---
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 48),
              child: Column(
                children: [
                  // Action 1
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: surfaceLowest,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryContainer.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              color: primaryContainer,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Edit Profile',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: onSurface,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: outlineVariant),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Action 2
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: surfaceLowest,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryContainer.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.lock_outline,
                              color: primaryContainer,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Change Password',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: onSurface,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: outlineVariant),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Action 3
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: surfaceLowest,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryContainer.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.cloud_upload_outlined,
                              color: primaryContainer,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Upload Documents',
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: onSurface,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: outlineVariant),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- 6. LOGOUT ACTION ---
            Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 48,
                bottom: 48,
              ),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 64),
                  side: BorderSide(color: error.withOpacity(0.2), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  foregroundColor: error,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Logout Account',
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
