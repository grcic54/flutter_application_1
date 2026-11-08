import 'package:flutter/material.dart';

import '../modeli/igre.dart';
import '../usluge/igre_usluga.dart';
import '../widgeti/servis_kartica.dart';
import 'detail_screen.dart';

class ListEkran extends StatefulWidget {
  const ListEkran({super.key});

  @override
  State<ListEkran> createState() => _ListEkranState();
}


class _ListEkranState extends State<ListEkran> {
  final _service = const IgreUsluga();
  late Future<List<Igre>> _igre;
  final _removed = <String>{}; 
  final _pinned = <String>{}; 

  @override
  void initState() {
    super.initState();
    _igre = _service.fetchIgre();
  }

  Future<void> _reload() {
    setState(() {
      _igre = _service.fetchIgre();
    });
    return _igre;
  }

   void _openDetail(Igre igra) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailScreen(igra: igra),
      ),
    );
  }



   void _togglePin(Igre igra) {
    setState(() {
      if (!_pinned.remove(igra.id)) _pinned.add(igra.id);
    });
  }


void _remove(Igre igra) {
    setState(() {
      _removed.add(igra.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Uklonjeno: ${igra.title}'),
        action: SnackBarAction(
          label: 'Poništi',
          onPressed: () {
            if (!mounted) return;
            setState(() {
              _removed.remove(igra.id);
            });
          },
        ),
      ),
    );
  }

Widget _buildList(List<Igre> igre) {
    final visible = igre.where((i) => !_removed.contains(i.id)).toList();

    if (visible.isEmpty) {
      return const Center(child: Text('Nema igara za prikaz'));
    }

    return RefreshIndicator(
      onRefresh: _reload,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: visible.length,
        itemBuilder: (context, index) {
          final igra = visible[index];
          return ServisKartica(
            igre: igra,
            pinned: _pinned.contains(igra.id),
            onTap: () => _openDetail(igra),
            onLongPress: () => _togglePin(igra),
            onDismissed: () => _remove(igra),
          );
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Igre')),
      body: FutureBuilder<List<Igre>>(
        future: _igre,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48),
                  const SizedBox(height: 12),
                  const Text('Provjeri internetsku vezu i pokušaj ponovno'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _reload,
                    child: Text('Pokušaj ponovno'),
                  ),
                ],
              ),
            );
          }
          return _buildList(snapshot.data!);
        },
      ),
    );
  }
}
