import 'package:flutter/material.dart';
import 'package:flutter_web_trs/api.dart';
import 'package:flutter_web_trs/screens/editProduk.dart';
import 'package:intl/intl.dart';

class ProdukScreen extends StatefulWidget {
  const ProdukScreen({super.key});

  @override
  State<ProdukScreen> createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  List produk = [];
  bool isLoad = true;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    var getListSo = await ApiTrs.getListProduk();

    if (getListSo.isNotEmpty) {
      setState(() {
        produk = getListSo;
        isLoad = false;
      });
    }
  }

  formatRupiah(String s) {
    return NumberFormat.decimalPattern('id').format(int.parse(s));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text('Produk'),
      ),
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : Column(
              children: [
                Container(
                  height: 60,
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(width: 1),
                                left: BorderSide(width: 1))),
                        width: (MediaQuery.of(context).size.width - 210) / 3,
                        child: Center(
                            child: Text(
                          'Nama',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1))),
                        width: (MediaQuery.of(context).size.width - 210) / 3,
                        child: Center(
                            child: Text(
                          'Deskripsi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1))),
                        width: (MediaQuery.of(context).size.width - 210) / 3,
                        child: Center(
                            child: Text(
                          'Harga',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        width: 150,
                        child: Center(
                            child: Text(
                          'Action',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 80),
                    children: [
                      for (int i = 0; i < produk.length; i++)
                        Container(
                          height: 60,
                          color: i.isOdd ? Colors.grey[300] : Colors.white,
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                child: Center(child: Text('${i + 1}')),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(width: 1),
                                        left: BorderSide(width: 1))),
                                width:
                                    (MediaQuery.of(context).size.width - 210) /
                                        3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(produk[i]['name']),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border(right: BorderSide(width: 1))),
                                width:
                                    (MediaQuery.of(context).size.width - 210) /
                                        3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(produk[i]['deskripsi']),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border(right: BorderSide(width: 1))),
                                width:
                                    (MediaQuery.of(context).size.width - 210) /
                                        3,
                                child: Center(
                                    child: Text(
                                        'Rp ${formatRupiah(produk[i]['price'])}')),
                              ),
                              Container(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                          bool result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => EditProdukScreen(
                                                  dataParams: produk[i]),
                                            ),
                                          );

                                          if (result == true) {
                                            setState(() {
                                              isLoad = true;
                                            });
                                            _getData();
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white),
                                        child: Icon(Icons.edit)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Yakin hapus?'),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Tidak')),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop();
                                                          setState(() {
                                                            isLoad = true;
                                                          });
                                                          var delProduk = await ApiTrs
                                                              .deleteProduk(
                                                                  produk[i]
                                                                          ['id']
                                                                      .toString());
                                                          if (delProduk ==
                                                              200) {
                                                            _getData();
                                                          } else {
                                                            setState(() {
                                                              isLoad = false;
                                                            });
                                                          }
                                                        },
                                                        child: Text('Ya'))
                                                  ],
                                                );
                                              });
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white),
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add-produk').then((value) {
              setState(() {
                isLoad = true;
              });
              _getData();
            });
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          label: const Row(
            children: [
              Icon(Icons.add),
              Text(' Add'),
            ],
          )),
    );
  }
}
