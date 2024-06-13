// import 'package:anuncios_test/dados.dart';
// import 'package:anuncios_test/model/empresa.dart';
// import 'package:flutter/material.dart';
// import 'home.dart';
// import '../components/highlight_item.dart';
//
// class Highlights extends StatelessWidget {
//   const Highlights({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//         child: CustomScrollView(
//           slivers: <Widget>[
//             const SliverToBoxAdapter(
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: 16),
//                 child: Text(
//                   'Anúncio',
//                   style: TextStyle(
//                     fontFamily: "",
//                     fontSize: 32,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             MediaQuery.of(context).orientation == Orientation.landscape ? _landscapeList() : _portraitList(),
//           ],
//         ),
//     );
//   }
// }
//
// class _portraitList extends StatelessWidget {
//   _portraitList({super.key});
//
//   List<Empresa> items = all as List<Empresa>;
//
//   @override
//   Widget build(BuildContext context){
//     return SliverList(
//         delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               return HighlightItem(
//                 itemURI: items[index].imagem,
//                 itemCategory: items[index].categoria,
//                 itemTitle: items[index].nome,
//                 itemDescription: items[index].descricao,
//                 itemNumber: items[index].numero,
//               );
//             },
//           childCount: items.length,
//         )
//     );
//   }
// }
//
// class _landscapeList extends StatelessWidget {
//   _landscapeList({super.key});
//
//   List<Empresa> items = all as List<Empresa>;
//
//   @override
//   Widget build(BuildContext context){
//     return SliverGrid(
//       delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               return HighlightItem(
//                 itemURI: items[index].imagem,
//                 itemCategory: items[index].categoria,
//                 itemTitle: items[index].nome,
//                 itemDescription: items[index].descricao,
//                 itemNumber: items[index].numero
//               );
//             },
//         childCount: items.length,
//       ),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//           childAspectRatio: 380/328,
//       ),
//     );
//   }
// }