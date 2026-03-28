import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/IDUploadCard.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/StepHeader.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class GlobalGateVerificationPage extends StatefulWidget {
  const GlobalGateVerificationPage({super.key});
  @override
  State<GlobalGateVerificationPage> createState() =>
      _GlobalGateVerificationPageState();
}

class _GlobalGateVerificationPageState
    extends State<GlobalGateVerificationPage> {
  String? selectedZone;
  String selectedCategory = 'Electrical';

  final List<String> _zones = [
    'Headquarters',
    'Ops Lab',
    'Data Sovereignty Hub',
    'Security Wing',
  ];

  final List<Map<String, dynamic>> _categories = [
    {'title': 'Plumbing', 'icon': Icons.plumbing},
    {'title': 'Electrical', 'icon': Icons.electrical_services},
    {'title': 'Delivery', 'icon': Icons.local_shipping},
    {'title': 'Maintenance', 'icon': Icons.home_repair_service},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        // استخدام BouncingScrollPhysics يعطي إحساساً أفضل في iOS و Android
        physics: const BouncingScrollPhysics(),
        padding: ScreenUtilsManager.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainHeader(),
            const SizedBox(height: ScreenUtilsManager.sectionSpacing),

            // الخطوة 1: رفع الهوية
            StepHeader(
              title: Constantmanger.step1Title,
              stepLabel: Constantmanger.step1Label,
            ),
            const SizedBox(height: ScreenUtilsManager.itemSpacing),
            _buildIDSection(),

            const SizedBox(height: ScreenUtilsManager.sectionSpacing),

            // الخطوة 2: منطقة العمل
            StepHeader(
              title: Constantmanger.step2Title,
              stepLabel: Constantmanger.step2Label,
            ),
            const SizedBox(height: ScreenUtilsManager.itemSpacing),
            _buildZoneDropdown(),

            const SizedBox(height: ScreenUtilsManager.sectionSpacing),

            // الخطوة 3: التخصص
            StepHeader(
              title: Constantmanger.step3Title,
              stepLabel: Constantmanger.step3Label,
            ),
            const SizedBox(height: ScreenUtilsManager.itemSpacing),
            _buildCategoryGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // --- بناء الهيدر الرئيسي ---
  Widget _buildMainHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constantmanger.mainTitle,
          style: TextStyle(
            fontSize: ScreenUtilsManager.headerFontSize,
            fontWeight: FontWeight.w900,
            height: 1.1,
            color: ColorManger.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          Constantmanger.subTitle,
          style: TextStyle(
            fontSize: ScreenUtilsManager.subHeaderFontSize,
            color: ColorManger.secondary,
          ),
        ),
      ],
    );
  }

  // --- القائمة المنسدلة المخصصة ---
  Widget _buildZoneDropdown() {
    return CustomDropdown<String>.search(
      hintText: Constantmanger.dropdownHint,
      items: _zones,
      onChanged: (value) => setState(() => selectedZone = value),
      decoration: CustomDropdownDecoration(
        closedFillColor: ColorManger.lightGrey5,
        closedBorderRadius: BorderRadius.circular(16),
        closedBorder: Border.all(color: ColorManger.outline.withOpacity(0.5)),
        searchFieldDecoration: SearchFieldDecoration(
          fillColor: ColorManger.white,
          prefixIcon: const Icon(Icons.search, color: ColorManger.lightGrey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  // --- شبكة التصنيفات ---
  Widget _buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: ScreenUtilsManager.gridSpacing,
        mainAxisSpacing: ScreenUtilsManager.gridSpacing,
        childAspectRatio: ScreenUtilsManager.childAspectRatio,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final item = _categories[index];
        final bool isSelected = selectedCategory == item['title'];
        return _buildCategoryItem(item, isSelected);
      },
    );
  }

  // --- عنصر التصنيف الفردي ---
  Widget _buildCategoryItem(Map<String, dynamic> item, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = item['title']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // سرعة أنميشن منطقية
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? ColorManger.workerprimary : ColorManger.white,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.cardRadius),
          border: Border.all(
            color: isSelected ? ColorManger.workerprimary : ColorManger.outline,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorManger.workerprimary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item['icon'],
              color: isSelected ? Colors.white : ColorManger.workerprimary,
            ),
            const SizedBox(height: 10),
            Text(
              item['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : ColorManger.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- الشريط السفلي مع زر التحقق ---
  Widget _buildBottomBar() {
    // الزر يكون متاحاً فقط إذا تم اختيار المنطقة
    bool isReady = selectedZone != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      color: ColorManger.background,
      child: ElevatedButton(
        onPressed: isReady
            ? () {
                // نفذ عملية التحقق هنا
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManger.workerprimary,
          disabledBackgroundColor: ColorManger.lightGrey,
          minimumSize: Size(double.infinity, ScreenUtilsManager.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        child: const Text(
          Constantmanger.verifyButtonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // --- الأداة العلوية AppBar ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leadingWidth: ScreenUtilsManager.w24,
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorManger.background,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.security, color: ColorManger.workerprimary),
          SizedBox(width: ScreenUtilsManager.w4),
          Text(
            Constantmanger.verificationPage,
            style: TextStyle(
              color: ColorManger.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s18,
            ),
          ),
        ],
      ),
    );
  }

  // --- قسم رفع الهوية ---
  Widget _buildIDSection() {
    return const Row(
      children: [
        Expanded(
          child: IDUploadCard(
            title: 'ID Front',
            subtitle: 'Tap to scan',
            icon: Icons.camera_front,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: IDUploadCard(
            title: 'ID Back',
            subtitle: 'Tap to scan',
            icon: Icons.camera_rear,
          ),
        ),
      ],
    );
  }
}
