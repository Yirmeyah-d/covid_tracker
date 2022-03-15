import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalDashboardLoading extends StatelessWidget {
  const GlobalDashboardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loadingCard(),
        loadingCard(),
        loadingCard(),
        loadingCard(),
        loadingLabel(),
      ],
    );
  }

  Widget loadingCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingLabel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.blue[300]!,
        highlightColor: Colors.blue[600]!,
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              height: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
