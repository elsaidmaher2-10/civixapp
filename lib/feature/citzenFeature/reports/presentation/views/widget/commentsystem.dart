import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
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

class Commentsystem extends StatelessWidget {
  const Commentsystem({
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
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: CupertinoActivityIndicator(
                  color: context.palette.kPrimary,
                  radius: ScreenUtilsManager.r12,
                ),
              ),
            ),
          );
        }

        if (state is CommentsFailure) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is CommentsSuccess) {
          final currentComments = state.comments.isEmpty
              ? comments
              : state.comments;

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
                        S.of(context).comments,
                        style: GoogleFonts.cairo(
                          color: context.palette.onSurface,
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
              ),
              currentComments.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: Text(
                            S.of(context).noCommentsYet,
                            style: GoogleFonts.cairo(
                              color: context.palette.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      sliver: SliverList.builder(
                        itemCount: currentComments.length,
                        itemBuilder: (context, index) {
                          return CommentBubble(comment: currentComments[index]);
                        },
                      ),
                    ),
              SliverToBoxAdapter(
                child: isComment
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                        child: CustomTextfromfield(
                          maxLines: null,
                          suffix: IconButton(
                            icon: Icon(
                              Icons.send_rounded,
                              color: context.palette.kPrimary,
                            ),
                            onPressed: () async {
                              if (controller.text.isNotEmpty) {
                                await context
                                    .read<CommentsCubit>()
                                    .makeComments(
                                      reporID,
                                      content: controller.text,
                                    );
                                controller.clear();
                              }
                            },
                          ),
                          color: Colors.white,
                          hinttext: S.of(context).addCommentHint,
                          lable: S.of(context).addCommentLabel,
                          controller: controller,
                        ),
                      ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
