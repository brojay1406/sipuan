import 'package:flutter/material.dart';

class IconsMenu {
  static const items = <IconMenu>[
    ProfilButton,
    Logout,
  ];

  static const ProfilButton = IconMenu(
    text: 'Profil',
    icon: Icons.people_alt,
  );

  static const Logout = IconMenu(
    text: 'Logout',
    icon: Icons.logout,
  );
}

class IconMenu {
  final String text;
  final IconData icon;

  const IconMenu({
    required this.text,
    required this.icon,
  });
}
