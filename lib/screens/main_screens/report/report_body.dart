import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';

// Variabel Const dari kalori-kalori
const TWO_PI = 3.14 * 2;
const targetKalori = 2200;
const sisaKalori = 1800;
const makanKalori = 1500;
const percentageCircular = sisaKalori / targetKalori;
int sum = 0;
List<int> sumEatenCalorie = [];
List<int> tempEatenCalorie = [];
late List<String>? cumulativeDataLabel;
late List<ChartData> chartData;

class ReportBody extends StatefulWidget {
  const ReportBody({Key? key}) : super(key: key);

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  @override
  void initState() {
    for (int i = 0; i < stringDateTime.length; i++) {
      sum = eatenCalorie.sum;
      sumEatenCalorie.add(sum);
    }
    chartData = <ChartData>[
      for (int i = 0; i < stringDateTime.length; i++)
        ChartData(stringDateTime[i], sumEatenCalorie[i]),
    ];
    // cumulativeDataLabel = dataLabel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Mendefinisikan Controller, Size, dan Listlist
    final controllerPage = PageController(initialPage: 0);
    const sizeContainer = 185.0;

    @override
    void dispose() {
      controllerPage.dispose();
    }

    // _remove(List mylist, int index) {
    //   if (mylist[index] = mylist[mylist.length-1]) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }

    return PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: controllerPage,
        itemCount: dateTime.length,
        itemBuilder: (context, position) {
          return SingleChildScrollView(
            //** LEBAR KESELURUHAN KONTAINER BODY */
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //** PREVIOUS BUTTON, TEXT, NEXT BUTTON */
                      Visibility(
                        visible: true,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        maintainInteractivity: true,
                        child: IconButton(
                            onPressed: () => controllerPage.previousPage(
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeInOut),
                            icon: Icon(Icons.keyboard_arrow_left),
                            iconSize: 50,
                            color: Styles.mainBlueColor),
                      ),
                      Text(
                        stringDateTime[position],
                        style: Styles.shareFont3,
                      ),
                      IconButton(
                          onPressed: () => controllerPage.nextPage(
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeInOut),
                          icon: Icon(Icons.keyboard_arrow_right),
                          iconSize: 50,
                          color: Styles.mainBlueColor),
                    ],
                  ),

                  //** CONTAINER KALORI MINGGUAN DAN CHART */
                  Container(
                    height: 550,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(
                              0.0,
                              3.0,
                            ),
                            blurRadius: 6.0,
                            spreadRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kalori hari ini",
                                style: Styles.outfitText1,
                              ),
                              Text("$makanKalori", style: Styles.outfitText2),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Container(
                                    width: 1200,
                                    height: 400,
                                    child: SfCartesianChart(
                                        // annotations: getAnnotation(),
                                        primaryXAxis: CategoryAxis(
                                          title: AxisTitle(text: 'Hari')
                                        ),
                                        primaryYAxis: NumericAxis(
                                          title: AxisTitle(text: 'kkal')
                                        ),
                                        series: <ChartSeries>[
                                          ColumnSeries<ChartData, String>(
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true,
                                                      labelAlignment:
                                                          ChartDataLabelAlignment
                                                              .middle),
                                              dataSource: chartData,
                                              xValueMapper: (ChartData data, _) =>
                                                  data.x,
                                              yValueMapper: (ChartData data, _) =>
                                                  data.y1),
                                          // StackedColumnSeries<ChartData, String>(
                                          //     dataLabelSettings:
                                          //         const DataLabelSettings(
                                          //             isVisible: true,
                                          //             labelAlignment:
                                          //                 ChartDataLabelAlignment
                                          //                     .middle),
                                          //     dataSource: chartData,
                                          //     xValueMapper: (ChartData data, _) =>
                                          //         data.x,
                                          //     yValueMapper: (ChartData data, _) =>
                                          //         data.y2),
                                          // StackedColumnSeries<ChartData, String>(
                                          //     dataLabelSettings:
                                          //         const DataLabelSettings(
                                          //             isVisible: true,
                                          //             labelAlignment:
                                          //                 ChartDataLabelAlignment
                                          //                     .middle),
                                          //     dataSource: chartData,
                                          //     xValueMapper: (ChartData data, _) =>
                                          //         data.x,
                                          //     yValueMapper: (ChartData data, _) =>
                                          //         data.y3),
                                        ]),
                                  ),
                                  
                                ),
                              ),
                              Text(
                                "Rata-rata kalori minggu ini",
                                style: Styles.outfitText1,
                              ),
                              Text("$makanKalori", style: Styles.outfitText2),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

int totalData = 10;
DateTime today = DateTime.now();
List<String> time = ["08.10", "12.30", "18.23"];
List<DateTime> dateTime = [
  for (int i = 0; i < totalData; i++) today.add(Duration(days: i)),
];
List<String> stringDateTime = [
  for (int i = 0; i < dateTime.length; i++)
    DateFormat.yMMMEd().format(dateTime[i]),
];

List<int> eatenCalorie = [700, 1200, 300];

// List<String> dataLabel() {
//   List<String> labels = [];
//   for (int i = 0; i < chartData.length; i++) {
//     labels
//         .add((chartData[i].y1 + chartData[i].y2 + chartData[i].y3).toString());
//   }
//   return labels;
// }

// // Method to return list of CartesianChartAnnotation
// List<CartesianChartAnnotation> getAnnotation() {
//   cumulativeDataLabel = dataLabel();
//   const int padding = 120;
//   final List<CartesianChartAnnotation> annotations = [];
//   for (int i = 0; i < cumulativeDataLabel!.length; i++) {
//     annotations.add(CartesianChartAnnotation(
//         widget: Text(cumulativeDataLabel![i]),
//         coordinateUnit: CoordinateUnit.point,
//         x: chartData[i].x,
//         y: int.parse(cumulativeDataLabel![i]) + padding));
//   }
//   return annotations;
// }

class ChartData {
  ChartData(this.x, this.y1);
  final String x;
  final int y1;
}

// class ChartData {
//   ChartData(this.x, this.y1, this.y2, this.y3);
//   final String x;
//   final int y1;
//   final int y2;
//   final int y3;
// }
