import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/views/widget/noticationtile.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_state.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  late bool isWorker;
  late Color primaryColor;

  @override
  void initState() {
    super.initState();
    // Non-inherited widget logic is safe here
    context.read<NotificationCubit>().getNotifications();
    isWorker = PrefrenceManager().getstring("role")?.toLowerCase() == "worker";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // FIXED: Accessing context.palette here is safe because the widget is fully mounted.
    // This method is called after initState and whenever the theme/palette changes.
    primaryColor = isWorker
        ? context.palette.workerprimary
        : context.palette.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: primaryColor,
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      backgroundColor: context.palette.surface,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: false,
      title: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          int unreadCount = 0;
          if (state is NotificationLoaded) {
            unreadCount = state.notifications.where((e) => !e.isRead).length;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).notifications,
                style: GoogleFonts.cairo(
                  color: primaryColor,
                  fontSize: ScreenUtilsManager.s20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (unreadCount > 0)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    "$unreadCount ${S.of(context).unread}",
                    key: ValueKey(unreadCount),
                    style: GoogleFonts.cairo(
                      color: context.palette.onSurfaceVariant,
                      fontSize: ScreenUtilsManager.s12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      actions: [
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoaded && state.notifications.isNotEmpty) {
              final hasUnread = state.notifications.any((e) => !e.isRead);
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w8,
                ),
                child: Row(
                  children: [
                    if (hasUnread)
                      IconButton(
                        tooltip: S.of(context).markAllRead,
                        icon: const Icon(Icons.checklist_rtl_rounded),
                        color: primaryColor,
                        onPressed: () => context
                            .read<NotificationCubit>()
                            .markAllNotificationsAsRead(),
                      ),
                    IconButton(
                      tooltip: S.of(context).deleteall,
                      icon: const Icon(Icons.delete_sweep_rounded),
                      color: Colors.red.shade400,
                      onPressed: () => context
                          .read<NotificationCubit>()
                          .clearAllNotifications(),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _getResponsiveBody(state),
        );
      },
    );
  }

  Widget _getResponsiveBody(NotificationState state) {
    if (state is NotificationLoading) {
      return Center(
        key: const Key('loading'),
        child: CupertinoActivityIndicator(
          color: primaryColor,
          radius: ScreenUtilsManager.r15,
        ),
      );
    }

    if (state is NotificationError) {
      return _buildErrorState(state.message);
    }

    if (state is NotificationLoaded) {
      if (state.notifications.isEmpty) {
        return _buildEmptyState();
      }
      return _buildNotificationList(state.notifications);
    }

    return const SizedBox(key: Key('empty_fallback'));
  }

  Widget _buildNotificationList(List notifications) {
    return RefreshIndicator(
      color: primaryColor,
      backgroundColor: context.palette.surface,
      onRefresh: () => context.read<NotificationCubit>().refreshNotifications(),
      child: ListView.separated(
        key: const Key('list'),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtilsManager.h16,
          horizontal: ScreenUtilsManager.w12,
        ),
        itemCount: notifications.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: ScreenUtilsManager.h10),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            onDismissed: (direction) {
              context.read<NotificationCubit>().deleteNotification(item.id);
            },
            child: NotificationTile(
              item: item,
              onTap: () =>
                  context.read<NotificationCubit>().markAsRead(item.id),
              onDelete: () =>
                  context.read<NotificationCubit>().deleteNotification(item.id),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      key: const Key('empty'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              size: 70,
              color: primaryColor.withOpacity(0.5),
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          Text(
            S.of(context).noNotifications,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s18,
              fontWeight: FontWeight.w700,
              color: context.palette.onSurface,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h8),
          Text(
            "You're all caught up!",
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              color: context.palette.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      key: const Key('error'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isWorker
                    ? context.palette.error.withValues(alpha: 0.15)
                    : context.palette.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 50,
                color: isWorker
                    ? context.palette.error
                    : context.palette.onSurfaceVariant,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              S.of(context).errorTitle,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.bold,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: context.palette.onSurfaceVariant,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: context.palette.onPrimary,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w24,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () =>
                  context.read<NotificationCubit>().getNotifications(),
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                S.of(context).tryAgain,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
