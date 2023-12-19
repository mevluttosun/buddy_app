import 'package:auto_route/annotations.dart';
import 'package:buddy/common/utils/string_utils.dart';
import 'package:buddy/config/theme/app_theme.dart';
import 'package:buddy/core/constants/asset_paths.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:buddy/features/dog/presentation/widgets/breed_detail_widget.dart';
import 'package:buddy/features/dog/presentation/widgets/breed_widget.dart';
import 'package:buddy/features/dog/presentation/widgets/search_widget.dart';
import 'package:buddy/features/dog/presentation/widgets/settings_bottom_modal_widget.dart';
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
                    crossAxisSpacing: kDefaultPaddingValue,
                    mainAxisSpacing: kDefaultPaddingValue,
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
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        SvgPicture.asset(
          kBottomNavigationAsset,
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
                    kHomeIconAsset,
                  ),
                  Text(
                    'Home',
                    style: theme.textTheme.labelSmall!
                        .copyWith(color: theme.primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
              child: VerticalDivider(
                color: theme.dividerColor,
                thickness: 2,
                width: 1,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const SettingsBottomModalWidget());
              },
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    kSettingsAsset,
                  ),
                  Text('Settings', style: theme.textTheme.labelSmall!),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
