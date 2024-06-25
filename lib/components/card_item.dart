import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.itemURI, required this.itemCategory, required this.itemTitle, required this.itemDescription, required this.itemNumber});
  final String itemURI;
  final String itemCategory;
  final String itemTitle;
  final String itemDescription;
  final String itemNumber;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final double imageHeight = 100;
  final double imageWidth = 100;

  var whatappUrl = "https://wa.me/";

  Future<void> _launchInBrowser(Uri url) async {
    if(!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      elevation: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            widget.itemURI,
            errorBuilder: (BuildContext context,
                Object exception, StackTrace? stackTrace) {
              return Image.asset('assets/images/drink.png', height: imageHeight, width: imageWidth, fit: BoxFit.fitHeight,);
            },
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: SizedBox(
              height: imageHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.itemTitle,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(widget.itemDescription)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: InkWell(
                onTap: () => setState(() {

                  final Uri toLaunch = Uri(scheme: 'https', host: 'wa.me', path:'/${widget.itemNumber}');

                  _launchInBrowser(toLaunch);
                }),
                child: const Image(
                  image: AssetImage("assets/images/WhatsApp-icone.png"),
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
