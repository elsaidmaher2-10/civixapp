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
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w16,
                  vertical: ScreenUtilsManager.h12,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ScreenUtilsManager.h8),
                      decoration: BoxDecoration(
                        color: context.palette.workerprimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                      ),
                      child: SvgPicture.asset(
                        "assets/commentsytem.svg",
                        width: ScreenUtilsManager.s20,
                        colorFilter: ColorFilter.mode(
                          context.palette.workerprimary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtilsManager.w12),
                    Text(
                      S.of(context).comments,
                      style: GoogleFonts.cairo(
                        color: context.palette.onSurface,
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtilsManager.s18,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.w12,
                        vertical: ScreenUtilsManager.h6,
                      ),
                      decoration: BoxDecoration(
                        color: context.palette.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
                        border: Border.all(
                          color: context.palette.outline.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        S.of(context).messagesCount(currentComments.length),
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s12,
                          fontWeight: FontWeight.w700,
                          color: context.palette.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Comments List Section
              currentComments.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h40),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: ScreenUtilsManager.s48,
                              color: context.palette.onSurfaceVariant.withOpacity(0.2),
                            ),
                            SizedBox(height: ScreenUtilsManager.h12),
                            Text(
                              S.of(context).noCommentsYet,
                              style: GoogleFonts.cairo(
                                color: context.palette.onSurfaceVariant.withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentComments.length,
                        itemBuilder: (context, index) {
                          return CommentBubble(comment: currentComments[index]);
                        },
                      ),
                    ),

              if (!isComment)
                Container(
                  padding: EdgeInsets.fromLTRB(
                    ScreenUtilsManager.w16,
                    ScreenUtilsManager.h8,
                    ScreenUtilsManager.w16,
                    ScreenUtilsManager.h24,
                  ),
                  decoration: BoxDecoration(
                    color: context.palette.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.palette.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
                            border: Border.all(
                              color: context.palette.outline.withOpacity(0.1),
                            ),
                          ),
                          child: TextField(
                            controller: controller,
                            maxLines: 4,
                            minLines: 1,
                            style: GoogleFonts.cairo(
                              fontSize: ScreenUtilsManager.s14,
                              color: context.palette.onSurface,
                            ),
                            decoration: InputDecoration(
                              hintText: S.of(context).addCommentHint,
                              hintStyle: GoogleFonts.cairo(
                                fontSize: ScreenUtilsManager.s14,
                                color: context.palette.onSurfaceVariant.withOpacity(0.5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenUtilsManager.w16,
                                vertical: ScreenUtilsManager.h12,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenUtilsManager.w12),
                      GestureDetector(
                        onTap: () async {
                          if (controller.text.trim().isNotEmpty) {
                            await context.read<CommentsCubit>().makeComments(
                                  reporID,
                                  content: controller.text,
                                );
                            controller.clear();
                          }
                        },
                        child: Container(
                          width: ScreenUtilsManager.h44,
                          height: ScreenUtilsManager.h44,
                          decoration: BoxDecoration(
                            gradient: context.palette.kineticGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: context.palette.workerprimary.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
