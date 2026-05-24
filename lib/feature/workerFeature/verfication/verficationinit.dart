import 'dart:async';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/verficationmodel.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/IDUploadCard.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/StepHeader.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/verifcationinitWidget/buildAppBar.dart';
import 'package:citifix/feature/workerFeature/verfication/widget/verifcationinitWidget/buildBottomBar.dart';
import 'package:citifix/generated/l10n.dart';
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

class VerificationInit extends StatefulWidget {
  const VerificationInit({super.key});

  @override
  State<VerificationInit> createState() => _GlobalGateVerificationPageState();
}

class _GlobalGateVerificationPageState extends State<VerificationInit> {
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
        color: context.palette.workerprimary,
      ),
      inAsyncCall: isasync,
      child: Scaffold(
        backgroundColor: context.palette.background,
        appBar: buildAppBar(context),
        body: BlocConsumer<VerificationInitCubit, VerificationInitState>(
          listener: (BuildContext context, VerificationInitState state) {
            if (state is VerificationRequestLoading) {
              setState(() => isasync = true);
            }
            if (state is VerificationRequestSuccess) {
              setState(() => isasync = false);
              Customsnackbar.show(
                context: context,
                backgroundColor: context.palette.success,
                message: S.of(context).requestSentSuccessfully,
              );
              Navigator.of(context).pop();
            }
            if (state is VerificationRequestError) {
              setState(() => isasync = false);
              Customsnackbar.show(
                context: context,
                backgroundColor: context.palette.red,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is VerificationInitLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: context.palette.workerprimary,
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
                      child: Text(
                        S.of(context).retry,
                        style: GoogleFonts.cairo(),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return _buildPageContent(context.read<VerificationInitCubit>());
            }
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

  Widget _buildPageContent(VerificationInitCubit cubit) {
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

          StepHeader(
            title: "${S.of(context).idFront} & ${S.of(context).idBack}",
            stepLabel: "${S.of(context).step} 1",
          ),
          const SizedBox(height: ScreenUtilsManager.itemSpacing),
          _buildIDSection(),

          const SizedBox(height: ScreenUtilsManager.sectionSpacing),

          StepHeader(
            title: S.of(context).category,
            stepLabel: "${S.of(context).step} 2",
          ),
          const SizedBox(height: ScreenUtilsManager.itemSpacing),
          _buildCategoryDropdown(departments),

          const SizedBox(height: ScreenUtilsManager.sectionSpacing),

          StepHeader(
            title: S.of(context).zone,
            stepLabel: "${S.of(context).step} 3",
          ),
          const SizedBox(height: ScreenUtilsManager.itemSpacing),
          _buildZoneGrid(areas),

          const SizedBox(height: ScreenUtilsManager.sectionSpacing),

          StepHeader(
            title: S.of(context).notesLabel,
            stepLabel: "${S.of(context).step} 4",
          ),
          const SizedBox(height: ScreenUtilsManager.itemSpacing),
          CustomTextfromfield(
            color: context.palette.surface,
            maxLines: 3,
            controller: notes,
            hinttext: S.of(context).enterNotes,
            lable: S.of(context).notesLabel,
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
            title: S.of(context).idFront,
            subtitle: S.of(context).tapToScan,
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
            title: S.of(context).idBack,
            subtitle: S.of(context).tapToScan,
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

  Widget _buildCategoryDropdown(List<Verficationmodel> items) {
    return CustomDropdown<String>.search(
      hintText: S.of(context).category,
      items: items.map((e) => e.name).toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = items.firstWhere((e) => e.name == value).id;
        });
        check();
      },
      decoration: CustomDropdownDecoration(
        closedFillColor: context.palette.lightGrey5,
        closedBorderRadius: BorderRadius.circular(16),
        closedBorder: Border.all(color: context.palette.outline.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildZoneGrid(List<Verficationmodel> areas) {
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
          child: _buildZoneItem(item, isSelected),
        );
      },
    );
  }

  Widget _buildZoneItem(Verficationmodel item, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? context.palette.workerprimary : context.palette.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.cardRadius),
        border: Border.all(
          color: isSelected ? context.palette.workerprimary : context.palette.outline,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: context.palette.workerprimary.withOpacity(0.2),
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
            Icons.location_on_outlined,
            color: isSelected ? Colors.white : context.palette.workerprimary,
          ),
          const SizedBox(height: 10),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : context.palette.onSurface,
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
          S.of(context).verificationTitle,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.headerFontSize,
            fontWeight: FontWeight.w900,
            color: context.palette.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          S.of(context).verificationSubTitle,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.subHeaderFontSize,
            color: context.palette.secondary,
          ),
        ),
      ],
    );
  }
}
