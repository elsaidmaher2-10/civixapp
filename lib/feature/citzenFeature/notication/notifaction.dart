import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/views/widget/noticationtile.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/citzenFeature/notication/presentation/manager/cubit/notifcation_state.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: ColorManger.primary,
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: ColorManger.surface,
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
                style: TextStyle(
                  color: ColorManger.primary,
                  fontSize: ScreenUtilsManager.s20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unreadCount > 0)
                Text(
                  "$unreadCount ${S.of(context).unread}",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: ScreenUtilsManager.s12,
                    fontWeight: FontWeight.w500,
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
              return Row(
                children: [
                  if (hasUnread)
                    IconButton(
                      tooltip: S.of(context).markAllRead,
                      icon: const Icon(Icons.done_all_rounded),
                      color: ColorManger.primary,
                      onPressed: () => context
                          .read<NotificationCubit>()
                          .markAllNotificationsAsRead(),
                    ),
                  IconButton(
                    tooltip: S.of(context).deleteall,
                    icon: const Icon(Icons.delete_sweep_outlined),
                    color: Colors.redAccent,
                    onPressed: () => context
                        .read<NotificationCubit>()
                        .clearAllNotifications(),
                  ),
                  SizedBox(width: ScreenUtilsManager.w8),
                ],
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
        if (state is NotificationLoading) {
          return Center(
            child: CupertinoActivityIndicator(
              color: ColorManger.kPrimary,
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

        return const SizedBox();
      },
    );
  }

  Widget _buildNotificationList(List notifications) {
    return RefreshIndicator(
      color: ColorManger.primary,
      onRefresh: () => context.read<NotificationCubit>().refreshNotifications(),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w20),
              color: Colors.redAccent.withOpacity(0.1),
              child: const Icon(Icons.delete_outline, color: Colors.white),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Text(
            S.of(context).noNotifications,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 60, color: Colors.redAccent),
          Text(message),
          TextButton(
            onPressed: () =>
                context.read<NotificationCubit>().getNotifications(),
            child: Text(S.of(context).tryAgain),
          ),
        ],
      ),
    );
  }
}
