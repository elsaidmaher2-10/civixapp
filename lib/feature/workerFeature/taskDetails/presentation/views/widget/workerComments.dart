import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
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

class Workercomments extends StatefulWidget {
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
  State<Workercomments> createState() => _WorkercommentsState();
}

class _WorkercommentsState extends State<Workercomments> {
  bool _isSending = false;

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
              : widget.comments;

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

              if (!widget.isComment)
                Container(
                  padding: EdgeInsets.fromLTRB(
                    ScreenUtilsManager.w16,
                    ScreenUtilsManager.h12,
                    ScreenUtilsManager.w16,
                    ScreenUtilsManager.h24,
                  ),
                  decoration: BoxDecoration(
                    color: context.palette.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.palette.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
                            border: Border.all(
                              color: context.palette.outline.withOpacity(0.2),
                            ),
                          ),
                          child: TextField(
                            controller: widget.controller,
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
                                horizontal: ScreenUtilsManager.w20,
                                vertical: ScreenUtilsManager.h12,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenUtilsManager.w12),
                      GestureDetector(
                        onTap: _isSending
                            ? null
                            : () async {
                                if (widget.controller.text.trim().isNotEmpty) {
                                  setState(() {
                                    _isSending = true;
                                  });
                                  
                                  await context.read<CommentsCubit>().makeComments(
                                        widget.reporID,
                                        content: widget.controller.text,
                                      );
                                  widget.controller.clear();
                                  
                                  // 2-second delay before allowing to send again
                                  await Future.delayed(const Duration(seconds: 2));
                                  if (mounted) {
                                    setState(() {
                                      _isSending = false;
                                    });
                                  }
                                }
                              },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: ScreenUtilsManager.h48,
                          height: ScreenUtilsManager.h48,
                          decoration: BoxDecoration(
                            color: _isSending 
                                ? context.palette.grey300 
                                : context.palette.workerprimary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              if (!_isSending)
                                BoxShadow(
                                  color: context.palette.workerprimary.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          ),
                          child: _isSending
                              ? const CupertinoActivityIndicator(color: Colors.white, radius: 10)
                              : const Icon(
                                  Icons.send_rounded,
                                  color: Colors.white,
                                  size: 24,
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
