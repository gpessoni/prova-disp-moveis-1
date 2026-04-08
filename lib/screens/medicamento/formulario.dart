import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/medicamento.dart';

class FormularioMedicamento extends StatefulWidget {
  final Medicamento? medicamentoParaEditar;

  const FormularioMedicamento({super.key, this.medicamentoParaEditar});

  @override
  State<FormularioMedicamento> createState() => _FormularioMedicamentoState();
}

class _FormularioMedicamentoState extends State<FormularioMedicamento> {
  late final TextEditingController _controladorNome;
  late final TextEditingController _controladorDosagem;
  late final TextEditingController _controladorHorario;

  bool get _modoEdicao => widget.medicamentoParaEditar != null;

  @override
  void initState() {
    super.initState();
    final m = widget.medicamentoParaEditar;
    _controladorNome = TextEditingController(text: m?.nome ?? '');
    _controladorDosagem = TextEditingController(text: m?.dosagem ?? '');
    _controladorHorario = TextEditingController(text: m?.horario ?? '');
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    _controladorDosagem.dispose();
    _controladorHorario.dispose();
    super.dispose();
  }

  void _salvar() {
    final nome = _controladorNome.text.trim();
    final dosagem = _controladorDosagem.text.trim();
    final horario = _controladorHorario.text.trim();

    if (nome.isEmpty || dosagem.isEmpty || horario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

    final medicamento = Medicamento(nome, dosagem, horario);
    debugPrint('${_modoEdicao ? "Editando" : "Cadastrando"} medicamento: $medicamento');
    Navigator.pop(context, medicamento);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modoEdicao ? 'Editar Medicamento' : 'Cadastrar Medicamento'),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Editor(
              controlador: _controladorNome,
              rotulo: 'Nome do Medicamento',
              dica: 'Ex: Paracetamol',
              icone: Icons.medication,
            ),
            Editor(
              controlador: _controladorDosagem,
              rotulo: 'Dosagem',
              dica: 'Ex: 500mg',
              icone: Icons.science,
            ),
            Editor(
              controlador: _controladorHorario,
              rotulo: 'Horário',
              dica: 'Ex: 08:00',
              icone: Icons.access_time,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: ElevatedButton(
                  onPressed: _salvar,
                  child: Text(_modoEdicao ? 'Salvar' : 'Cadastrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
