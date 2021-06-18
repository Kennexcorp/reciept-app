import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SalesChart(),
    );
  }
}

class SalesChart extends StatefulWidget {
  SalesChart({Key key}) : super(key: key);

  @override
  _SalesChartState createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            SfCartesianChart(
              title: ChartTitle(text: 'Daily sales overview'),
              series: <ChartSeries>[
                ColumnSeries<_SalesData, double>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.sales,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                )
              ],
            ),
            Text('Sales Per Item'),
            SfCartesianChart()
          ],
        ),
      )),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
