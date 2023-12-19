import 'package:auto_route/annotations.dart';
import 'package:basic_platform_service/basic_platform_service.dart';
import 'package:buddy/common/utils/string_utils.dart';
import 'package:buddy/core/constants/constants.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:buddy/features/dog/presentation/widgets/animated_dialog.dart';
import 'package:buddy/features/dog/presentation/widgets/search_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class DogBreedView extends StatelessWidget {
  const DogBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteDogBloc, RemoteDogState>(
      builder: (context, state) {
        if (state is RemoteDogInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RemoteDogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RemoteDogLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return BreedWidget(
                      breedName: state.data[index].breedName?.capitalize(),
                      imageUrl: state.data[index].breedImage,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              BreedDetailWidget(breed: state.data[index]),
                        );
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SearchWidget(
                    onSearch: (value) {
                      context.read<RemoteDogBloc>().add(RemoteDogSearch(value));
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is RemoteDogError) {
          return Center(
            child: Text(state.message.message ?? "Something went wrong"),
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Find Your Buddy'),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        SvgPicture.asset(
          'assets/images/tab.svg',
          fit: BoxFit.fitWidth,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/home_icon.svg',
                  ),
                  const Text('Home',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: Color(0xFF0055D3))),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
              child: VerticalDivider(
                color: Color(0xFFD1D1D6),
                thickness: 2,
                width: 1,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
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
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data ?? "");
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                          ],
                        ));
              },
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/settings_icon.svg',
                  ),
                  const Text('Settings',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//TODO!!! Constants must be refactor by theme. Sorry If I don't have time to do it.
class BreedDetailWidget extends StatelessWidget {
  const BreedDetailWidget({
    super.key,
    required this.breed,
  });
  final DogBreedEntity breed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return AnimatedDialog(
      animationType: DialogAnimationType.slide,
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: CachedBreedImageWidget(imageUrl: breed.breedImage)),
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.cancel,
                        size: 32,
                        color: Colors.white,
                      ))),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Breed",
            style:
                theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Divider(
              color: theme.disabledColor,
              thickness: 2,
              height: 32,
            ),
          ),
          Text(breed.breedName?.capitalize() ?? "Unknown",
              style: theme.textTheme.titleMedium!),
          const SizedBox(height: 16),
          Text(
            "Sub Breed",
            style:
                theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Divider(
              color: theme.disabledColor,
              thickness: 2,
              height: 32,
            ),
          ),
          ...breed.subBreeds!
              .map((e) => Text(e?.capitalize() ?? "Unknown"))
              .toList(),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: size.width * 0.7,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.primaryColor,
              ),
              child: Text(
                'Generate',
                style:
                    theme.textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

Future<String> getOSVersion() async {
  BasicPlatformService basicPlatformService = BasicPlatformService();
  String? osVersion = await basicPlatformService.getPlatformVersion();

  return osVersion ?? "";
}

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
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 28,
          ),
          title: Text(settingsTitle),
          onTap: () => Navigator.pop(context),
          trailing: const Icon(
            Icons.arrow_outward,
            color: Color(0xFFC7C7CC),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(
            color: Color(0xFFE5E5EA),
            thickness: 2,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class BreedWidget extends StatelessWidget {
  final String? imageUrl;
  final String? breedName;
  final Function? onTap;
  const BreedWidget({
    super.key,
    this.imageUrl,
    this.breedName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
        onTap: onTap as void Function()?,
        child: GridTile(
            footer: Container(
              // cut minimum text and border only top right
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                ),
                color: Colors.transparent.withOpacity(0.24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  breedName ?? "Unknown",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            child: CachedBreedImageWidget(imageUrl: imageUrl))

        // Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     Expanded(
        //       child: CachedNetworkImage(
        //         imageUrl: imageUrl ?? kDefaultImage,
        //         imageBuilder: (context, imageProvider) => Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             color: theme.disabledColor,
        //             image:
        //                 DecorationImage(image: imageProvider, fit: BoxFit.cover),
        //           ),
        //           width: size.width * 0.45,
        //           height: size.width * 0.45,
        //         ),
        //         progressIndicatorBuilder: (context, url, downloadProgress) =>
        //             Container(
        //           width: size.width * 0.45,
        //           height: size.width * 0.45,
        //           decoration: BoxDecoration(
        //             color: theme.disabledColor,
        //           ),
        //           child: const CircularProgressIndicator(),
        //         ),
        //         errorWidget: (context, url, error) => Container(
        //           width: size.width * 0.45,
        //           height: size.width * 0.45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             color: theme.disabledColor,
        //           ),
        //           child: const Icon(Icons.error),
        //         ),
        //       ),
        //     ),
        //     Positioned(bottom: 0, left: 0, child: Text(breedName ?? "Unknown")),
        //   ],
        // ),
        );
  }
}

class CachedBreedImageWidget extends StatelessWidget {
  const CachedBreedImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return CachedNetworkImage(
      imageUrl: imageUrl ?? kDefaultImage,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: theme.disabledColor,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        width: size.width,
        height: size.width,
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        width: size.width,
        height: size.width,
        decoration: BoxDecoration(
          color: theme.disabledColor,
        ),
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        width: size.width,
        height: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: theme.disabledColor,
        ),
        child: const Icon(Icons.error),
      ),
    );
  }
}
