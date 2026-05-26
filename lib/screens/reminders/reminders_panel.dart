import 'package:flutter/material.dart';
import '../../core/app_ui.dart';

class RemindersPanel extends StatelessWidget {
  const RemindersPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        const AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hoy 15:00', style: Txt.small),
              Gaps.s,
              Text('Próxima vacunación', style: Txt.h2),
            ],
          ),
        ),
        Gaps.l,
        const Text('Próximas', style: Txt.h2),
        Gaps.m,
        const AppCard(
          child: Column(
            children: [
              _ReminderRow(icon: Icons.directions_walk, text: 'Paseo (tarde)', date: '5:00 p.m.'),
              Divider(),
              _ReminderRow(icon: Icons.medication, text: 'Desparasitación', date: '1 mayo'),
              Divider(),
              _ReminderRow(icon: Icons.bathtub, text: 'Baño', date: '20 mayo'),
            ],
          ),
        ),
        Gaps.l,
        AppButton(label: 'Añadir recordatorio', onPressed: _noop),
        Gaps.m,
      ],
    );
  }
}

void _noop() {}

class _ReminderRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String date;
  const _ReminderRow({required this.icon, required this.text, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        Gaps.wm,
        Expanded(child: Text(text, style: Txt.body)),
        Text(date, style: Txt.small),
      ],
    );
  }
}