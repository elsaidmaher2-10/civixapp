import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  int _selectedIndex = 3;

  static const Color primary = Color(0xFFFF7B00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Stack(
          children: [

            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        const SizedBox(width: 48),
                        Expanded(
                          child: Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),

                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 48,
                                backgroundImage: NetworkImage(
                                  'https://i.pravatar.cc/150?img=8',
                                ),
                              ),
                              const SizedBox(height: 16),

                              Text(
                                'Johnathan Doe',
                                style: GoogleFonts.outfit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.verified, color: Colors.green, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Verified Worker',
                                    style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              Email + Phone
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Email
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Icon(Icons.mail_outline, color: Color(0xFF94A3B8), size: 20),
                                          const SizedBox(height: 4),
                                          Text(
                                            'john.doe@workerportal.co',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.outfit(
                                              fontSize: 10,
                                              color: const Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Divider
                                    Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),

                                    Phone
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Icon(Icons.call_outlined, color: Color(0xFF94A3B8), size: 20),
                                          const SizedBox(height: 4),
                                          Text(
                                            '+1 (555) 123-4567',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.outfit(
                                              fontSize: 10,
                                              color: const Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        ── Work Scope ───────────────────────────────────
                        Text(
                          'WORK SCOPE',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF94A3B8),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Assigned Area
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, color: Color(0xFF94A3B8), size: 22),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Assigned Area',
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF475569),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'North Industrial Park',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 1, color: Color(0xFFF8FAFC)),

                              Department
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.badge_outlined, color: Color(0xFF94A3B8), size: 22),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Department',
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF475569),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Field Operations',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        ── Settings Menu ────────────────────────────────
                        Column(
                          children: [
                            Settings
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.settings_outlined, color: Color(0xFF94A3B8), size: 22),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Settings',
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF334155),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.chevron_right, color: Color(0xFFCBD5E1), size: 22),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            Logout
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.logout, color: Colors.red, size: 22),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Logout',
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.chevron_right, color: Color(0xFFFFCDD2), size: 22),
                                  ],
                                ),
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

            ── Bottom Nav ─────────────────────────────────────────────
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
                ),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    (Icons.home_filled,         Icons.home_outlined,          'Home'),
                    (Icons.assignment_turned_in, Icons.assignment_outlined,   'Tasks'),
                    (Icons.verified,             Icons.verified_outlined,     'Verify'),
                    (Icons.person,               Icons.person_outline,        'Profile'),
                  ].asMap().entries.map((e) {
                    final i = e.key;
                    final item = e.value;
                    final isSelected = _selectedIndex == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedIndex = i),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? item.$1 : item.$2,
                            color: isSelected ? primary : const Color(0xFF94A3B8),
                            size: 24,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.$3,
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? primary : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}