import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/home/data/data_sources/weather_remote_date_source.dart';
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/home/domain/use_cases/get_current_weather.dart';
import 'package:weather_app/features/home/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:weather_app/features/home/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'core/network/network_info.dart';
import 'core/services/location_service.dart';
import 'features/home/data/repositories/weather_repository_impl.dart';


final sl = GetIt.I;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() => LocationBloc(sl()));
  sl.registerFactory(() => WeatherBloc(sl()));



  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));


  // Repository
  sl.registerLazySingleton<WeatherRepository>(
          () => WeatherRepositoryImpl(sl(), sl()));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
          () => WeatherRemoteDataSourceImpl(sl()));

  //region core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //endregion

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<AppLocation>(() => AppLocationImpl(sl()));
  //sl.registerSingleton(() => SharedPreferences.getInstance());
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPref);
}
