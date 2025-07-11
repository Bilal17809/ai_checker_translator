
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
        
            decoration: const BoxDecoration(
              color: kMintGreen
            ),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                    const Icon(Icons.apps, color: Colors.white, size: 40),
                    const SizedBox(width: 12),
                    Text(
                      "AI Checker Translator",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  
              ],
            ),
          ),

          // Reusable drawer tiles
          DrawerTile(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
              // Handle navigation here
            },
          ),
          DrawerTile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          DrawerTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}




class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      onTap: onTap,
    );
  }
}
