import 'package:flutter/material.dart';

class OpcionesPage extends StatelessWidget {
  const OpcionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FotoFlu - Opciones')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Row(children: [Icon(Icons.settings), Text('Opciones')]),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Row(children: [Icon(Icons.settings), Text('Opciones')]),
            ),
          ],
        ),
      ),
    );
  }
}
