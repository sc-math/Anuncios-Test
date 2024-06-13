import 'package:anuncios_test/components/highlight_item.dart';
import 'package:anuncios_test/service/dados.dart';
import 'package:anuncios_test/model/empresa.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }
  final int _currentPage = 0;
  final Future<All> empresaLista = getAllCompany();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anúncios"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: FutureBuilder<All>(
          future: empresaLista,
          builder: (context, snapshot) {
            if (snapshot.hasData){

              List<Empresa> empresas = [];

              for(int i = 0; i < snapshot.data!.empresas.length; i++){
                empresas.add(Empresa(
                    imagem: snapshot.data!.empresas.elementAt(i).imagem,
                    categoria: snapshot.data!.empresas.elementAt(i).categoria,
                    nome: snapshot.data!.empresas.elementAt(i).nome,
                    descricao: snapshot.data!.empresas.elementAt(i).descricao,
                    numero: snapshot.data!.empresas.elementAt(i).numero)
                );
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Anúncio',
                          style: TextStyle(
                            fontFamily: "",
                            fontSize: 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    MediaQuery.of(context).orientation == Orientation.landscape ? LandscapeHighlightList(items: empresas) : PortraitHighlightList(items: empresas),
                  ],
                ),
              );
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error!.toString()),
              );
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
      ),
    );
  }
}

class PortraitHighlightList extends StatelessWidget {

  final List<Empresa> items;

  const PortraitHighlightList({super.key, required this.items});

  @override
  Widget build(BuildContext context){
    return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return HighlightItem(
              itemURI: items[index].imagem,
              itemCategory: items[index].categoria,
              itemTitle: items[index].nome,
              itemDescription: items[index].descricao,
              itemNumber: items[index].numero,
            );
          },
          childCount: items.length,
        )
    );
  }
}

class LandscapeHighlightList extends StatelessWidget {

  final List<Empresa> items;

  const LandscapeHighlightList({super.key, required this.items});

  @override
  Widget build(BuildContext context){
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return HighlightItem(
              itemURI: items[index].imagem,
              itemCategory: items[index].categoria,
              itemTitle: items[index].nome,
              itemDescription: items[index].descricao,
              itemNumber: items[index].numero
          );
        },
        childCount: items.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 380/328,
      ),
    );
  }
}