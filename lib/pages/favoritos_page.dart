
import 'package:carro/domain/carros.dart';
import 'package:carro/domain/db/CarroDB.dart';
import 'package:carro/domain/services/carro_service.dart';
import 'package:carro/pages/carro_page.dart';
import 'package:carro/utils/nav.dart';
import 'package:carro/widgets/carros_listView.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {

    //Banco de Dados
    Future<List<Carro>> future = CarroDB.getInstance().getCarros();

    return Container(
      padding: EdgeInsets.all(12),
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            final List<Carro> carros = snapshot.data;

            return CarrosListView(carros);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Sem dados",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 26,
                  fontStyle: FontStyle.italic
              ),),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
