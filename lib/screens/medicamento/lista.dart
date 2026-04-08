import 'package:flutter/material.dart';
import 'formulario.dart';
import '../../models/medicamento.dart';

class ListaMedicamentos extends StatefulWidget {
  const ListaMedicamentos({super.key});

  @override
  State<ListaMedicamentos> createState() => _ListaMedicamentosState();
}

class _ListaMedicamentosState extends State<ListaMedicamentos> {
  final List<Medicamento> _medicamentos = [];
  final TextEditingController _controladorBusca = TextEditingController();
  String _busca = '';

  static const _tituloAppBar = 'Meus Medicamentos';

  List<Medicamento> get _medicamentosFiltrados {
    if (_busca.isEmpty) return _medicamentos;
    return _medicamentos
        .where((m) => m.nome.toLowerCase().contains(_busca.toLowerCase()))
        .toList();
  }

  void _adicionar(Medicamento? medicamento) {
    if (medicamento != null) {
      setState(() => _medicamentos.add(medicamento));
    }
  }

  void _toggleTomado(Medicamento medicamento) {
    setState(() => medicamento.tomado = !medicamento.tomado);
  }

  void _abrirFormulario({Medicamento? medicamentoParaEditar}) {
    Navigator.push<Medicamento>(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioMedicamento(
          medicamentoParaEditar: medicamentoParaEditar,
        ),
      ),
    ).then((retorno) {
      if (retorno == null) return;
      if (medicamentoParaEditar != null) {
        setState(() {
          final indice = _medicamentos.indexOf(medicamentoParaEditar);
          retorno.tomado = medicamentoParaEditar.tomado;
          _medicamentos[indice] = retorno;
        });
      } else {
        _adicionar(retorno);
      }
    });
  }

  Future<void> _confirmarExclusao(Medicamento medicamento) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir medicamento'),
        content: Text('Deseja excluir "${medicamento.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      setState(() => _medicamentos.remove(medicamento));
    }
  }

  @override
  void dispose() {
    _controladorBusca.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtrados = _medicamentosFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _controladorBusca,
              decoration: const InputDecoration(
                hintText: 'Buscar medicamento...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) => setState(() => _busca = valor),
            ),
          ),
          Expanded(
            child: filtrados.isEmpty
                ? Center(
                    child: Text(
                      _medicamentos.isEmpty
                          ? 'Nenhum medicamento cadastrado.\nToque no + para adicionar.'
                          : 'Nenhum resultado para "$_busca".',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filtrados.length,
                    itemBuilder: (context, indice) {
                      final medicamento = filtrados[indice];
                      return ItemMedicamento(
                        medicamento,
                        onTomado: () => _toggleTomado(medicamento),
                        onEditar: () => _abrirFormulario(medicamentoParaEditar: medicamento),
                        onExcluir: () => _confirmarExclusao(medicamento),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ItemMedicamento extends StatelessWidget {
  final Medicamento _medicamento;
  final VoidCallback onTomado;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  const ItemMedicamento(
    this._medicamento, {
    super.key,
    required this.onTomado,
    required this.onEditar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: _medicamento.tomado ? Colors.teal.shade50 : null,
      child: ListTile(
        leading: Icon(
          Icons.medication,
          size: 40,
          color: _medicamento.tomado ? Colors.grey : Colors.teal,
        ),
        title: Text(
          _medicamento.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            decoration:
                _medicamento.tomado ? TextDecoration.lineThrough : null,
            color: _medicamento.tomado ? Colors.grey : null,
          ),
        ),
        subtitle: Text('Dosagem: ${_medicamento.dosagem}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time, size: 16),
                Text(
                  _medicamento.horario,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: Icon(
                _medicamento.tomado
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
                color: _medicamento.tomado ? Colors.teal : Colors.grey,
              ),
              onPressed: onTomado,
              tooltip: _medicamento.tomado ? 'Desmarcar' : 'Marcar como tomado',
            ),
            PopupMenuButton<String>(
              onSelected: (opcao) {
                if (opcao == 'editar') onEditar();
                if (opcao == 'excluir') onExcluir();
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'editar',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Editar'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'excluir',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Excluir', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
