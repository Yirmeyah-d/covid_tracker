import 'package:covid_tracker/src/features/global/presentation/bloc/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/src/features/global/presentation/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalScreen extends StatefulWidget {
  const GlobalScreen({Key? key}) : super(key: key);

  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  @override
  void initState() {
    BlocProvider.of<GlobalBloc>(context).add(GetGlobalStatEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Cas Mondiaux de Covid-19",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      BlocProvider.of<GlobalBloc>(context)
                          .add(GetGlobalStatEvent());
                    });
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state) {
            if (state is GlobalLoading) {
              return GlobalDashboardLoading();
            } else if (state is GlobalLoaded) {
              return GlobalDashboard(
                globalStat: state.globalStat,
              );
            } else if (state is GlobalError) {
              return Center(child: Text(state.message));
            } else {
              return const GlobalDashboardLoading();
            }
          }),
        ]);
  }
}
