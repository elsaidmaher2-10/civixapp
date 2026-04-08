import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/cubit/LogOut/LogOutState.dart';
import 'package:citifix/core/cubit/LogOut/LogOutcubit.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/Function/showLanguagePicker.dart';
import 'package:citifix/feature/workerFeature/profile/action_list_tile.dart';
import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:citifix/feature/workerFeature/profile/document_tile.dart';
import 'package:citifix/feature/workerFeature/profile/info_card.dart';
import 'package:citifix/feature/workerFeature/profile/logout_button.dart';
import 'package:citifix/feature/workerFeature/profile/profile_header.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserProfile? userProfile;

  Future<void> _onLogoutPressed(BuildContext context) async {
    final confirmed = await _showLogoutConfirmDialog(context);
    if (confirmed == true && context.mounted) {
      context.read<LogCubit>().logout();
    }
  }

  Future<bool?> _showLogoutConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).logout),
        content: Text(S.of(context).areYouSureLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(S.of(context).confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogCubit(getIt<LogOutRepository>()),
      child: Builder(
        builder: (context) => MultiBlocListener(
          listeners: [
            BlocListener<LogCubit, LogState>(
              listener: (context, state) {
                if (state is LogSuccess) {
                  Customsnackbar.show(
                    backgroundColor: Colors.green,
                    context: context,
                    message: state.logs,
                  );
                  PrefrenceManager().remove(Constantmanger.refreshToken);
                  PrefrenceManager().remove(Constantmanger.accessToken);
                  PrefrenceManager().remove(Constantmanger.cacheKey);
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
                } else if (state is LogFailure) {
                  String errorMessage = state.failure;

                  Customsnackbar.show(
                    backgroundColor: Colors.red,
                    context: context,
                    message: errorMessage,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<UserProfileInfoCubit, UserProfileInfoState>(
            builder: (context, userInfoState) {
              if (userInfoState is UserProfileInfoSuccess) {
                userProfile = userInfoState.user;
                print(userProfile?.profileImage);
              }
              if (userInfoState is EditUserProfileInfoSuccess) {
                userProfile = userInfoState.user;
              }
              return BlocBuilder<LogCubit, LogState>(
                builder: (context, logState) {
                  if (userProfile == null &&
                      userInfoState is! UserProfileInfoSuccess) {
                    return Scaffold(
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitPouringHourGlassRefined(
                              color: ColorManger.kPrimaryLight,
                              size: 70.h,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              S.of(context).loading,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorManger.kPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Scaffold(
                    backgroundColor: ColorManager.background,
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileHeader(
                            name: userProfile?.fullName ?? "",
                            avatarUrl:
                                userProfile?.profileImage ??
                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200',
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            child: Column(
                              children: [
                                InfoCard(
                                  icon: Icons.person_outline,
                                  title: S.of(context).accountInformation,
                                  children: [
                                    InfoField(
                                      label: S.of(context).fullName,
                                      value: userProfile?.fullName ?? 'N/A',
                                    ),
                                    const SizedBox(height: 24),
                                    InfoField(
                                      label: S.of(context).phone,
                                      value: userProfile?.phoneNumber ?? "N/A",
                                    ),
                                    const SizedBox(height: 24),
                                    InfoField(
                                      label: S.of(context).email,
                                      value: userProfile?.email ?? 'N/A',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (userProfile?.verified == true) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).complianceDocuments,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.onSurface,
                                        ),
                                  ),
                                  const SizedBox(height: 24),
                                  DocumentsRow(
                                    documents: [
                                      DocumentTileData(
                                        title: S.of(context).nationalIdFront,
                                        icon: Icon(Icons.badge_outlined),
                                        status: DocumentStatus.approved,
                                      ),
                                      DocumentTileData(
                                        title: S.of(context).nationalIdBack,
                                        icon: Icon(Icons.badge_outlined),
                                        status: DocumentStatus.approved,
                                      ),
                                      DocumentTileData(
                                        title: S.of(context).presonalPhoto,
                                        icon: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                userProfile?.profileImage ??
                                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200',
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        status: DocumentStatus.approved,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                              top: 48,
                            ),
                            child: ActionList(
                              actions: [
                                ActionListTileData(
                                  icon: Icons.edit_outlined,
                                  label: S.of(context).editProfile,
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                      context,
                                      Routes.editProfile,
                                    );
                                    if (context.mounted) {
                                      context
                                          .read<UserProfileInfoCubit>()
                                          .getUserProfleInfo();
                                    }
                                  },
                                ),
                                ActionListTileData(
                                  icon: Icons.lock_outline,
                                  label: S.of(context).changePassword,
                                  onTap: () {},
                                ),
                                ActionListTileData(
                                  icon: Icons.language,
                                  label: S.of(context).language,
                                  onTap: () =>
                                      showLanguagePicker(context, true),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 16,
                            ),
                            child: LogoutButton(
                              isLoading: logState is LogLoading,
                              onTap: () => _onLogoutPressed(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
