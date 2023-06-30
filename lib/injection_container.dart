import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';


final sl = GetIt.I;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc



  // Use cases


  // Repository


  // Data sources


  //region core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //endregion

  // External
  sl.registerLazySingleton(() => http.Client());
  //sl.registerSingleton(() => SharedPreferences.getInstance());
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPref);
}
