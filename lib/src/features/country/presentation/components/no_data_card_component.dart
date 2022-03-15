import 'package:flutter/material.dart';

class NoDataCard extends StatelessWidget {
  const NoDataCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: const [
          Center(
              child: Icon(
            Icons.error,
            color: Colors.red,
            size: 100,
          )),
          Text("Aucune donnée disponible pour ce pays")
        ],
      ),
    );
  }
}
