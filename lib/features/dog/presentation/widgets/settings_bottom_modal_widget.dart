import 'package:basic_platform_service/basic_platform_service.dart';
import 'package:buddy/common/widgets/default_spacer.dart';
import 'package:buddy/features/dog/presentation/widgets/settings_tile_widget.dart';
import 'package:flutter/material.dart';

class SettingsBottomModalWidget extends StatelessWidget {
  const SettingsBottomModalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        verticalSpacer,
        verticalSpacer,
        const SettingsTileWidget(
          icon: Icons.info_outline,
          settingsTitle: 'About',
        ),
        const SettingsTileWidget(
          icon: Icons.star_border_outlined,
          settingsTitle: 'Rate Us',
        ),
        const SettingsTileWidget(
          icon: Icons.ios_share_outlined,
          settingsTitle: 'Share with Friends',
        ),
        const SettingsTileWidget(
          icon: Icons.sticky_note_2_outlined,
          settingsTitle: 'Terms of Use',
        ),
        const SettingsTileWidget(
          icon: Icons.privacy_tip_outlined,
          settingsTitle: 'Privacy Policy',
        ),
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text('OS Version'),
          trailing: FutureBuilder(
            future: getOSVersion(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data ?? "");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}

Future<String> getOSVersion() async {
  BasicPlatformService basicPlatformService = BasicPlatformService();
  String? osVersion = await basicPlatformService.getPlatformVersion();

  return osVersion ?? "";
}
