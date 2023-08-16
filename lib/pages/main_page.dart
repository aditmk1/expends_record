import 'dart:ui' as ui;

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:expends_record/pages/category_page.dart';
import 'package:expends_record/pages/home_page.dart';
import 'package:expends_record/pages/transaksi_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DateTime selectedDate;
  late List<Widget> _children;
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    updateView(0, DateTime.now());
    super.initState();
  }

  void updateView(int index, DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }

      currentIndex = index;
      _children = [
        HomePage(
          selectedDate: selectedDate,
        ),
        CategoryPage()
      ];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0
          ? CalendarAppBar(
              accent: Colors.green,
              backButton: false,
              locale: 'id',
              onDateChanged: (value) {
                setState(() {
                  selectedDate = value;
                  updateView(0, selectedDate);
                });
              },
              firstDate: DateTime.now().subtract(Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              child: Container(
                child: Center(
                  child: Text(
                    'Kategori',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              preferredSize: ui.Size.fromHeight(100)),
      body: _children[currentIndex],
      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TransaksiPage(transactionWithCategory: null);
            }));
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  updateView(0, DateTime.now());
                },
                icon: Icon(Icons.home)),
            SizedBox(width: 20),
            IconButton(
                onPressed: () {
                  updateView(1, null);
                },
                icon: Icon(Icons.list))
          ],
        ),
      ),
    );
  }
}
