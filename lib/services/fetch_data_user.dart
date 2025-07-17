import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:suitmedia_test/model/user_model.dart';

Future<List<User>> fetchUser(int page) async{
  final respone = await http.get(Uri.parse('https://reqres.in/api/users?page=$page&per_page=10'));

  if(respone.statusCode == 200){
    final jsonData = json.decode(respone.body);
    final List<dynamic> data = jsonData['data'];

    return data.map((json) => User.fromjson(json)).toList();
  }else{
    throw Exception('Gagal mengambil data');
  }
}