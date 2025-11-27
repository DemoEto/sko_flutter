import 'package:flutter/material.dart';

import 'package:sko_flutter/notification/presentation/notification_page.dart';
import 'package:sko_flutter/setting/presentation/setting_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sko_flutter/profile/presentation/profile_page.dart';

class TitlenameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitlenameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  void _showNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    );
  }

  void _showSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingPage()),
    );
  }

  void _showLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.tr("Logout")),
          content: Text(context.tr("LogoutConfirm")),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.tr("Cancel")),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.tr("LoggedOut"))),
                );
              },
              child: Text(context.tr("Confirm")),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF4A7FD8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF4A7FD8),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.tr("Hello"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'ชื่อ - สกุล',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Container(
            //       width: 50,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //       child: const Icon(
            //         Icons.person,
            //         color: Color(0xFF4A7FD8),
            //         size: 30,
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           context.tr("Hello"),
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const Text(
            //           'ชื่อ - สกุล',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => _showNotifications(context),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => _showSettings(context),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => _showLogout(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
