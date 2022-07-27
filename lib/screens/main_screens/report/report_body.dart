import 'package:flutter/material.dart';
import 'package:tugasakhir_app/model/catatan_model.dart';
import 'package:tugasakhir_app/services/api_catatan_service.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';

// Variabel Const dari kalori-kalori
const TWO_PI = 3.14 * 2;
const makanKalori = 1500;
int sum = 0;
late List<String>? cumulativeDataLabel;
List<ChartData>? chartData;
List<ChartData>? dataku;
double totalKaloriMasuk = 0;
int week = 1;

class ReportBody extends StatefulWidget {
  const ReportBody({Key? key}) : super(key: key);

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  final CatatanApiService _catatanModel = CatatanApiService();

  @override
  Widget build(BuildContext context) {
    // Mendefinisikan Controller, Size, dan Listlist
    final controllerPage = PageController(initialPage: 0);
    dataku = [];
    // dataku?.add(ChartData("Tanggal sekarang", 2));

    @override
    void dispose() {
      controllerPage.dispose();
    }

    return Scaffold(
      backgroundColor: Styles.bgMainColor,
      body: FutureBuilder<List<Datum>>(
          future: _catatanModel.getCatatanModel(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return const Center(
                child: Text(
                    "Hitung kalori sekarang dengan cara menekan tombol plus dibawah!"),
              );
            }
            return PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: controllerPage,
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  int indexPlusSatu = index + 1;
                  // print(dataku?[0].y1);
                  print(dataku?.length);
                  print(indexPlusSatu);

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
                                    onPressed: () =>
                                        controllerPage.animateToPage(index - 7,
                                            duration: const Duration(
                                                milliseconds: 700),
                                            curve: Curves.easeInOut),
                                    icon: Icon(Icons.keyboard_arrow_left),
                                    iconSize: 50,
                                    color: Styles.mainBlueColor),
                              ),
                              Text(
                                "Minggu ke-$week",
                                style: Styles.shareFont3,
                              ),
                              IconButton(
                                  onPressed: () => controllerPage.animateToPage(
                                      index + 7,
                                      duration:
                                          const Duration(milliseconds: 700),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kalori hari ini",
                                        style: Styles.outfitText1,
                                      ),
                                      Text("$makanKalori",
                                          style: Styles.outfitText2),
                                      // 7 Barchart
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Container(
                                            width: 1200,
                                            height: 400,
                                            child: SfCartesianChart(
                                                // annotations: getAnnotation(),
                                                primaryXAxis: CategoryAxis(
                                                    title: AxisTitle(
                                                        text: 'Hari')),
                                                primaryYAxis: NumericAxis(
                                                    title:
                                                        AxisTitle(text: 'kal')),
                                                series: <ChartSeries>[
                                                  ColumnSeries<ChartData,
                                                          String>(
                                                      dataLabelSettings:
                                                          DataLabelSettings(
                                                              isVisible: true,
                                                              labelAlignment:
                                                                  ChartDataLabelAlignment
                                                                      .middle),
                                                      dataSource: dataku!,
                                                      xValueMapper:
                                                          (ChartData data, _) =>
                                                              data.x,
                                                      yValueMapper:
                                                          (ChartData data, _) =>
                                                              data.y1),
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Rata-rata kalori minggu ini",
                                        style: Styles.outfitText1,
                                      ),
                                      Text("$makanKalori",
                                          style: Styles.outfitText2),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y1);
  final String x;
  final double y1;
}
