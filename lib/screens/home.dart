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
  Future<All> empresaLista = getAllCompany();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anúncios"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        actions: [
          IconButton(onPressed: (){
            empresaLista = getAllCompany();
            setState(() {
            });
          }, icon: const Icon(Icons.update))
        ],
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

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Container(
                      color: Colors.deepPurpleAccent,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: const Center(child: Text("<Filtro de Categorias>")),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: CustomScrollView(
                        shrinkWrap: true,
                        slivers: <Widget>[
                          MediaQuery.of(context).orientation == Orientation.landscape ? LandscapeHighlightList(items: empresas) : PortraitHighlightList(items: empresas),
                        ],
                      ),
                    ),
                  ),
                ],
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