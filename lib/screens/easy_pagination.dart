import 'dart:convert';
import 'dart:ui';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EasyPagination extends StatefulWidget {
  @override
  State<EasyPagination> createState() => _EasyPaginationState();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _EasyPaginationState extends State<EasyPagination> {
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  final _source = ExampleSource();
  var _sortIndex = 0;
  var _sortAsc = true;
  final _searchController = TextEditingController();
  var _customFooter = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advance"),
        actions: [
          IconButton(
            icon: const Icon(Icons.table_chart_outlined),
            tooltip: 'Change footer',
            onPressed: () {
              // handle the press
              setState(() {
                _customFooter = !_customFooter;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search by company',
                      ),
                      onSubmitted: (vlaue) {
                        _source.filterServerSide(_searchController.text);
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _searchController.text = '';
                    });
                    _source.filterServerSide(_searchController.text);
                  },
                  icon: const Icon(Icons.clear),
                ),
                IconButton(
                  onPressed: () =>
                      _source.filterServerSide(_searchController.text),
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            AdvancedPaginatedDataTable(
              addEmptyRows: false,
              source: _source,
              showHorizontalScrollbarAlways: true,
              sortAscending: _sortAsc,
              sortColumnIndex: _sortIndex,
              showFirstLastButtons: true,
              rowsPerPage: _rowsPerPage,
              availableRowsPerPage: const [10, 20, 30, 50],
              onRowsPerPageChanged: (newRowsPerPage) {
                if (newRowsPerPage != null) {
                  setState(() {
                    _rowsPerPage = newRowsPerPage;
                  });
                }
              },
              showCheckboxColumn: false,
              columns: [
                DataColumn(
                  label: const Text('ID'),
                  numeric: true,
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Company'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('First name'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Last name'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Phone'),
                  onSort: setSort,
                ),
              ],
              //Optianl override to support custom data row text / translation
              getFooterRowText:
                  (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
                final localizations = MaterialLocalizations.of(context);
                var amountText = localizations.pageRowsInfoTitle(
                  startRow,
                  pageSize,
                  totalFilter ?? totalRowsWithoutFilter,
                  false,
                );

                if (totalFilter != null) {
                  //Filtered data source show addtional information
                  amountText += ' filtered from ($totalRowsWithoutFilter)';
                }

                return amountText;
              },
              customTableFooter: _customFooter
                  ? (source, offset) {
                      const maxPagesToShow = 6;
                      const maxPagesBeforeCurrent = 3;
                      final lastRequestDetails = source.lastDetails!;
                      final rowsForPager = lastRequestDetails.filteredRows ??
                          lastRequestDetails.totalRows;
                      final totalPages = rowsForPager ~/ _rowsPerPage;
                      final currentPage = (offset ~/ _rowsPerPage) + 1;
                      final List<int> pageList = [];
                      if (currentPage > 1) {
                        pageList.addAll(
                          List.generate(currentPage - 1, (index) => index + 1),
                        );
                        //Keep up to 3 pages before current in the list
                        pageList.removeWhere(
                          (element) =>
                              element < currentPage - maxPagesBeforeCurrent,
                        );
                      }
                      pageList.add(currentPage);
                      //Add reminding pages after current to the list
                      pageList.addAll(
                        List.generate(
                          maxPagesToShow - (pageList.length - 1),
                          (index) => (currentPage + 1) + index,
                        ),
                      );
                      pageList.removeWhere((element) => element > totalPages);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: pageList
                            .map(
                              (e) => TextButton(
                                onPressed: e != currentPage
                                    ? () {
                                        //Start index is zero based
                                        source.setNextView(
                                          startIndex: (e - 1) * _rowsPerPage,
                                        );
                                      }
                                    : null,
                                child: Text(
                                  e.toString(),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class ExampleSource extends AdvancedDataTableSource<CompanyContact> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';

  @override
  DataRow? getRow(int index) =>
      lastDetails!.rows[index].getRow(selectedRow, selectedIds);

  @override
  int get selectedRowCount => selectedIds.length;

  // ignore: avoid_positional_boolean_parameters
  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<CompanyContact>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    print(
        "++++++++++++pageRequest.offset.toString() : ${pageRequest.offset.toString()}");
    print(
        "++++++++++++pageRequest.pageSize.toString() : ${pageRequest.pageSize.toString()}");
    /*  print(
        "++++++++++++((pageRequest.columnSortIndex ?? 0) + 1).toString() : ${((pageRequest.columnSortIndex ?? 0) + 1).toString()}");
    print(
        "++++++++++++((pageRequest.sortAscending ?? true) ? 1 : 0).toString() : ${((pageRequest.sortAscending ?? true) ? 1 : 0).toString()}");
        print("++++++++++++lastSearchTerm : $lastSearchTerm");*/

    //the remote data source has to support the pagaing and sorting
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      'pageSize': pageRequest.pageSize.toString(),
      'sortIndex': ((pageRequest.columnSortIndex ?? 0) + 1).toString(),
      'sortAsc': ((pageRequest.sortAscending ?? true) ? 1 : 0).toString(),
      if (lastSearchTerm.isNotEmpty) 'companyFilter': lastSearchTerm,
    };
    final _authority = "localhost";
    final _path = "/getDataflutter.php";

    final requestUri = Uri.http(_authority, _path, queryParameter);

    /*final requestUri = Uri.https(
      'http://localhost/getDataflutter.php',
      '',
      queryParameter,
    );*/

    final response = await http.get(requestUri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print("++++++++++++++++++++++++++getNextPage+");
      print("++++++++++++++++++++++++++data+ $data");

      return RemoteDataSourceDetails(
        //    int.parse(data['totalRows'].toString()),
        30,
        //  (data['rows'] as List<dynamic>)
        (data as List<dynamic>)
            .map(
              (json) => CompanyContact.fromJson(json as Map<String, dynamic>),
            )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            // ? (data['rows'] as List<dynamic>).length
            ? (data as List<dynamic>).length
            : null,
      );
    } else {
      print("++++++++++++++++++++++++++response + ${response}");
      throw Exception('Unable to query remote server');
    }
  }
}

class CompanyContact {
  final int id;
  final String companyName;
  final String firstName;
  final String lastName;
  final String phone;

  const CompanyContact(
    this.id,
    this.companyName,
    this.firstName,
    this.lastName,
    this.phone,
  );

  DataRow getRow(
    SelectedCallBack callback,
    List<String> selectedIds,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(id.toString())),
        DataCell(Text(companyName)),
        DataCell(Text(firstName)),
        DataCell(Text(lastName)),
        DataCell(Text(phone)),
      ],
      onSelectChanged: (newState) {
        callback(id.toString(), newState ?? false);
      },
      selected: selectedIds.contains(id.toString()),
    );
  }

  factory CompanyContact.fromJson(Map<String, dynamic> json) {
    return CompanyContact(
      json['id'] as int,
      json['companyName'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }
}
