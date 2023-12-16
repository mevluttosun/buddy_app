import 'package:auto_route/auto_route.dart';
import 'package:buddy/config/routes/app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: DogBreedRoute.page,
          initial: true,
        ),
      ];
}
