import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';
import 'package:get/state_manager.dart';

class PanelInferior extends GetView<PanelInferiorController> {
  const PanelInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
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
      child: Placeholder(child: const Text('Controles de Navegación')),
    );
  }
}

class _BarraNavegacion extends StatelessWidget {
  const _BarraNavegacion();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Placeholder(child: const Text('Barra Navegación')),
    );
  }
}
