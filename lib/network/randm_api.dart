import 'dart:convert';
import 'package:practica5/models/character_model.dart';
import 'package:http/http.dart' as http;

class RandmAPI{
  final URLBase = "https://rickandmortyapi.com/api/character";

  Future<List<CharacterDao>?> getAllCharacters() async
  {
    final response = await  http.get(Uri.parse(URLBase));
    if(response.statusCode==200)
    {
      var character = jsonDecode(response.body)['results'] as List;
      List<CharacterDao> listCharacter = character.map((chara) => CharacterDao.fromJSON(chara)).toList();
      return listCharacter;
    }
    else
    {
      return null;
    }
  }
}