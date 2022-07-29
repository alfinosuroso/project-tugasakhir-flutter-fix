import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/model/catatan_model.dart';
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
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
List<ChartData>? barChartData;
double totalKaloriMasuk = 0;
double tambahanWidth = 0;

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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    final controllerPage = PageController(initialPage: 0);
    barChartData = [];
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
            } else if (data!.isNotEmpty &&
                snapshot.connectionState == ConnectionState.done) {
              print("halo 1");
              print(barChartData?.length);

              return PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controllerPage,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    print("halo 2");
                    print(barChartData?.length);

                    for (int i = 0; i < data.length; i++) {
                      print("i = " + i.toString());
                      for (int j = 0; j < data[i].catatan!.length; j++) {
                        print("j = " + j.toString());
                        var dataCatatan = data[i].catatan?[j];
                        totalKaloriMasuk =
                            totalKaloriMasuk + dataCatatan!.kaloriMasuk!;
                        if (data[i].catatan?.length == j + 1) {
                          String finalTanggal =
                              DateFormat('EEEE, d MMMM').format(data[i].date!);
                          barChartData!
                              .add(ChartData(finalTanggal, totalKaloriMasuk));
                          print(totalKaloriMasuk);
                          totalKaloriMasuk = 0;
                          tambahanWidth += (70);
                        }
                      }
                    }

                    return SingleChildScrollView(
                      //** LEBAR KESELURUHAN KONTAINER BODY */
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //** LAPORAN KALORI HARIAN KESELURUHAN */
                            Text(
                                  "LAPORAN KALORI MASUK KESELURUHAN",
                                  style: Styles.shareFont3,
                                ),

                            SizedBox(
                              height: 20,
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
                                          "Target kalori hari ini",
                                          style: Styles.outfitText1,
                                        ),
                                        Text('${user?.kaloriHarian}',
                                            style: Styles.outfitText2),
                                        // 7 Barchart
                                        SingleChildScrollView(
                                          // scrollDirection: Axis.horizontal,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Container(
                                              width: 100 + tambahanWidth,
                                              height: 400,
                                              child: SfCartesianChart(
                                                  enableAxisAnimation: true,
                                                  primaryXAxis: 
                                                  CategoryAxis(                                                    
                                                      title: AxisTitle(
                                                          text: 'Hari')),
                                                  primaryYAxis: NumericAxis(
                                                    anchorRangeToVisiblePoints: false,
                                                      title: 
                                                      AxisTitle(
                                                          text: 'kal',
                                                          alignment: ChartAlignment.far)),
                                                  series: <ChartSeries>[
                                                    ColumnSeries<ChartData,
                                                            String>(
                                                        dataLabelSettings:
                                                            DataLabelSettings(
                                                                isVisible: true,
                                                                labelAlignment:
                                                                    ChartDataLabelAlignment
                                                                        .middle),
                                                        dataSource:
                                                            barChartData!,
                                                        xValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.x,
                                                        yValueMapper:
                                                            (ChartData data,
                                                                    _) =>
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
            }
            return const Center(
              child: Text(
                  "Hitung kalori sekarang dengan cara menekan tombol plus dibawah!"),
            );
          }),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y1);
  final String x;
  final double y1;
}
