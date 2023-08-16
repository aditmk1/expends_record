import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expends_record/models/category.dart';
import 'package:expends_record/models/Transaction_with_category.dart';
import 'package:expends_record/models/transaction.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(
  tables: [Categories, Transations],
  queries: {
    'getTotalPendapatan': 'SELECT SUM(amount) FROM transactions WHARE type 1',
  },
)
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 2;

  // CRUD

  Future<List<Kategori>> getAllKategoriRepo(int type) async {
    return await (select(categories)..where((tbl) => tbl.type.equals(type)))
        .get();
  }

  Future updateKategoriRepo(int id, String name, int type) async {
    return (update(categories)..where((tbl) => tbl.id.equals(id)))
        .write(CategoriesCompanion(
      name: Value(name),
      type: Value(type),
    ));
  }

  Future deleteKategoriRepo(int id) async {
    return (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<TransactionWithCategory>> getTransactionByDateRepo(
      DateTime date) {
    final query = select(transations).join([
      innerJoin(categories, categories.id.equalsExp(transations.category_id))
    ])
      ..where(transations.transactions_date.equals(date));

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
            row.readTable(transations), row.readTable(categories));
      }).toList();
    });
  }

  Future updateTransactionRepo(int id, int amount, int kategoryId,
      DateTime transactions_date, String nameDetail) async {
    return (update(transations)..where((tbl) => tbl.id.equals(id))).write(
      TransationsCompanion(
        name: Value(nameDetail),
        amount: Value(amount),
        category_id: Value(kategoryId),
        Transactions_date: Value(transactions_date),
      ),
    );
  }

  Future deleteTransactionRepo(int id) async {
    return (delete(transations)..where((tbl) => tbl.id.equals(id))).go();
  }

//   Future<List<Transation>> calcAmount(int amount) {
//   return (select(transations)..where((t) {
//     final totalPrice = t.amount * Variable(amount);
//     return totalPrice.isSmallerOrEqualValue(amount);
//   })).get();
// }
  Future<int> sumIncome() {
    final sumQuery = customSelect(
        'SELECT SUM(a.amount) as total FROM transations AS a INNER JOIN categories AS b ON a.category_id = b.id WHERE b.type = 1');
    return sumQuery.map((row) => row.read<int>('total')).getSingle();
  }

  Future<int> sumExpense() {
    final sumQuery = customSelect(
        'SELECT SUM(a.amount) as total FROM transations AS a INNER JOIN categories AS b ON a.category_id = b.id WHERE b.type = 2');
    return sumQuery.map((row) => row.read<int>('total')).getSingle();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
