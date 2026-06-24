import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'item_cafe.dart';
import 'providers.dart';

class NewItemModal extends ConsumerStatefulWidget {
  const NewItemModal({super.key});

  @override
  ConsumerState<NewItemModal> createState() => _NewItemModalState();
}

class _NewItemModalState extends ConsumerState<NewItemModal> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = 'Cafés Especiais';
  DateTime? _selectedDate;
  bool _semGluten = true;

  final List<String> _categories = const [
    'Cafés Especiais',
    'Clássicos',
    'Doces',
    'Lanches',
    'Bebidas',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
      initialDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submit() {
    final name = _nameController.text.trim();
    final priceText = _priceController.text.trim().replaceAll(',', '.');
    final price = double.tryParse(priceText);

    if (name.isEmpty || price == null || price <= 0 || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha nome, preço positivo e data de lançamento.'),
        ),
      );
      return;
    }

    final newItem = CafeItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nome: name,
      preco: price,
      categoria: _selectedCategory,
      dataLancamento: _selectedDate!,
      semGluten: _semGluten,
      imagemUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    );

    ref.read(productsProvider.notifier).addProduct(newItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottomInset + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Cadastrar novo item',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nome do produto',
                prefixIcon: Icon(Icons.coffee),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Preço',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Categoria',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: _semGluten,
              onChanged: (value) {
                setState(() {
                  _semGluten = value;
                });
              },
              title: const Text('Sem glúten'),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _selectedDate == null
                    ? 'Selecionar data de lançamento'
                    : 'Data: ${_formatDate(_selectedDate!)}',
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.add),
              label: const Text('Cadastrar item'),
            ),
          ],
        ),
      ),
    );
  }
}