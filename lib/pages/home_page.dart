import 'package:expends_record/models/Transaction_with_category.dart';
import 'package:expends_record/models/database.dart';
import 'package:expends_record/pages/transaksi_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final DateTime selectedDate;
  const HomePage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyDatabase database = MyDatabase();
  late Future<int> totalIncome;
  late Future<int> totalExpense;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalIncome = database.sumIncome();
    totalExpense = database.sumExpense();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        // Dasboard Total Transasi
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.download,
                          color: Colors.green,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pendapatan",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(
                            height: 5,
                          ),
                          FutureBuilder(
                              future: totalIncome,
                              builder: (contex, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Rp. 0');
                                } else {
                                  final totalAmount = snapshot.data ?? 0;
                                  return Text(
                                    'Rp. $totalAmount',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 12),
                                  );
                                }
                              })
                          // Text("Rp. 1.000.000",
                          //     style: GoogleFonts.montserrat(
                          //         color: Colors.white, fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.upload,
                          color: Colors.red,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pengeluaran",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(
                            height: 5,
                          ),
                          FutureBuilder(
                              future: totalExpense,
                              builder: (contex, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Rp. 0');
                                } else {
                                  final totalAmount = snapshot.data ?? 0;
                                  return Text(
                                    'Rp. $totalAmount',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 12),
                                  );
                                }
                              })
                          // Text("Rp. 1.000.000",
                          //     style: GoogleFonts.montserrat(
                          //         color: Colors.white, fontSize: 14)),
                        ],
                      )
                    ],
                  )
                ],
              ),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Text Transaksi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Transaksi",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<TransactionWithCategory>>(
              stream: database.getTransactionByDateRepo(widget.selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Card(
                              elevation: 8,
                              child: ListTile(
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        await database.deleteTransactionRepo(
                                            snapshot
                                                .data![index].transactions.id);
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => TransaksiPage(
                                                transactionWithCategory:
                                                    snapshot.data![index]),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                title: Text("Rp. " +
                                    snapshot.data![index].transactions.amount
                                        .toString()),
                                subtitle: Text(snapshot
                                        .data![index].kategori.name +
                                    ' ( ' +
                                    snapshot.data![index].transactions.name +
                                    ' )'),
                                leading: Container(
                                  child: (snapshot.data![index].kategori.type ==
                                          2)
                                      ? Icon(Icons.upload, color: Colors.red)
                                      : Icon(Icons.download,
                                          color: Colors.green),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text('Data Kosong'),
                      );
                    }
                  } else {
                    return Center(
                      child: Text('Tidak Ada Data'),
                    );
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
