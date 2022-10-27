import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica5/models/character_model.dart';
import 'package:practica5/models/location_model.dart';
import 'package:practica5/network/randm_api.dart';

class DetailCharacterScreen extends StatefulWidget {
  const DetailCharacterScreen({super.key});

  @override
  State<DetailCharacterScreen> createState() => _DetailCharacterScreenState();
}

class _DetailCharacterScreenState extends State<DetailCharacterScreen> {
  int idChara = 0;
  Map<String, dynamic>? data;
  int contador =0;
  bool isLoading=true;
  RandmAPI api = RandmAPI();
  CharacterDao? chara;
  LocationDao? location;
  LocationDao? origin;

  @override
  Widget build(BuildContext context) {
    idChara=ModalRoute.of(context)?.settings.arguments as int;
    if(contador<=0 && isLoading)
    {
      api.getDetails(idChara).then((mapa) {
        setState(() {
          data = mapa;
          chara = mapa!['chara'] as CharacterDao;
          location = mapa['location'] as LocationDao;
          origin = mapa['origin'] as LocationDao;
          isLoading = false;
        });
      },);
    }
    if(isLoading)
    {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cargando...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${chara!.name}'),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${chara!.image}',
                  ),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          _buildDraggableScrollableSheet(),
        ],
      ),
    );
  }

  DraggableScrollableSheet _buildDraggableScrollableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            // border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 18, 175, 201).withOpacity(0.6),
                    ),
                    child: Center(
                      child: Text('Datos', style: TextStyle(color: Colors.white, fontSize: 60)),
                    ),
                  ),
                  datos('Nombre', '${chara!.name}',Icons.abc),
                  datos('Estatus', '${chara!.status}', Icons.live_help),
                  datos('Especie', '${chara!.species}', '${chara!.species}'.contains('Human')?Icons.person:Icons.smart_toy),
                  datos('Tipo', '${chara!.type}', FontAwesomeIcons.redditAlien),
                  datos('Genero', '${chara!.gender}', '${chara!.gender}'.contains("Female")?Icons.female:'${chara!.gender}'.contains("Male")?Icons.male:'${chara!.gender}'.contains("Genderless")?Icons.transgender:Icons.do_disturb),
                  datos('Planeta de Origen:', '${origin!.name}', Icons.home),
                  datos('Tipo:', '${origin!.type}', Icons.public),
                  datos('Dimensión:', '${origin!.dimension}', Icons.foundation),
                  datos('Última locación conocida:', '${location!.name}', Icons.cabin),
                  datos('Tipo:', '${location!.type}', Icons.travel_explore),
                  datos('Dimensión:', '${location!.dimension}', Icons.foundation),
                ],
              ),
            ),
            /*ListView.builder(
              controller: scrollController,
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.ac_unit),
                  title: Text('Item $index'),
                );
              },
            ),*/
          ),
        );
      },
    );
  }

  Widget datos(String title, String content, IconData icono)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
      child: Row(
        children: [
          Icon(
            icono,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.5,
            child: Text(
              '$title: $content',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'consolas',
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}