import 'package:flutter/material.dart';
import 'package:project_tivoli/Databases/ImportSQL.dart';
import 'package:project_tivoli/Databases/RetriveDataFromSQL.dart';
import 'package:project_tivoli/Menu/GMap.dart';
import 'package:project_tivoli/Menu/SideBar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_tivoli/Databases/ExportSQL.dart';
import 'Menu/ONas.dart';
import 'Menu/GMap.dart';
import 'Menu/Settings.dart';
import 'Menu/Kviz/StartPage.dart';
import 'package:package_info/package_info.dart';

void main() {
  runApp(MyApp());
  final getInfoFromDb = GetInfoFromDB.instance;
  getInfoFromDb.getList();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final getInfoFromDb = GetInfoFromDB.instance;


  double getallTree() {
    double index = 0;
    getInfoFromDb.kor.forEach((element) {
      if (element.beenThere == 1) {
        index++;
      }
    });
    print(index);
    return index;
  }
  String appName ;
  String packageName;
  String version;
  String buildNumber;


  Future<void> getBuildInfo() async {
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;    
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBuildInfo(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return Container();
        }
        else 
        {
          return Scaffold(
            body: Column( 
                children: [ 
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                      Container(
                        height: 225.0,
                        child: DrawerHeader(
                            child: Image(image: AssetImage("assets/menu_ass/logo.png"), height: 120, width: 120,),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.map),
                        title: Text('Zemljevid z drevesi'),
                        onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GMap()),
                      ),
                      ),
                      ListTile(
                        leading: Icon(Icons.ballot),
                        title: Text('Kviz'),
                        onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KvizStartPage())),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Nastavitve'),
                        onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings())),
                      ),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text('O nas'),
                        onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ONas())),
                      ),
                    ],
                  ),               
                ],
            ),
            persistentFooterButtons: [Text("Verzija: " + version.toString())],
          );
        }
      }
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
      future: retriveDataFromSQL(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return Container();
        }
        else 
        {
          return Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              title: Text("Tivoli v oblaku"),
            ),
            body: Center(
                child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      reverse: true,
                      viewportFraction: 0.7,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 5),
                    ),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 0.0),
                              child: buildCards(i));
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  treeExpertCard(),
                  SizedBox(height: 20),
                  Text(
                    "O aplikaciji",
                    style: new TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                      'Ta aplikacija je bila narejena, kot raziskovalna naloga za biologijo. Zanimalo nas je, kako bi z aplikacijo lahko učili ljudi o drevesih. Če pritisnete na zavihek mapa, se vam bo odprla karta, ki vam bo v živo kazala zanimiva drevesa v parku Tivoli. Ali z pritiskom na drevo, ali s tem da se mu približate na razdaljo 10 metrov boste lahko ugotovili več o teh veličastnih rastlinah.',
                      style: new TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.left),
                ],
              ),
            )),
          );
        }
      }
    );
  }*/
}