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
      appBar: AppBar(
        leading: IconButton(
          color: ColorManger.primary,

          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? CupertinoIcons.back
                : CupertinoIcons.back,
          ),
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

            return Row(
              children: [
                Text(
                  S.of(context).notifications,
                  style: TextStyle(
                    color: ColorManger.primary,
                    fontSize: ScreenUtilsManager.s22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                if (unreadCount > 0) ...[
                  SizedBox(width: ScreenUtilsManager.w8),
                  Badge(
                    backgroundColor: Colors.redAccent,
                    label: Text(
                      '$unreadCount',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: SizedBox(
                      width: ScreenUtilsManager.w8,
                      height: ScreenUtilsManager.h8,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
        actions: [
          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoaded &&
                  state.notifications.any((e) => !e.isRead)) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.w8,
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      context.read<NotificationCubit>().clearAllNotifications();
                    },
                    icon: Icon(
                      Icons.done_all_rounded,
                      size: ScreenUtilsManager.s20,
                    ),
                    label: Text(
                      S.of(context).markAllRead,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: ColorManger.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ScreenUtilsManager.r12,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
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
            return Center(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtilsManager.w24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: ScreenUtilsManager.s64,
                      color: Colors.red.shade300,
                    ),
                    SizedBox(height: ScreenUtilsManager.h16),
                    Text(
                      S.of(context).errorTitle,
                      style: TextStyle(
                        fontSize: ScreenUtilsManager.s18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: ScreenUtilsManager.h8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    SizedBox(height: ScreenUtilsManager.h24),
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.read<NotificationCubit>().getNotifications(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(S.of(context).tryAgain),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManger.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtilsManager.r12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is NotificationLoaded) {
            final list = state.notifications;

            if (list.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(ScreenUtilsManager.w24),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_paused_rounded,
                        size: ScreenUtilsManager.s64,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(height: ScreenUtilsManager.h24),
                    Text(
                      S.of(context).noNotifications,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: ScreenUtilsManager.h8),
                    Text(
                      S.of(context).caughtUpMessage,
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: ColorManger.primary,
              backgroundColor: Colors.white,
              onRefresh: () =>
                  context.read<NotificationCubit>().refreshNotifications(),
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: ScreenUtilsManager.h8,
                  bottom: ScreenUtilsManager.h24,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return NotificationTile(
                    item: item,
                    onTap: () {
                      context.read<NotificationCubit>().markAsRead(item.id);
                    },
                    onDelete: () {
                      context.read<NotificationCubit>().deleteNotification(
                        item.id,
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
