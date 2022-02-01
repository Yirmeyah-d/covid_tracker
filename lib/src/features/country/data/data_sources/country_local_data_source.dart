import 'dart:convert';

import 'package:covid_tracker/src/core/error/exceptions.dart';
import 'package:covid_tracker/src/features/country/data/models/country_model.dart';
import 'package:covid_tracker/src/features/country/data/models/country_stat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CountryLocalDataSource {
  /// Gets the cached [CountryStatModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<CountryStatModel>> getLastCountryStat();

  Future<void> cacheCountryStat(List<CountryStatModel> countryStatToCache);

  Future<List<CountryModel>> getLastCountryList();

  Future<void> cacheCountryList(List<CountryModel> countryListToCache);
}

const CACHED_COUNTRY_STAT = 'CACHED_COUNTRY_STAT';

const CACHED_COUNTRY_LIST = 'CACHED_COUNTRY_LIST';

class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CountryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CountryStatModel>> getLastCountryStat() {
    final jsonCountryStatList =
        sharedPreferences.getStringList(CACHED_COUNTRY_STAT);
    if (jsonCountryStatList != null) {
      return Future.value(jsonCountryStatList
          .map((countryStat) =>
              CountryStatModel.fromJson(jsonDecode(countryStat)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCountryStat(List<CountryStatModel> countryStatToCache) {
    List<String> countryStatEncoded = countryStatToCache
        .map((countryStat) => jsonEncode(countryStat.toJson()))
        .toList();
    return sharedPreferences.setStringList(
      CACHED_COUNTRY_STAT,
      countryStatEncoded,
    );
  }

  @override
  Future<List<CountryModel>> getLastCountryList() {
    final jsonCountryList =
        sharedPreferences.getStringList(CACHED_COUNTRY_LIST);
    if (jsonCountryList != null) {
      return Future.value(jsonCountryList
          .map((country) => CountryModel.fromJson(jsonDecode(country)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCountryList(List<CountryModel> countryListToCache) {
    List<String> countryListEncoded = countryListToCache
        .map((country) => jsonEncode(country.toJson()))
        .toList();

    return sharedPreferences.setStringList(
      CACHED_COUNTRY_LIST,
      countryListEncoded,
    );
  }
}
