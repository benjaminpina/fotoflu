import 'package:flutter/material.dart';
import 'package:fotoflu/ui/widgets/galeria.dart';
import 'package:fotoflu/ui/widgets/panel_inferior.dart';
import 'package:fotoflu/ui/widgets/panel_lateral.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FotoFlu')),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: Galeria()),
                SizedBox(height: 50, child: PanelInferior()),
              ],
            ),
          ),
          SizedBox(width: 300, height: double.infinity, child: PanelLateral()),
        ],
      ),
    );
  }
}
