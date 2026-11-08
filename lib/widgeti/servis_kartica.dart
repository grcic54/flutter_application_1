import 'package:flutter/material.dart';
import '../modeli/igre.dart';

class ServisKartica extends StatelessWidget {
  final Igre igre;
  final bool pinned;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDismissed;

const ServisKartica({
    super.key,
    required this.igre,
    required this.pinned,
    required this.onTap,
    required this.onLongPress,
    required this.onDismissed
});


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(igre.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDismissed();
      },
      background: Container(color: Colors.red, 
      alignment: Alignment.centerRight,padding: EdgeInsets.all(24), 
      child: Icon(Icons.delete,color: Colors.white)), child: ListTile(
      title: Text(igre.title),
      subtitle: Text(igre.description),
      trailing: AnimatedScale(
        scale: pinned ? 1 : 0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: const Icon(Icons.push_pin),
      ),  
      onTap: onTap,
      onLongPress: onLongPress,
    ));
    
  }













}