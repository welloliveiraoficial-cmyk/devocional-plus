import 'package:flutter/material.dart';
import '../models/prayer_entry.dart';
import '../services/prayer_service.dart';
import '../theme/app_theme.dart';

class PrayerEntryScreen extends StatefulWidget {
  final PrayerEntry? entry;
  const PrayerEntryScreen({super.key, this.entry});

  @override
  State<PrayerEntryScreen> createState() => _PrayerEntryScreenState();
}

class _PrayerEntryScreenState extends State<PrayerEntryScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _category = 'Pedido';
  bool _answered = false;
  bool _favorite = false;

  bool get _isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _titleController.text = widget.entry!.title;
      _descController.text = widget.entry!.description;
      _category = widget.entry!.category;
      _answered = widget.entry!.answered;
      _favorite = widget.entry!.favorite;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escreva um título antes de salvar.')),
      );
      return;
    }

    if (_isEditing) {
      final updated = widget.entry!.copyWith(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        category: _category,
        answered: _answered,
        favorite: _favorite,
      );
      await PrayerService.update(updated);
    } else {
      final entry = PrayerEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        category: _category,
        createdAt: DateTime.now(),
        answered: _answered,
        favorite: _favorite,
      );
      await PrayerService.add(entry);
    }

    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Excluir')),
        ],
      ),
    );
    if (confirm == true) {
      await PrayerService.delete(widget.entry!.id);
      if (mounted) Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar' : 'Novo Registro'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_favorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () => setState(() => _favorite = !_favorite),
          ),
          if (_isEditing)
            IconButton(icon: const Icon(Icons.delete_outline), onPressed: _delete),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 8,
            children: ['Pedido', 'Agradecimento', 'Testemunho'].map((c) {
              final selected = _category == c;
              return ChoiceChip(
                label: Text(c),
                selected: selected,
                selectedColor: AppColors.bronze,
                labelStyle: TextStyle(color: selected ? Colors.white : AppColors.navy),
                onSelected: (_) => setState(() => _category = c),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            maxLines: 6,
            decoration: const InputDecoration(labelText: 'Descrição (opcional)', border: OutlineInputBorder(), alignLabelWithHint: true),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Marcar como respondido'),
            value: _answered,
            activeColor: AppColors.bronze,
            onChanged: (v) => setState(() => _answered = v),
          ),
          const SizedBox(height: 20),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.bronze, padding: const EdgeInsets.symmetric(vertical: 14)),
            onPressed: _save,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
