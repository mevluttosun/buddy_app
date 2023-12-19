import 'package:buddy/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SettingsTileWidget extends StatelessWidget {
  final IconData icon;
  final String settingsTitle;
  const SettingsTileWidget({
    super.key,
    required this.icon,
    required this.settingsTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 28,
          ),
          title: Text(settingsTitle),
          onTap: () => Navigator.pop(context),
          trailing: Icon(
            Icons.arrow_outward,
            color: theme.hintColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingValue),
          child: Divider(
            color: theme.dividerColor,
            thickness: 2,
            height: 1,
          ),
        ),
      ],
    );
  }
}
