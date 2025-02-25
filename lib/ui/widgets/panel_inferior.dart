import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';
import 'package:get/state_manager.dart';

class PanelInferior extends GetView<PanelInferiorController> {
  const PanelInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Column(children: [_ControlesNavegacion(), _BarraNavegacion()]),
    );
  }
}

class _ControlesNavegacion extends StatelessWidget {
  const _ControlesNavegacion();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
          IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () {}),
          IconButton(icon: const Icon(Icons.check), onPressed: () {}),
          IconButton(icon: const Icon(Icons.close), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
          SizedBox(width: 20),
          IconButton(icon: const Icon(Icons.rotate_left), onPressed: () {}),
          IconButton(icon: const Icon(Icons.rotate_right), onPressed: () {}),
          SizedBox(width: 20),
          IconButton(icon: const Icon(Icons.zoom_in), onPressed: () {}),
          IconButton(icon: const Icon(Icons.zoom_out), onPressed: () {}),
        ],
      ),
    );
  }
}

class _BarraNavegacion extends StatelessWidget {
  const _BarraNavegacion();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Slider(value: 20, max: 100, onChanged: (double value) {}),
    );
  }
}
