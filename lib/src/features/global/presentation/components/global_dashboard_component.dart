import 'package:covid_tracker/src/core/utils/regex.dart';
import 'package:covid_tracker/src/features/global/domain/entities/global_stat.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/styles/colors.dart';

class GlobalDashboard extends StatelessWidget {
  final GlobalStat globalStat;

  const GlobalDashboard({Key? key, required this.globalStat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildCard(
          "CONFIRMÉ",
          globalStat.totalConfirmed,
          globalStat.newConfirmed,
          kConfirmedColor,
        ),
        buildCard(
          "ACTIF",
          globalStat.totalConfirmed -
              globalStat.totalRecovered -
              globalStat.totalDeaths,
          globalStat.newConfirmed -
              globalStat.newRecovered -
              globalStat.newDeaths,
          kActiveColor,
        ),
        buildCard(
          "RÉTABLIE",
          globalStat.totalRecovered,
          globalStat.newRecovered,
          kRecoveredColor,
        ),
        buildCard(
          "MORT",
          globalStat.totalDeaths,
          globalStat.newDeaths,
          kDeathColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Statistiques mis à jours il y a " +
                timeago.format(globalStat.date),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color) {
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      totalCount.toString().replaceAllMapped(
                          reg, (Match match) => '${match[1]}.'),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      todayCount.toString().replaceAllMapped(
                          reg, (Match match) => '${match[1]}.'),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
