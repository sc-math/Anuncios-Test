import 'dart:convert';
import 'package:anuncios_test/model/empresa.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<All> getAllCompany() async{
  const url = 'https://drive.google.com/uc?export=download&id=1MFQOQFfPBVNICCQVA60xOripZy1nMRE7';

  http.Response response = await http.get(
    Uri.parse(url),
  );

  List<Empresa> result = [];

  if (response.statusCode == 200){

    final List<dynamic> jsonList = json.decode(utf8.decode( response.bodyBytes))['empresas'];
    for(var jsonMap in jsonList) {
      result.add(Empresa.fromJson(jsonMap));
    }

    for(var empresa in result){
      if (kDebugMode) {
        print(empresa);
      }
    }

    return All(empresas: result);
  }
  else{
    throw Exception('Failed to fetch repos!');
  }
}