// import 'package:drift/drift.dart';
import 'package:expends_record/models/database.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/basic.dart' as FlutterBasic;

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpend = true;
  final MyDatabase database = MyDatabase();
  TextEditingController namaKategoriController = TextEditingController();
  Kategori? selected;

  Future insert(String name, bool isExpend) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.categories).insertReturning(
        CategoriesCompanion.insert(
            name: name,
            type: isExpend ? 2 : 1,
            createdAt: now,
            updateedAt: now));
    print(row.toString());
  }

  Future<List<Kategori>> getAllKategori(bool isExpend) async {
    return await database.getAllKategoriRepo(isExpend ? 2 : 1);
  }

  Future update(int kategori_id, String newName, bool newIsExpend) async {
    return await database.updateKategoriRepo(
        kategori_id, newName, newIsExpend ? 2 : 1);
  }

  void openDialog(Kategori? kategori) {
    if (kategori != null) {
      namaKategoriController.text = kategori.name;
      isExpend = kategori.type == 2;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          List<String> list = ['Pengeluaran', 'Pendapatan'];
          String dropDownValue = list[isExpend ? 0 : 1];

          return AlertDialog(
            content: SingleChildScrollView(
              child: Center(
                child: FlutterBasic.Column(
                  children: [
                    Text(
                      "Tambah Kategori",
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            value: dropDownValue,
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                if (value == 'Pengeluaran') {
                                  isExpend = true;
                                } else if (value == 'Pendapatan') {
                                  isExpend = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: namaKategoriController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "Ketegori"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (kategori == null) {
                          insert(namaKategoriController.text, isExpend);
                        } else {
                          update(kategori.id, namaKategoriController.text,
                              isExpend);
                        }
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                        setState(() {});
                        namaKategoriController.clear();
                      },
                      child: Text("Simpan"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterBasic.Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: isExpend,
                  onChanged: (bool value) {
                    setState(() {
                      isExpend = value;
                    });
                  },
                  inactiveTrackColor: Colors.green[200],
                  inactiveThumbColor: Colors.green,
                  activeColor: Colors.red,
                ),
                Text(isExpend ? 'Pengeluaran' : 'Pendapatan',
                    style: GoogleFonts.montserrat(fontSize: 16)),
                IconButton(
                    onPressed: () {
                      openDialog(null);
                    },
                    icon: Icon(Icons.add))
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Kategori>>(
              future: getAllKategori(isExpend),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data!.length > 0 || snapshot.hasData) {
                    return ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Card(
                              elevation: 8,
                              child: ListTile(
                                leading: isExpend
                                    ? Icon(Icons.upload, color: Colors.red)
                                    : Icon(Icons.download, color: Colors.green),
                                title: Text(snapshot.data![index].name),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          database.deleteKategoriRepo(
                                              snapshot.data![index].id);
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.delete)),
                                    IconButton(
                                        onPressed: () {
                                          openDialog(snapshot.data![index]);
                                        },
                                        icon: Icon(Icons.edit)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(child: Text('Tidak Ada Kategori'));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
