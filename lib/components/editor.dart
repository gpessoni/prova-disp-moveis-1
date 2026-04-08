import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType tipoTeclado;

  const Editor({
    super.key,
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
    this.tipoTeclado = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
          border: const OutlineInputBorder(),
        ),
        keyboardType: tipoTeclado,
      ),
    );
  }
}