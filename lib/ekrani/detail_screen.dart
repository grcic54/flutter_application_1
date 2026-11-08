import 'package:flutter/material.dart';
import '../modeli/igre.dart';


class DetailScreen extends StatefulWidget {
  final Igre igra;

  const DetailScreen({super.key, required this.igra});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build (BuildContext context) {
    final igra = widget.igra;
    
    return Scaffold(appBar: AppBar(title: Text(igra.title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ListTile(title: Text(igra.title), subtitle: Text(igra.description)),
          ListTile(title: Text('Žanr'), subtitle: Text(igra.genre)),
          ListTile(title: Text('Platforma'), subtitle: Text(igra.platform)),
          ListTile(title: Text('Izdavač'), subtitle: Text(igra.publisher)),
          ListTile(title: Text('Razvijač'), subtitle: Text(igra.developer)),
          ListTile(title: Text('Datum izlaska'), subtitle: Text(igra.releaseDate)),
        ],

      )
      
      
      );

  

    }
  }
