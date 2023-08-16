import 'package:expends_record/models/Transaction_with_category.dart';
import 'package:expends_record/models/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:sqflite/sqflite.dart';

class TransaksiPage extends StatefulWidget {
  final TransactionWithCategory? transactionWithCategory;
  const TransaksiPage({
    Key? key,
    required this.transactionWithCategory,
  }) : super(key: key);

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final MyDatabase database = MyDatabase();
  bool isExpend = true;
  late int type;
  TextEditingController jumlahController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController desripsiController = TextEditingController();
  Kategori? selectedKategori;

  Future insert(
      int jumlah, DateTime date, String namaDeskripsi, int kategoriId) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.transations).insertReturning(
          TransationsCompanion.insert(
            name: namaDeskripsi,
            category_id: kategoriId,
            Transactions_date: date,
            amount: jumlah,
            createdAt: now,
            updateedAt: now,
          ),
        );
    print('object ' + row.toString());
  }

  Future<List<Kategori>> getAllKategori(type) async {
    return await database.getAllKategoriRepo(type);
  }

  Future update(int amount, int transaction_id, int category_id,
      DateTime transactions_date, String nameDetail) async {
    return await database.updateTransactionRepo(
      amount,
      transaction_id,
      category_id,
      transactions_date,
      nameDetail,
    );
  }

  @override
  void initState() {
    if (widget.transactionWithCategory != null) {
      updateTransaksiView(widget.transactionWithCategory!);
    } else {
      type = 2;
    }
    super.initState();
  }

  void updateTransaksiView(TransactionWithCategory transactionWithCategory) {
    jumlahController.text =
        transactionWithCategory.transactions.amount.toString();
    desripsiController.text = transactionWithCategory.transactions.name;
    dateController.text = DateFormat('yyyy-MM-dd')
        .format(transactionWithCategory.transactions.Transactions_date);
    type = transactionWithCategory.kategori.type;
    (type == 2) ? isExpend = true : isExpend = false;
    selectedKategori = transactionWithCategory.kategori;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Transaksi"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Switch(
                      value: isExpend,
                      onChanged: (bool value) {
                        setState(() {
                          isExpend = value;
                          type = (isExpend) ? 2 : 1;
                          selectedKategori = null;
                        });
                      },
                      inactiveTrackColor: Colors.green[200],
                      inactiveThumbColor: Colors.green,
                      activeColor: Colors.red,
                    ),
                  ),
                  Text(
                    isExpend ? 'Pengeluaran' : 'Pendapatan',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:
                    Text("Jumlah", style: GoogleFonts.montserrat(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  style: GoogleFonts.montserrat(fontSize: 12),
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Kategori",
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
              ),
              FutureBuilder<List<Kategori>>(
                future: getAllKategori(type),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Tidak ada data'),
                      );
                    } else {
                      if (selectedKategori == null) {
                        selectedKategori = snapshot.data!.first;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton<Kategori>(
                          value: selectedKategori,
                          isExpanded: true,
                          items: snapshot.data!.map((Kategori item) {
                            return DropdownMenuItem<Kategori>(
                              value: item,
                              child: Text(item.name),
                            );
                          }).toList(),
                          onChanged: (Kategori? value) {
                            setState(() {
                              selectedKategori = value;
                            });
                          },
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Text('Tidak ada data'),
                    );
                  }
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Tanggal",
                    style: GoogleFonts.montserrat(fontSize: 14)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  style: GoogleFonts.montserrat(fontSize: 12),
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2099),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      dateController.text = formattedDate;
                    }
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Deskripsi",
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  style: GoogleFonts.montserrat(fontSize: 12),
                  controller: desripsiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    (widget.transactionWithCategory == null)
                        ? insert(
                            int.parse(jumlahController.text),
                            DateTime.parse(dateController.text),
                            desripsiController.text,
                            selectedKategori!.id,
                          )
                        : await update(
                            widget.transactionWithCategory!.transactions.id,
                            int.parse(jumlahController.text),
                            selectedKategori!.id,
                            DateTime.parse(dateController.text),
                            desripsiController.text);
                    Navigator.pop(context, true);
                  },
                  child: Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
