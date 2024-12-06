// ignore_for_file: unused_field

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_attribute_explainer/config/themes.dart';

class WidgetExplain extends StatefulWidget {
  const WidgetExplain({super.key});

  @override
  WidgetExplainState createState() => WidgetExplainState();
}

class WidgetExplainState extends State<WidgetExplain> {
  List<List<dynamic>> _data = [];
  List<List<dynamic>> _filteredData = []; // Für die gefilterten Daten
  String _searchQuery = ""; // Für den Suchtext

  // Laden und Filtern der CSV-Daten
  void _loadCSV() async {
    try {
      final rawData =
          await rootBundle.loadString("lib/assets/sheets/50_Widgets.csv");
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(rawData, fieldDelimiter: ";");

      // Nur Zeilen mit mindestens 3 Spalten speichern
      setState(() {
        _data = listData.where((row) => row.length >= 3).toList();
        _filteredData = List.from(_data); // Anfangs alle Daten anzeigen
      });
    } catch (e) {
      setState(() {
        _data = [];
        _filteredData = [];
      });
    }
  }

  // Methode zum Filtern der Daten basierend auf der Eingabe
  void _filterData(String query) {
    setState(() {
      _searchQuery = query;
      _filteredData = _data.where((row) {
        // Filtert die Daten, indem alle Spalten verglichen werden
        return row.any((field) =>
            field.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCSV(); // CSV-Daten beim Start laden
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: learnWidget,
      home: Scaffold(
        appBar: AppBar(title: const Text("Welches Widget willst du sehen?")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _filterData, // Filtert die Daten bei jeder Eingabe
                decoration: const InputDecoration(
                  labelText: "Suche",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: _filteredData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : InteractiveViewer(
                      constrained: false,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 4,
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Widget',
                            )),
                            DataColumn(label: Text('Attribut')),
                            DataColumn(label: Text('Erklärung')),
                          ],
                          rows: _filteredData.map((row) {
                            return DataRow(cells: [
                              DataCell(Text(row[0].toString())), // Widget
                              DataCell(Text(row[1].toString())), // Attribut
                              DataCell(Text(row[2].toString())), // Erklärung
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
