# Find Your Buddy

![App Demo](assets/readme_assets/app_demo.gif)

This app, "Find Your Buddy," is designed to help you find your perfect furry friend. It utilizes the Dog API to provide a wide range of dog breeds and images.

## Features

- Browse through a variety of dog breeds
- View images of different dog breeds
- Search for specific dog breeds
- Generate random images about specific breeds

## Installation

1. Clone the repository: `git clone https://github.com/mevluttosun/buddy_app.git`
2. Navigate to the project directory: `cd buddy-app`
3. Install dependencies: `flutter pub get`
4. Start the app: `flutter run`
5. Start test of code `flutter test`

## Technologies Used

- Flutter 3.16.4
- Dog API (<https://dog.ceo/dog-api/>)

# Used Libraries

- flutter_bloc: Used as state management in Project.
- auto_route: Generates type-safe routing code for navigation.
- dio: HTTP client for making network requests.
- equatable: Simplifies equality comparisons and hash code generation for objects.
- cached_network_image: Caches network images locally to improve performance and reduce bandwidth usage.
- get_it: A simple service locator for dependency injection.
- flutter_svg:Renders SVG (Scalable Vector Graphics) images.
- modal_bottom_sheet: Provides customizable modal bottom sheets.
- basic_platform_service: A local package for basic platform services.
- flutter_native_splash: Generates native splash screens.

In the dev_dependencies section, the listed dependencies are used for development and testing purposes:

- flutter_test: The Flutter testing framework for writing unit tests.
- flutter_lints: Provides additional lint rules for analyzing.
- auto_route_generator: Generates code for the auto_route package to handle routing.
- build_runner: A build system for generating code.
- mockito: A mocking library for creating mock objects in unit tests.
- bloc_test: Provides utilities for testing BLoC components.
- mocktail: A mocking library.

## Folder Structure

```
└── 📁lib
    └── 📁common
        └── 📁utils
            └── string_utils.dart
        └── 📁widgets
            └── animated_dialog.dart
            └── 📁animations
                └── bounce_in_animation.dart
                └── fade_animation.dart
                └── slide_animation.dart
                └── slide_in_animation.dart
            └── default_spacer.dart
    └── 📁config
        └── 📁theme
            └── app_theme.dart
    └── 📁core
        └── app_dio.dart
        └── 📁constants
            └── asset_paths.dart
            └── constants.dart
        └── 📁resources
            └── data_state.dart
        └── 📁usecases
            └── usecase.dart
    └── 📁features
        └── 📁dog
            └── 📁data
                └── 📁data_sources
                    └── 📁remote
                        └── dog_api_service.dart
                        └── dog_api_service_impl.dart
                └── 📁models
                    └── dog_breed_model.dart
                └── 📁repository
                    └── dog_repository_impl.dart
            └── 📁domain
                └── 📁entities
                    └── dog_breeds_entity.dart
                └── 📁repository
                    └── dog_repository.dart
                └── 📁usecases
                    └── get_breeds_usecase.dart
                    └── get_random_image_by_breed_usecase.dart
            └── 📁presentation
                └── 📁bloc
                    └── 📁dog
                        └── 📁remote
                            └── remote_dog_bloc.dart
                            └── remote_dog_event.dart
                            └── remote_dog_state.dart
                └── 📁pages
                    └── 📁home
                        └── dog_breeds_view.dart
                └── 📁widgets
                    └── breed_detail_widget.dart
                    └── breed_widget.dart
                    └── cached_breed_image_widget.dart
                    └── search_widget.dart
                    └── settings_bottom_modal_widget.dart
                    └── settings_tile_widget.dart
    └── injection_container.dart
    └── main.dart
```

```
└── 📁test
    └── 📁features
        └── 📁dog
            └── 📁data
                └── 📁data_sources
                    └── 📁remote
                        └── dog_api_service_test.dart
                └── 📁models
                    └── dog_breed_model_test.dart
                └── 📁presentation
                    └── dog_repository_impl_test.dart
            └── 📁domain
                └── 📁usecases
                    └── get_breeds_usecase_test.dart
            └── 📁presentation
                └── 📁bloc
                    └── 📁dog
                        └── 📁remote
                            └── remote_dog_bloc_test.dart
                └── 📁pages
                    └── 📁home
                        └── dog_breeds_view_test.dart
                └── 📁widgets
                    └── search_widget_test.dart
    └── 📁helpers
        └── 📁dummy_data
            └── dog_breeds_list.dart
            └── dummy_breeds_response.json
        └── json_reader.dart
        └── test_helper.dart
        └── test_helper.mocks.dart
```
