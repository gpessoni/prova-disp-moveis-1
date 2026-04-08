class Medicamento {
  final String nome;
  final String dosagem;
  final String horario;
  bool tomado;

  Medicamento(this.nome, this.dosagem, this.horario) : tomado = false;

  @override
  String toString() {
    return 'Medicamento{nome: $nome, dosagem: $dosagem, horario: $horario, tomado: $tomado}';
  }
}
