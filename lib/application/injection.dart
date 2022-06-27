import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> inject() async {
  getIt.registerSingleton<FavoritesRepo>(
    FavoritesRepoFirebase(),
  );

  getIt.registerSingleton<FlightsRepo>(
    FlightsRepoFirebase(),
  );
}
