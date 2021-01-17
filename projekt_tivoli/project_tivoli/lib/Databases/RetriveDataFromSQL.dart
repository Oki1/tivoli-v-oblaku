import 'package:project_tivoli/Utilities/Kordinate.dart';

import '../Databases/ImportSQL.dart';

class GetInfoFromDB {
  GetInfoFromDB._privateConstructor();
  static final GetInfoFromDB instance = GetInfoFromDB._privateConstructor();

  final db = DatabaseHelper.instance;

  List<Kordinate> kor = [];

  Kordinate cur;

  Future<List<Kordinate>> getList() async {
    if (kor.isNotEmpty) return kor;
    kor = await _fetchRows();
    return kor;
  }

  _fetchRows() async {
    final allRows = await db.querryAllRows();
    allRows.forEach((row) => {
          cur = new Kordinate(),
          cur.lat = row['Lats'].toString(),
          cur.long = row['Longs'].toString(),
          print(cur.lat.toString()),
          kor.add(cur)
        });
    print("Kor lenght: " + kor.length.toString());
    kor.forEach((element) {
      print(element.lat.toString());
    });
    return kor;
  }
}
