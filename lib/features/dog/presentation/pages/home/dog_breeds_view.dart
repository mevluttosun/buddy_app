import 'package:auto_route/annotations.dart';
import 'package:buddy/common/utils/string_utils.dart';
import 'package:buddy/core/constants/constants.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
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
      bottomNavigationBar: _buildBottomNavigationBar(),
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

  Widget _buildBottomNavigationBar() {
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
                  const Text('Home', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
              child: VerticalDivider(
                color: Colors.blue,
                thickness: 2,
                width: 1,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/settings_icon.svg',
                  ),
                  const Text('Home', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ],
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
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? kDefaultImage,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.disabledColor,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
                width: size.width,
                height: size.width,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
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
            ))

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
