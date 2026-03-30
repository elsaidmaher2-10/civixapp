import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/comment/commentmanger_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/comment/commentmanger_state.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/commentBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Commentsystem extends StatelessWidget {
  const Commentsystem({
    required this.controller,
    required this.reporID,
    super.key,
  });

  final TextEditingController controller;
  final int reporID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CommentsFailure) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.errorMessage)),
          );
        } else if (state is CommentsSuccess) {
          final comments = state.comments;
          return SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/commentsytem.svg", width: 24.w),
                      SizedBox(width: ScreenUtilsManager.w8),
                      Text(
                        "Comments",
                        style: TextStyle(
                          color: ColorManger.kPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManger.lightGrey5,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "${comments.length} Messages",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (comments.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: Text(
                        "No comments yet. Be the first to reply!",
                        style: GoogleFonts.inter(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverList.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return CommentBubble(comment: comments[index]);
                    },
                  ),
                ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                  child: CustomTextfromfield(
                    prefix: _buildUserAvatar(),
                    suffix: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: ColorManger.kPrimary,
                      ),
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          context.read<CommentsCubit>().makeComments(
                            reporID,
                            content: controller.text,
                          );
                          controller.clear();
                        }
                      },
                    ),
                    color: Colors.white,
                    hinttext: "Add a reply or a new inquiry...",
                    lable: "Add Comment",
                    controller: controller,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildUserAvatar() {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: CircleAvatar(
        radius: 12.r,
        backgroundColor: ColorManger.lightGrey5,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: Constantmanger.defualtImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
