import 'package:flutter/material.dart';
import 'package:ternav_icons/ternav_icons.dart';
import '../../login/logout.dart';
import '../main_screen.dart';
import 'calender1.dart';
import 'chat_box.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              child: Image.asset('images/app.png'),
            ),
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.home_2,
            title: "Home",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.menu,
            title: "Calender",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventCalendarScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.chat,
            title: "Chat Box",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Basic(),
                ),
              );
            },
          ),
          DrawerListTile(
            icon: TernavIcons.lightOutline.settings,
            title: "Settings",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogOut(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            "images/help.png",
            height: 150,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 18,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
