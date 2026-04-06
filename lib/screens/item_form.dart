import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';

class ItemForm extends StatefulWidget {
  final ItemService service;
  final Item? existing;

  const ItemForm({super.key, required this.service, this.existing});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _qtyCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _catCtrl;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill fields when editing an existing item
    _nameCtrl = TextEditingController(text: widget.existing?.name ?? '');
    _qtyCtrl = TextEditingController(
        text: widget.existing?.quantity.toString() ?? '');
    _priceCtrl = TextEditingController(
        text: widget.existing?.price.toString() ?? '');
    _catCtrl = TextEditingController(text: widget.existing?.category ?? '');
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _nameCtrl.dispose();
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    _catCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final item = Item(
      id: widget.existing?.id ?? '',
      name: _nameCtrl.text.trim(),
      quantity: int.parse(_qtyCtrl.text.trim()),
      price: double.parse(_priceCtrl.text.trim()),
      category: _catCtrl.text.trim(),
    );

    if (widget.existing == null) {
      await widget.service.addItem(item);
    } else {
      await widget.service.updateItem(item);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEdit ? 'Edit Item' : 'Add Item',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _qtyCtrl,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Quantity is required';
                final n = int.tryParse(v);
                if (n == null || n < 0) return 'Enter a valid whole number';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceCtrl,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Price is required';
                final d = double.tryParse(v);
                if (d == null || d < 0) return 'Enter a valid price';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _catCtrl,
              decoration:
                  const InputDecoration(labelText: 'Category (optional)'),
            ),
            const SizedBox(height: 20),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submit,
                    child: Text(isEdit ? 'Update' : 'Add Item'),
                  ),
          ],
        ),
      ),
    );
  }
}