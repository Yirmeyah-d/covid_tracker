import 'package:covid_tracker/src/features/country/domain/entities/country.dart';
import 'package:covid_tracker/src/features/country/presentation/bloc/country_bloc.dart';
import 'package:covid_tracker/src/features/country/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  initState() {
    super.initState();
    _typeAheadController.text = "United States of America";
    BlocProvider.of<CountryBloc>(context)
        .add(const GetCountryStatEvent(slug: "united-states"));
  }

  List<String> _getSuggestions(List<Country>? countryList, String query) {
    List<String> matches = [];

    for (var item in countryList!) {
      matches.add(item.country);
    }

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(builder: (context, state) {
      if (state is CountryError) {
        return const Center(
          child: Text("Error"),
        );
      } else if (state is CountryLoading) {
        return const CountryDashboardLoading(inputTextLoading: true);
      } else if (state is CountryLoaded) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Text(
                  "Entrée le nom du pays",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _typeAheadController,
                  decoration: InputDecoration(
                    hintText: 'Type here country name',
                    hintStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.all(20),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 24.0, right: 16.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return _getSuggestions(state.countryList, pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion as String),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  _typeAheadController.text = suggestion as String;
                  setState(() {
                    String slug = state.countryList
                        .firstWhere((element) => element.country == suggestion)
                        .slug;
                    BlocProvider.of<CountryBloc>(context)
                        .add(GetCountryStatEvent(slug: slug));
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<CountryBloc, CountryState>(builder: (context, state) {
                if (state is CountryError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else if (state is CountryLoading) {
                  return const CountryDashboardLoading(inputTextLoading: false);
                } else if (state is CountryLoaded) {
                  if (state.countryStat.isNotEmpty) {
                    return CountryDashboard(countryStat: state.countryStat);
                  } else {
                    return NoDataCard();
                  }
                } else {
                  return const CountryDashboardLoading(inputTextLoading: false);
                }
              }),
            ],
          ),
        );
      } else {
        return const CountryDashboardLoading(inputTextLoading: true);
      }
    });
  }
}
