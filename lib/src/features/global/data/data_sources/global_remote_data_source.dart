import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/src/core/error/exceptions.dart';
import 'package:covid_tracker/src/features/global/data/models/global_stat_model.dart';

abstract class GlobalRemoteDataSource {
  /// Calls the https://api.covid19api.com/summary endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<GlobalStatModel> getGlobalStat();
}

class GlobalRemoteDataSourceImpl implements GlobalRemoteDataSource {
  final http.Client client;

  GlobalRemoteDataSourceImpl({required this.client});

  @override
  Future<GlobalStatModel> getGlobalStat() async =>
      _getGlobalStatFromUrl('https://api.covid19api.com/summary');

  Future<GlobalStatModel> _getGlobalStatFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return GlobalStatModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
