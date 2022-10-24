import 'package:flutter/material.dart';
import 'package:practica5/models/character_model.dart';
import 'package:practica5/network/randm_api.dart';

class ListCharacterScreen extends StatefulWidget {
  const ListCharacterScreen({super.key});

  @override
  State<ListCharacterScreen> createState() => _ListCharacterScreenState();
}

class _ListCharacterScreenState extends State<ListCharacterScreen> with SingleTickerProviderStateMixin {
  RandmAPI randmAPI = RandmAPI();
  late AnimationController _controllerA;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerA = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: 0.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty Characters'),
        actions: [
          GestureDetector(
            onTap: () {
              if(_controllerA.isCompleted)
              {
                _controllerA.reverse();
              }
              else
              {
                _controllerA.forward();
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.list_view,
              progress: _controllerA,
              size: MediaQuery.of(context).size.width*0.12,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: randmAPI.getAllCharacters(),
          builder: (BuildContext context, AsyncSnapshot<List<CharacterDao>?> snapshot) {
            if(snapshot.hasData)
            {
              return _listViewCharacters(snapshot.data);
            }
            else
            {
              if(snapshot.hasError)
              {
                return Center(child: Text('Ocurrio un error en la petición ${snapshot.error}'));
              }
              else
              {
                return Center(child: CircularProgressIndicator(),);
              }
            }
          },
      )
    );
  }

  Widget _listViewCharacters(List<CharacterDao>? snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.black,),
      itemCount: snapshot!.length,
      itemBuilder: (context, index) {
      //return Text(snapshot![0].name!);
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FadeInImage(
              fadeInDuration: Duration(milliseconds: 500),
              placeholder: AssetImage('assets/loading_chara.gif'),
              image: NetworkImage('${snapshot[index].image!}'),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(.6),
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                  context, '/detail',
                  //arguments: snapshot[index],
                  arguments: snapshot[index].id,
                ).then((value) {
                  setState(() {
                    //Sasa
                  });
                }),
                title: Text(
                  '${snapshot[index].name}',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  '${snapshot[index].status}',
                  style: TextStyle(color: Colors.white),
                ), //Icon(Icons.chevron_right, color: Colors.white, size:30),
              ),
            ),
          ],
        ),
      );
    },);
  }
}