import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/commentmodel/commentmodel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/comment/commentmanger_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/comment/commentmanger_state.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/commentBubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../generated/l10n.dart';

class Workercomments extends StatelessWidget {
  const Workercomments({
    super.key,
    required this.isComment,
    required this.comments,
    required this.controller,
    required this.reporID,
  });

  final bool isComment;
  final TextEditingController controller;
  final int reporID;
  final List<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: CupertinoActivityIndicator(
                color: context.palette.kPrimary,
                radius: ScreenUtilsManager.r12,
              ),
            ),
          );
        }

        if (state is CommentsFailure) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(state.errorMessage),
            ),
          );
        }

        if (state is CommentsSuccess ||
            state is CommentsInitial ||
            state is CommentsLoading) {
          final currentComments = (state is CommentsSuccess)
              ? state.comments
              : comments;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/commentsytem.svg",
                      width: 24.w,
                      colorFilter: ColorFilter.mode(
                        context.palette.workerprimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: ScreenUtilsManager.w8),
                    Text(
                      S.of(context).comments,
                      style: GoogleFonts.cairo(
                        color: context.palette.workerprimary,
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
                        color: context.palette.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        S.of(context).messagesCount(currentComments.length),
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          color: context.palette.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Comments List Section
              currentComments.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: Text(
                          S.of(context).noCommentsYet,
                          style: GoogleFonts.cairo(
                            color: context.palette.onSurfaceVariant,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentComments.length,
                        itemBuilder: (context, index) {
                          return CommentBubble(comment: currentComments[index]);
                        },
                      ),
                    ),

              // Add Comment Field Section
              if (!isComment)
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                  child: CustomTextfromfield(
                    maxLines: null,
                    suffix: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: context.palette.workerprimary,
                      ),
                      onPressed: () async {
                        if (controller.text.trim().isNotEmpty) {
                          await context.read<CommentsCubit>().makeComments(
                            reporID,
                            content: controller.text,
                          );
                          controller.clear();
                        }
                      },
                    ),
                    color: context.palette.bgLight,
                    hinttext: S.of(context).addCommentHint,
                    lable: S.of(context).addCommentLabel,
                    controller: controller,
                  ),
                ),
              SizedBox(height: 50.h),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
