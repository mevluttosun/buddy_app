import 'package:buddy/common/utils/string_utils.dart';
import 'package:buddy/common/widgets/animated_dialog.dart';
import 'package:buddy/config/theme/app_theme.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/widgets/cached_breed_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buddy/common/widgets/default_spacer.dart';

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
          verticalSpacer,
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
          verticalSpacer,
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDialog(
                      animationType: DialogAnimationType.slide,
                      contentPadding: const EdgeInsets.all(0),
                      content: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                              future: context
                                  .read<RemoteDogBloc>()
                                  .getDogImageUrlByBreeds(breed.breedName!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      child: CachedBreedImageWidget(
                                          imageUrl: snapshot.data as String));
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.cancel,
                          size: 32,
                          color: Colors.white,
                        )),
                  ],
                ),
              );
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPaddingValue),
              width: size.width * 0.7,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultBorderRadiusValue),
                color: theme.primaryColor,
              ),
              child: Text(
                'Generate',
                style:
                    theme.textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
            ),
          ),
          verticalSpacer,
        ],
      ),
    );
  }
}
