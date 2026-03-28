import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Gate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: 'Inter', // Assumes Inter is available, fallback to default
      ),
      home: const GlobalGateVerificationPage(),
    );
  }
}

class AppColors {
  static const primary = Color(0xFFFF7A00);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF5F5F5);
  static const onSurface = Color(0xFF222222);
  static const secondary = Color(0xFF777777);
  static const success = Color(0xFF34C759);
  static const outline = Color(0xFFDDDDDD);
  static const onPrimary = Color(0xFFFFFFFF);
  static const error = Color(0xFFFF3B30);
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

class GlobalGateVerificationPage extends StatefulWidget {
  const GlobalGateVerificationPage({super.key});

  @override
  State<GlobalGateVerificationPage> createState() =>
      _GlobalGateVerificationPageState();
}

class _GlobalGateVerificationPageState
    extends State<GlobalGateVerificationPage> {
  String? selectedZone;
  String selectedCategory = 'Electrical'; // Default selected from HTML

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Plumbing',
      'desc': 'System repairs and water management',
      'icon': Icons.plumbing,
    },
    {
      'title': 'Electrical',
      'desc': 'Grid maintenance and wiring setup',
      'icon': Icons.electrical_services,
    },
    {
      'title': 'Delivery',
      'desc': 'Incoming logistics and sorting',
      'icon': Icons.local_shipping,
    },
    {
      'title': 'Maintenance',
      'desc': 'General upkeep and inspection',
      'icon': Icons.home_repair_service,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 48),
            _buildStepOne(),
            const SizedBox(height: 48),
            _buildStepTwo(),
            const SizedBox(height: 48),
            _buildStepThree(),
          ],
        ),
      ),
      // Sticky bottom bar
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // --- App Bar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background.withOpacity(0.9),
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          const Icon(Icons.security, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text(
            'Global Gate',
            style: TextStyle(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppColors.secondary),
          onPressed: () {},
        ),
      ],
    );
  }

  // --- Main Header ---
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              height: 1.1,
              color: AppColors.onSurface,
            ),
            children: [
              TextSpan(text: 'Verify Your\n'),
              TextSpan(
                text: 'Credentials',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Complete the following steps to gain secure access to the Global Gate network.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.secondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // --- Step 1: ID Upload ---
  Widget _buildStepOne() {
    return Column(
      children: [
        _buildSectionHeader('Identity Documents', 'Step 1 of 3'),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildUploadCard(
                'Upload ID Front',
                'Tap to upload',
                Icons.add_a_photo,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildUploadCard(
                'Upload ID Back',
                'Tap to upload',
                Icons.contact_page,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUploadCard(String title, String subtitle, IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(32),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: AppColors.secondary),
            ),
          ],
        ),
      ),
    );
  }

  // --- Step 2: Workspace ---
  Widget _buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Workspace', 'Step 2 of 3'),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 4, right: 12),
          child: Text(
            'Select Your Work Zone',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: selectedZone,
          icon: const Icon(Icons.expand_more, color: AppColors.primary),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.outline.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          hint: const Text(
            'Choose a secure location...',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.onSurface,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'hq',
              child: Text('Headquarters (Main Campus)'),
            ),
            DropdownMenuItem(
              value: 'lab',
              child: Text('Research & Logistics Lab'),
            ),
            DropdownMenuItem(
              value: 'data',
              child: Text('Data Sovereignty Hub'),
            ),
            DropdownMenuItem(
              value: 'ops',
              child: Text('Global Operations Center'),
            ),
          ],
          onChanged: (val) {
            setState(() {
              selectedZone = val;
            });
          },
        ),
      ],
    );
  }

  // --- Step 3: Service Category ---
  Widget _buildStepThree() {
    return Column(
      children: [
        _buildSectionHeader('Service Category', 'Step 3 of 3'),
        const SizedBox(height: 24),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategory == category['title'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category['title'];
                });
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.05)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(category['icon'], color: AppColors.primary),
                        const Spacer(),
                        Text(
                          category['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category['desc'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.secondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    if (isSelected)
                      const Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.success,
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // --- Shared Section Header Component ---
  Widget _buildSectionHeader(String title, String stepText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            stepText.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  // --- Sticky Bottom Bar ---
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.background.withOpacity(0.9)),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 4,
                shadowColor: AppColors.primary.withOpacity(0.4),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verify Now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'By tapping Verify, you agree to the Global Gate Secure Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
