import 'dart:convert';
import 'package:practica5/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:practica5/models/location_model.dart';

class RandmAPI{
  final URLBase = "https://rickandmortyapi.com/api/character";

  Future<List<CharacterDao>?> getAllCharacters() async
  {
    final response = await  http.get(Uri.parse('$URLBase/?page=2'));
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

  Future<Map<String, dynamic>?> getDetails(int id) async
  {
    bool hasOrigin=true, hasLocation =true;
    final response = await http.get(Uri.parse('$URLBase/$id'));
    if(response.statusCode==200)
    {
      CharacterDao chara = CharacterDao.fromJSON(jsonDecode(response.body));
      LocationDao origin;
      LocationDao location;
      if(jsonDecode(response.body)['origin']['url'].toString().isNotEmpty)
      {
        final responseO=await http.get(Uri.parse(jsonDecode(response.body)['origin']['url']));
        if(responseO.statusCode==200)
        {
          origin = LocationDao.fromJSON(jsonDecode(responseO.body));
        }
        else
        {
          origin = LocationDao(id: 0,name: "Unknown", dimension: "N/A", url: "", type: "N/A", created: "N/A");
        }
      }
      else
      {
        origin = LocationDao(id: 0,name: "Unknown", dimension: "N/A", url: "", type: "N/A", created: "N/A");
      }
      if(jsonDecode(response.body)['location']['url'].toString().isNotEmpty)
      {
        final responseL = await http.get(Uri.parse(jsonDecode(response.body)['location']['url']));
        if(responseL.statusCode==200)
        {
          location = LocationDao.fromJSON(jsonDecode(responseL.body));
        }
        else
        {
          location = LocationDao(id: 0,name: "Unknown", dimension: "N/A", url: "", type: "N/A", created: "N/A");
        }
      }
      else
      {
        location = LocationDao(id: 0,name: "Unknown", dimension: "N/A", url: "", type: "N/A", created: "N/A");
      }   
      Map<String, dynamic> lista = {
        "chara": chara,
        "origin": origin,
        "location": location,
      };
      return lista;
    }
    else
    {
      return null;
    }
  }
}