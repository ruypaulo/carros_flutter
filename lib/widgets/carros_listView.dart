
import 'package:carro/domain/carros.dart';
import 'package:carro/pages/carro_page.dart';
import 'package:carro/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {

  final List<Carro> carros;

  const CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (ctx, idx) {
        // Carro
        final c = carros[idx];
        return Container(
          height: 280,
          child: InkWell(
            onTap: () {
              _onClickCarro(context, c);
            },
            onLongPress: () {
              _onLongClickCarro(context, c);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        c.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                        height: 150,
                      ),
                    ),
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      c.desc,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () {
                              _onClickCarro(context, c);
                            },
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {
                              _onClickShare(context, c);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onClickCarro(BuildContext context, Carro carro) {
    push(context, CarroPage(carro));
  }

  void _onLongClickCarro(BuildContext context, Carro c) {
    showModalBottomSheet(context: context,builder: (context){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(c.nome,style: TextStyle(
              fontSize: 22,fontWeight: FontWeight.bold,
            ),),
          ),
          ListTile(
            title: Text("Detalhes"),
            leading: Icon(Icons.directions_car),
            onTap: () {
              pop(context);
              _onClickCarro(context, c);
            },
          ),
          ListTile(
            title: Text("Share"),
            leading: Icon(Icons.share),
            onTap: () {
              pop(context);
              _onClickShare(context, c);
            },
          )
        ],
      );
    });
  }

  void _onClickShare(BuildContext context, Carro c) {
    print("Share ${c.nome}");

    Share.share(c.urlFoto);
  }
}
