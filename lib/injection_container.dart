import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/home/data/data_sources/weather_remote_date_source.dart';
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/home/domain/use_cases/get_city_location.dart';
import 'package:weather_app/features/home/domain/use_cases/get_current_weather.dart';
import 'package:weather_app/features/home/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:weather_app/features/home/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'core/network/network_info.dart';
import 'core/services/location_service.dart';
import 'features/home/data/repositories/weather_repository_impl.dart';
import 'features/home/presentation/bloc/city_bloc/city_bloc.dart';


final sl = GetIt.I;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() => LocationBloc(sl()));
  sl.registerFactory(() => WeatherBloc(sl()));
  sl.registerFactory(() => CityBloc(sl()));



  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetCityLocation(sl()));


  // Repository
  sl.registerLazySingleton<WeatherRepository>(
          () => WeatherRepositoryImpl(sl(), sl()));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
          () => WeatherRemoteDataSourceImpl(sl()));

  //region core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<AppLocation>(() => AppLocationImpl(sl()));

  //endregion

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPref);
}
