import 'dart:convert';

import 'package:covid_tracker/src/core/error/exceptions.dart';
import 'package:covid_tracker/src/features/global/data/models/global_stat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GlobalLocalDataSource {
  /// Gets the cached [GlobalStatModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<GlobalStatModel> getLastGlobalStat();

  /// Add in the cache the [GlobalStatModel]
  ///
  Future<void> cacheGlobalStat(GlobalStatModel globalStatToCache);
}

const CACHED_GLOBAL_STAT = 'CACHED_GLOBAL_STAT';

class GlobalLocalDataSourceImpl implements GlobalLocalDataSource {
  final SharedPreferences sharedPreferences;

  GlobalLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<GlobalStatModel> getLastGlobalStat() {
    final jsonString = sharedPreferences.getString(CACHED_GLOBAL_STAT);
    if (jsonString != null) {
      return Future.value(GlobalStatModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheGlobalStat(GlobalStatModel globalStatToCache) {
    return sharedPreferences.setString(
      CACHED_GLOBAL_STAT,
      jsonEncode(globalStatToCache.toJson()),
    );
  }
}
