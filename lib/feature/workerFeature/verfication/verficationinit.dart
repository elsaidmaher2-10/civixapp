import 'dart:async';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/verficationmodel.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/IDUploadCard.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/StepHeader.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/verifcationinitWidget/buildAppBar.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/verifcationinitWidget/buildBottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/widget/CustomSnackBar.dart';
import 'Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'Presentation/VerficationinitManger/verficationinitState.dart';
import 'data/model/VerificationrequestModel.dart';

class GlobalGateVerificationPage extends StatefulWidget {
  const GlobalGateVerificationPage({super.key});

  @override
  State<GlobalGateVerificationPage> createState() =>
      _GlobalGateVerificationPageState();
}

class _GlobalGateVerificationPageState
    extends State<GlobalGateVerificationPage> {
  int? selectedZone;
  int? selectedCategory;

  final StreamController<File?> idfront = StreamController.broadcast();
  final StreamController<File?> idback = StreamController.broadcast();
  File? frontFile;
  File? backFile;

  final StreamController<bool> btn = StreamController.broadcast();
  final TextEditingController notes = TextEditingController();

  bool isReady = false;
  bool isasync = false;

  @override
  void initState() {
    super.initState();
    notes.addListener(check);
    context.read<VerificationInitCubit>().loadInitialData();
  }

  void check() {
    bool ready =
        selectedZone != null &&
        selectedCategory != null &&
        notes.text.isNotEmpty &&
        frontFile != null &&
        backFile != null;

    setState(() {
      isReady = ready;
    });
    btn.add(isReady);
  }

  @override
  void dispose() {
    idfront.close();
    idback.close();
    notes.dispose();
    btn.close();
    super.dispose();
  }

  Future<XFile?> _pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      blur: 7,
      progressIndicator: CupertinoActivityIndicator(
        radius: ScreenUtilsManager.r12,
        color: ColorManger.workerprimary,
      ),
      inAsyncCall: isasync,
      child: Scaffold(
        backgroundColor: ColorManger.background,
        appBar: buildAppBar(),
        body: BlocConsumer<VerificationInitCubit, VerificationInitState>(
          listener: (BuildContext context, VerificationInitState state) {
            if (state is VerificationRequestLoading) {
              setState(() => isasync = true);
            }
            if (state is VerificationRequestSuccess) {
              setState(() => isasync = false);
              Customsnackbar.show(
                context: context,
                backgroundColor: Colors.green,
                message: state.message,
              );
              Navigator.of(context).pop();
            }
            if (state is VerificationRequestError) {
              setState(() => isasync = false);
              Customsnackbar.show(
                context: context,
                backgroundColor: Colors.red,
                message: state.errorMessage,
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is VerificationInitLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: ColorManger.workerprimary,
                  radius: ScreenUtilsManager.r12,
                ),
              );
            } else if (state is VerificationInitError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () => context
                          .read<VerificationInitCubit>()
                          .loadInitialData(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            } else if (state is VerificationInitSuccess ||
                state is VerificationRequestLoading ||
                state is VerificationRequestError) {
              return _buildPageContent(
                context.read<VerificationInitCubit>(),
                isasync,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: buildBottomBar(
          btn,
          isReady
              ? VerificationrequestModel(
                  AreaId: selectedZone!,
                  DepartmentId: selectedCategory!,
                  NationalIdBackImage: backFile!,
                  NationalIdFrontImage: frontFile!,
                  Notes: notes.text,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildPageContent(VerificationInitCubit cubit, bool isloading) {
    final departments = cubit.departmentsList?.info ?? [];
    final areas = cubit.areasList?.info ?? [];
    return SingleChildScrollView(
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

          StepHeader(
            title: Constantmanger.step3Title,
            stepLabel: Constantmanger.step3Label,
          ),
          const SizedBox(height: ScreenUtilsManager.itemSpacing),
          _buildZoneDropdown(departments),
          const SizedBox(height: ScreenUtilsManager.sectionSpacing),

          StepHeader(
            title: Constantmanger.step2Title,
            stepLabel: Constantmanger.step2Label,
          ),
          const SizedBox(height: ScreenUtilsManager.itemSpacing),
          _buildCategoryGrid(areas),
          const SizedBox(height: ScreenUtilsManager.sectionSpacing),
          StepHeader(title: "", stepLabel: Constantmanger.step4Label),
          const SizedBox(height: ScreenUtilsManager.itemSpacing),
          CustomTextfromfield(
            color: ColorManger.surface,
            maxLines: 3,
            controller: notes,
            hinttext: "Enter your notes",
            lable: "Notes",
            onChanged: (v) => check(),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildIDSection() {
    return Row(
      children: [
        Expanded(
          child: IDUploadCard(
            imageController: idfront,
            title: 'ID Front',
            subtitle: 'Tap to scan',
            icon: Icons.camera_front,
            ontap: () async {
              XFile? file = await _pickImage();
              if (file != null) {
                frontFile = File(file.path);
                idfront.add(frontFile);
                check();
              }
            },
            removeimagebtn: () {
              frontFile = null;
              idfront.add(null);
              check();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: IDUploadCard(
            imageController: idback,
            title: 'ID Back',
            subtitle: 'Tap to scan',
            icon: Icons.camera_rear,
            ontap: () async {
              XFile? file = await _pickImage();
              if (file != null) {
                backFile = File(file.path);
                idback.add(backFile);
                check();
              }
            },
            removeimagebtn: () {
              backFile = null;
              idback.add(null);
              check();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildZoneDropdown(List<Verficationmodel> items) {
    return CustomDropdown<String>.search(
      hintText: Constantmanger.dropdownHint,
      items: items.map((e) => e.name).toList(),
      onChanged: (value) {
        setState(
          () => selectedCategory = items.firstWhere((e) => e.name == value).id,
        );

        print(selectedCategory);

        check();
      },
      decoration: CustomDropdownDecoration(
        closedFillColor: ColorManger.lightGrey5,
        closedBorderRadius: BorderRadius.circular(16),
        closedBorder: Border.all(color: ColorManger.outline.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildCategoryGrid(List<Verficationmodel> areas) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: ScreenUtilsManager.gridSpacing,
        mainAxisSpacing: ScreenUtilsManager.gridSpacing,
        childAspectRatio: ScreenUtilsManager.childAspectRatio,
      ),
      itemCount: areas.length,
      itemBuilder: (context, index) {
        final item = areas[index];
        final bool isSelected = selectedZone == item.id;
        return GestureDetector(
          onTap: () {
            setState(() => selectedZone = item.id);
            check();
          },
          child: _buildCategoryItem(item, isSelected),
        );
      },
    );
  }

  Widget _buildCategoryItem(Verficationmodel item, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
            Icons.category_outlined,
            color: isSelected ? Colors.white : ColorManger.workerprimary,
          ),
          const SizedBox(height: 10),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : ColorManger.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constantmanger.mainTitle,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.headerFontSize,
            fontWeight: FontWeight.w900,
            color: ColorManger.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          Constantmanger.subTitle,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.subHeaderFontSize,
            color: ColorManger.secondary,
          ),
        ),
      ],
    );
  }
}
