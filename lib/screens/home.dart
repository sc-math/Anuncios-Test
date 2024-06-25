import 'package:anuncios_test/components/card_item.dart';
import 'package:anuncios_test/service/dados.dart';
import 'package:anuncios_test/model/company.dart';
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
  Future<All> companyList = getAllCompany();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anúncios"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        actions: [
          IconButton(onPressed: (){
            companyList = getAllCompany();
            setState(() {
            });
          }, icon: const Icon(Icons.update))
        ],
      ),
      body: FutureBuilder<All>(
          future: companyList,
          builder: (context, snapshot) {
            if (snapshot.hasData){

              List<Company> companies = [];

              for(int i = 0; i < snapshot.data!.companies.length; i++){
                companies.add(Company(
                    image: snapshot.data!.companies.elementAt(i).image,
                    category: snapshot.data!.companies.elementAt(i).category,
                    name: snapshot.data!.companies.elementAt(i).name,
                    description: snapshot.data!.companies.elementAt(i).description,
                    number: snapshot.data!.companies.elementAt(i).number)
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
                          MediaQuery.of(context).orientation == Orientation.landscape ? LandscapeHighlightList(items: companies) : PortraitHighlightList(items: companies),
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

  final List<Company> items;

  const PortraitHighlightList({super.key, required this.items});

  @override
  Widget build(BuildContext context){
    return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return CardItem(
              itemURI: items[index].image,
              itemCategory: items[index].category,
              itemTitle: items[index].name,
              itemDescription: items[index].description,
              itemNumber: items[index].number,
            );
          },
          childCount: items.length,
        )
    );
  }
}

class LandscapeHighlightList extends StatelessWidget {

  final List<Company> items;

  const LandscapeHighlightList({super.key, required this.items});

  @override
  Widget build(BuildContext context){
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return CardItem(
              itemURI: items[index].image,
              itemCategory: items[index].category,
              itemTitle: items[index].name,
              itemDescription: items[index].description,
              itemNumber: items[index].number
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