import 'package:flutter/material.dart';
import 'package:flutter_web_trs/api.dart';

class EditProdukScreen extends StatefulWidget {
  const EditProdukScreen({Key? key, required this.dataParams})
      : super(key: key);

  final dynamic dataParams;
  @override
  State<EditProdukScreen> createState() => _EditProdukScreenState();
}

class _EditProdukScreenState extends State<EditProdukScreen> {
  final _name = TextEditingController();
  final _deskripsi = TextEditingController();
  final _price = TextEditingController();
  bool isLoad = false;

  @override
  void initState() {
    _name.text = widget.dataParams['name'];
    _deskripsi.text = widget.dataParams['deskripsi'];
    _price.text = widget.dataParams['price'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edit Produk'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _deskripsi,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _price,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 90),
            TextButton(
                onPressed: () async {
                  setState(() {
                    isLoad = true;
                  });
                  dynamic params = {
                    'id': widget.dataParams['id'],
                    'name': _name.text,
                    'deskripsi': _deskripsi.text,
                    'price': _price.text
                  };
                  bool updateData = await ApiTrs.updateProduk(params);
                  if (updateData == true) {
                    Navigator.pop(context, updateData);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Gagal coba lagi'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Oke'))
                            ],
                          );
                        });
                    setState(() {
                      isLoad = false;
                    });
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 60)),
                child: isLoad
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Update',
                        style: TextStyle(letterSpacing: 1.5),
                      ))
          ],
        ),
      ),
    );
  }
}
