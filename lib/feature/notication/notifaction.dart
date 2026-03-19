import 'package:flutter/material.dart';

// ─── Color tokens ────────────────────────────────────────────────────────────
class _C {
  static const surface = Color(0xFFF7F9FB);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF191C1E);
  static const onSurfaceVariant = Color(0xFF424751);
  static const primary = Color(0xFF00346F);
  static const primaryFixed = Color(0xFFD7E2FF);
}

// ─── Data Model ──────────────────────────────────────────────────────────────
class NotificationItem {
  final String id;
  final IconData icon;
  final String title;
  final String message;
  final String time;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });

  // This creates a NEW object with the updated boolean
  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      id: id,
      icon: icon,
      title: title,
      message: message,
      time: time,
      isRead: isRead ?? this.isRead,
    );
  }
}

// ─── Main Screen ─────────────────────────────────────────────────────────────
class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  // Initial list of notifications
  List<NotificationItem> _list = [
    NotificationItem(
      id: '1',
      icon: Icons.construction_rounded,
      title: 'Main Street Repair',
      message: 'Crew dispatched to repair the pothole.',
      time: '2m ago',
    ),
    NotificationItem(
      id: '2',
      icon: Icons.lightbulb_outline,
      title: 'Light Fixed',
      message: 'The street light on Oak Ave is now operational.',
      time: '1h ago',
    ),
    NotificationItem(
      id: '3',
      icon: Icons.check_circle_outline,
      title: 'Resolved',
      message: 'Your previous report has been closed.',
      time: 'Yesterday',
      isRead: false, // Example of one already read
    ),
  ];

  // Logic: Mark one as read
  void _handleTap(int index) {
    if (_list[index].isRead)
      return; // Optimization: don't rebuild if already read

    setState(() {
      _list[index] = _list[index].copyWith(isRead: true);
    });
  }

  // Logic: Mark everything as read
  void _markAllRead() {
    setState(() {
      _list = _list.map((item) => item.copyWith(isRead: true)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    int unreadCount = _list.where((item) => !item.isRead).length;

    return Scaffold(
      backgroundColor: _C.surface,
      appBar: AppBar(
        backgroundColor: _C.surface,
        elevation: 0,
        title: Text(
          'Notifications ${unreadCount > 0 ? "($unreadCount)" : ""}',
          style: const TextStyle(
            color: _C.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _list.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _list[index];
          return _NotificationTile(item: item, onTap: () => _handleTap(index));
        },
      ),
    );
  }
}

// ─── UI Tile Component ───────────────────────────────────────────────────────
class _NotificationTile extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;

  const _NotificationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        // Changes color and shadow based on read status
        color: item.isRead ? Colors.transparent : _C.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isRead
              ? Colors.grey.withOpacity(0.2)
              : Colors.transparent,
        ),
        boxShadow: item.isRead
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon + Unread Indicator
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item.isRead
                            ? Colors.grey.shade200
                            : _C.primaryFixed,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.icon,
                        color: item.isRead ? Colors.grey : _C.primary,
                        size: 20,
                      ),
                    ),
                    if (!item.isRead)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: item.isRead
                                  ? FontWeight.w500
                                  : FontWeight.w800,
                              color: item.isRead
                                  ? _C.onSurfaceVariant
                                  : _C.onSurface,
                            ),
                          ),
                          Text(
                            item.time,
                            style: const TextStyle(
                              fontSize: 11,
                              color: _C.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.message,
                        style: TextStyle(
                          fontSize: 13,
                          color: _C.onSurfaceVariant.withOpacity(0.7),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
