import 'dart:async';
import 'dart:io';

import 'package:carro/domain/carros.dart';
import 'package:carro/domain/services/carros_bloc.dart';
import 'package:carro/widgets/carros_listView.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;

  const CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  final _bloc = CarrosBloc();

  get tipo => widget.tipo;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(tipo);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
        padding: EdgeInsets.all(12),
        child: StreamBuilder(
          stream: _bloc.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Carro> carros = snapshot.data;

              return CarrosListView(carros);
            } else if (snapshot.hasError) {
              final error = snapshot.error;

              return Center(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      error is SocketException
                          ? "Conexão indisponível, por favor verifique sua internet."
                          : "Ocorreu um erro ao buscar a lista de carros",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 26,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh() {
    print("onRefresh");
    return _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.close();
  }
}
