import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:tugasakhir_app/styles.dart';

class BantuanPage extends StatefulWidget {
  @override
  State createState() {
    return BantuanPageState();
  }
}

class BantuanPageState extends State<BantuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bantuan",
          style: Styles.shareTitleAppbarText13,
        ),
        backgroundColor: Styles.appBarPrimaryColor,
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Card2(),
            Card1(),
            Card3(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

const loremIpsum =
    "Alfino Almero Suroso dan Primafadhil Sulistyo";

const descSpoonycal =
    "Spoonycal dirancang untuk membantu mengontrol pola makan masyarakat guna mencegah tidak terkontrolnya asupan kalori yang masuk. Didukung dengan alat berbasis Internet of Things dan dukungan deteksi makanan mempermudah pengguna untuk menghitung kalori yang ada pada makanan.";

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "TENTANG SPOONYCAL",
                      style: Styles.shareFontProfile11_2,
                    )),
                collapsed: const Text(
                  descSpoonycal,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.shareFont7_2,
                  textAlign: TextAlign.justify,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            descSpoonycal,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: Styles.shareFont7_2,
                            textAlign: TextAlign.justify,
                          )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildImg(String image, double height) {
      return SizedBox(
          height: height,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ));
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "HUBUNGI KAMI",
                    style: Styles.shareFontProfile11_2,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg('assets/images/logo-foreground.png', 300);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Developer Team : MOTIVASEE",
                    style: Styles.shareFontProfileText12,
                  ),
                  Text(
                    "Email : motivasee@spoonycal.com",
                    style: Styles.shareFontProfileText12_2,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: buildImg('assets/images/fino.jpg', 250)),
              Expanded(child: buildImg('assets/images/fadhil.jpg', 250)),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              loremIpsum,
              softWrap: true,
              style: Styles.shareFont7_2,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expandable(
                collapsed: buildCollapsed1(),
                expanded: buildExpanded1(),
              ),
              Expandable(
                collapsed: buildCollapsed2(),
                expanded: buildExpanded2(),
              ),
              Expandable(
                collapsed: buildCollapsed3(),
                expanded: buildExpanded3(),
              ),
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      var controller =
                          ExpandableController.of(context, required: true)!;
                      return TextButton(
                        child: Text(
                          controller.expanded ? "TUTUP" : "BUKA LEBIH LANJUT",
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.deepPurple),
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label, style: Styles.shareFont7_2, textAlign: TextAlign.justify,),
      );
    }

    buildImg(String image, double height) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: SizedBox(
            height: height,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  // fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            )),
      );
    }

    buildImageKalori() {
      return buildImg('assets/images/perhitungan_kaloriharian.png', 80);
    }
    

    buildList() {
      return Column(
        children: <Widget>[
          buildItem("1.	Pengguna mendaftar untuk mendapatkan akses SPOONYCAL."),
          buildItem("2.	Memasukkan data diri guna mendapatkan kebutuhan kalori harian."),
          buildImageKalori(),
          buildItem("3.	Memilih fitur yang tersedia (Perhitungan dengan SPOONYCAL atau Deteksi Objek)."),
          buildItem("4.	Menyambungkan alat SPOONYCAL dengan aplikasi Spoonycal Mobile."),
          

        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: Styles.buttonAuthBg,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "INSTRUKSI PENGGUNAAN",
                            style: Styles.shareFont8_2
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
