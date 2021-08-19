
import 'package:sqflite/sqflite.dart';

mixin Queries {
  late Database dbInstance;

  Future<void> createCartTable() async {
    await dbInstance.execute('CREATE TABLE cart ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'product_id INTEGER,'
        'price NUMERIC,'
        'quantity INTEGER,'
        'user_id INTEGER,'
        'nameEn TEXT,'
        'nameAr TEXT'
        ')');
  }

}
