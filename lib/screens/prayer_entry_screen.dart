import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/prayer_entry.dart';
import '../services/prayer_service.dart';
import '../theme/app_theme.dart';
import '../theme/app_decorations.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Escreva um título antes de salvar.')));
      return;
    }

    AppHaptics.tap();

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(_isEditing ? 'Editar' : 'Novo Registro', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600, fontSize: 19)),
        actions: [
          IconButton(
            icon: Icon(_favorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              AppHaptics.select();
              setState(() => _favorite = !_favorite);
            },
          ),
          if (_isEditing) IconButton(icon: const Icon(Icons.delete_outline), onPressed: _delete),
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
                selectedColor: AppColors.gold,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(color: selected ? Colors.white : AppColors.ink, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: AppColors.goldSoft)),
                onSelected: (_) {
                  AppHaptics.select();
                  setState(() => _category = c);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Título')),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            maxLines: 6,
            decoration: const InputDecoration(labelText: 'Descrição (opcional)', alignLabelWithHint: true),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
            child: SwitchListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Marcar como respondido'),
              value: _answered,
              activeColor: AppColors.gold,
              onChanged: (v) {
                AppHaptics.select();
                setState(() => _answered = v);
              },
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _save, child: const Text('Salvar')),
        ],
      ),
    );
  }
}
