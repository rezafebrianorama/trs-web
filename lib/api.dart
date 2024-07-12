import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiTrs {
  static getListProduk() async {
    List data = [];

    var url = Uri.parse('http://127.0.0.1:8000/api/produks');

    var response = await http.get(url);
    // log(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      data = jsonResponse['data'];
    }

    return data;
  }

  static deleteProduk(String idProduk) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/produk/$idProduk');
    var response = await http.delete(url);
    return response.statusCode;
  }

  static createProduk(dynamic params) async {
    bool isSave = false;
    var url = Uri.parse('http://127.0.0.1:8000/api/produk');
    var body = json.encode(params);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 201) {
      isSave = true;
    }
    return isSave;
  }

  static updateProduk(dynamic params) async {
    bool isSave = false;
    var url = Uri.parse('http://127.0.0.1:8000/api/produk/${params['id']}');
    Map data = {
      'name': params['name'],
      'deskripsi': params['deskripsi'],
      'price': params['price']
    };
    var body = json.encode(data);
    var response = await http.put(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      isSave = true;
    }
    return isSave;
  }
}
