import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/notication/presentation/views/widget/noticationtile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:citifix/feature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/notication/presentation/manager/cubit/notifcation_state.dart';

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
                const Text(
                  'Notifications',
                  style: TextStyle(
                    color: ColorManger.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                if (unreadCount > 0) ...[
                  const SizedBox(width: 8),
                  Badge(
                    backgroundColor: Colors.redAccent,
                    label: Text(
                      '$unreadCount',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: const SizedBox(width: 8, height: 8),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton.icon(
                    onPressed: () {
                      context.read<NotificationCubit>().clearAllNotifications();
                    },
                    icon: const Icon(Icons.done_all_rounded, size: 20),
                    label: const Text(
                      'Mark all read',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: ColorManger.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
            return const Center(
              child: CupertinoActivityIndicator(
                color: ColorManger.kPrimary,
                radius: 15,
              ),
            );
          }

          if (state is NotificationError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.read<NotificationCubit>().getNotifications(),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManger.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_paused_rounded,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No new notifications',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You are all caught up! Check back later.',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              );
            }

            // عرض الإشعارات
            return RefreshIndicator(
              color: ColorManger.primary,
              backgroundColor: Colors.white,
              onRefresh: () =>
                  context.read<NotificationCubit>().refreshNotifications(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                // إزالة separatorBuilder واستخدام Padding داخل الـ NotificationTile نفسه (حسب التعديل السابق)
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
