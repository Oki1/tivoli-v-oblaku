import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_tivoli/Menu/PictureViewer.dart';
import 'package:flutter/material.dart';
import '../Databases/RetriveDataFromSQL.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Navigation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class TreeInfo extends StatefulWidget {
  final int treeIndex;
  final LatLng m_pLocalPostion;
  
  const TreeInfo(this.treeIndex,this.m_pLocalPostion);

  @override
  _TreeInfoState createState() => _TreeInfoState();
  
}

class _TreeInfoState extends State<TreeInfo> {
  int fileCount;
  final getInfoFromDb = GetInfoFromDB.instance;
  
  Future<List> getFileCount(BuildContext context) async 
  {
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
      .where((String key) => key.contains("assets/tree_images/" + getInfoFromDb.kor[widget.treeIndex].idDrevesa)).toList();

    fileCount = imagePaths.length;
  }

  Widget buildImageCarousel() {
    return CarouselSlider.builder(
      itemCount: fileCount, 
      itemBuilder: (BuildContext context, int index) {
        return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                child: GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PictureViewer(index, "assets/tree_images/" + getInfoFromDb.kor[widget.treeIndex].idDrevesa + "/" + index.toString() + ".jpg", getInfoFromDb.kor[widget.treeIndex].name)),
                    ),
                child: Image(image:AssetImage("assets/tree_images/" + getInfoFromDb.kor[widget.treeIndex].idDrevesa + "/" + index.toString() + ".jpg"), fit: BoxFit.fitHeight)),
            );
          },
        );
      }, 
      options: CarouselOptions(height: 400.0, 
          autoPlay: false, 
          viewportFraction: 0.5,
          enlargeCenterPage: true,
          autoPlayInterval: Duration(seconds: 5),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFileCount(context),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return Container();
        }
        else 
        {
          return Scaffold(
              appBar: PreferredSize (
                preferredSize: Size.fromHeight(250.0), 
                child: AppBar(
                flexibleSpace: buildImageCarousel(),
                backgroundColor: Colors.white60,
                
              ),
              ),
              body: Column(children: <Widget>[  
                _tabSection(context, widget.treeIndex, widget.m_pLocalPostion),
              ]),
            );
          }
      }
    );
  }
}
/*FlatButton( 
    onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => Navigation(m_pLocalPos, LatLng(getInfoFromDb.kor[treeIndex].lat,getInfoFromDb.kor[treeIndex].long)))), 
    child: Text("Kilikni me")),*/

TextStyle tabStyle = new TextStyle(color: Colors.grey);
TextStyle m_pHeading = new TextStyle(fontSize: 22);
TextStyle m_pText = new TextStyle(fontSize: 16);

Widget _tabSection(BuildContext context, int treeIndex, LatLng m_pLocalPos) {
    final getInfoFromDb = GetInfoFromDB.instance;
  return DefaultTabController(
    length: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: TabBar(tabs: [
            Tab(text: "Splošno"),
            Tab(text: "O drevesu"),
            Tab(text: "Zanimivost"),
          ], labelColor: Colors.grey,),
        ),
        Container( 
          height: 343,
          alignment: Alignment.topLeft,
          child: TabBarView(children: [
            Container( 
              child: SingleChildScrollView(
                child: Container(
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: <Widget>[
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ 
                          Text("Ime: ", style: m_pText,),
                          Text(getInfoFromDb.kor[treeIndex].name)
                        ]
                      ),
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ 
                          Text("Angleško ime: ", style: m_pText,),
                          Text(getInfoFromDb.kor[treeIndex].angleskoIme)
                        ]
                      ),
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ 
                          Text("Latinsko ime: ", style: m_pText,),
                          Text( getInfoFromDb.kor[treeIndex].latinskoIme)
                        ]
                      ),
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ 
                          Text("Družina: ", style: m_pText,),
                          Text(getInfoFromDb.kor[treeIndex].druzina)
                        ]
                      ),
                      SizedBox(height: 20),
                      Text(getInfoFromDb.kor[treeIndex].splosno, style: m_pText,),
                    ],
                  ),
                ),
              ),
              alignment: Alignment.topLeft, margin: EdgeInsets.only(left: 10.0, right: 20.0, top: 10),
            ),
            Container(
              child: SingleChildScrollView( 
                child: Container(
                    child: Column( 
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: <Widget>[
                        Text("Opis: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].opisDrevesa, style: m_pText,),
                        Text("Cvetenje: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].cvet, style: m_pText,),
                        Text("Razmnoževanje: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].razm, style: m_pText,),
                        Text("Rastišče: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].rast, style: m_pText,),
                        Text("Splošna razširjenost: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].raz, style: m_pText,),
                        Text("Razširjenost v Sloveniji: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].razSLO, style: m_pText,),
                        Text("Uporabnost: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].uporabnost, style: m_pText,),
                    ],
                  ),
                ),
              ),
              alignment: Alignment.topLeft, margin: EdgeInsets.only(left: 10.0, right: 20.0, top: 10),
            ),
            Container(
              child: SingleChildScrollView( 
                child: Container(
                    child: Column( 
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: <Widget>[
                        Text("Zanimivosti: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].zanimivost, style: m_pText,),
                        Text("Izjemni primerki: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].izjemniPrimerki, style: m_pText,),
                        Text("Opozorilo: ", style: m_pHeading),
                        Text(getInfoFromDb.kor[treeIndex].opozorilo, style: m_pText,),
                    ],
                  ),
                ),
              ),
              alignment: Alignment.topLeft, margin: EdgeInsets.only(left: 10.0, right: 20.0, top: 10),
            ),
          ], 
          ),
        ),
      ],
    ),
  );
}
/*
Column(children: <Widget>[ 
      Container( 
          child: Image(image: AssetImage("assets/tree_images/" + getInfoFromDb.kor[widget.treeIndex].idDrevesa + ".jpg"),),
      ),
      Container(
         child:
          Text(getInfoFromDb.kor[widget.treeIndex].opisDrevesa),
      
        alignment: Alignment.topLeft, margin: EdgeInsets.only(left: 10.0, right: 20.0),
      ),
      ]),*/