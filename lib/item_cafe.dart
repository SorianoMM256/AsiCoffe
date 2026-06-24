class CafeItem {
  final String id;
  final String nome;
  final double preco;
  final String imagemUrl;
  final String categoria;
  final DateTime dataLancamento;
  final bool semGluten;

  const CafeItem({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagemUrl,
    required this.categoria,
    required this.dataLancamento,
    required this.semGluten,
  });
}