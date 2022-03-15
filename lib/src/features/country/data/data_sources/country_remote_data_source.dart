import 'dart:convert';
import 'package:covid_tracker/src/features/country/data/models/country_model.dart';
import 'package:covid_tracker/src/features/country/data/models/country_stat_model.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/src/core/error/exceptions.dart';

abstract class CountryRemoteDataSource {
  /// Calls the https://api.covid19api.com/total/dayone/country/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CountryStatModel>> getCountryStat(String slug);

  /// Calls the https://api.covid19api.com/countries endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CountryModel>> getCountryList();
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final http.Client client;

  CountryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CountryStatModel>> getCountryStat(String slug) async =>
      _getCountryStatFromUrl(
          'https://api.covid19api.com/total/dayone/country/$slug');

  @override
  Future<List<CountryModel>> getCountryList() async =>
      _getCountryListFromUrl('https://api.covid19api.com/countries');

  Future<List<CountryStatModel>> _getCountryStatFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((countryStat) => CountryStatModel.fromJson(countryStat))
          .toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<CountryModel>> _getCountryListFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((country) => CountryModel.fromJson(country))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
