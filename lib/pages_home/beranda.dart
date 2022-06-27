import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 160.0, // Set this height
          backgroundColor: Colors.transparent,
          elevation: 0,

          flexibleSpace: Container(
            height: 200.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 80.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 1.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                              // _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 200),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 200),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                
                onPressed: () {},
                child: Icon(Icons.plus_one),
              ),
            ),
          ],
        ));
  }
}


// Text("HOLAAA", style: TextStyle(fontSize: 100),),