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
        // ─────────────────────────────────────────
        // CARD PRINCIPAL
        // ─────────────────────────────────────────
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hoy • 3:00 PM',
                style: Txt.small,
              ),

              Gaps.s,

              const Text(
                'Próxima vacunación',
                style: Txt.h2,
              ),

              Gaps.m,

              Text(
                'No olvides la vacuna anual de Rocky.',
                style: Txt.body,
              ),

              Gaps.l,

              Row(
                children: [
                  _MiniInfo(
                    icon: Icons.calendar_month_rounded,
                    label: '15 Mayo',
                  ),

                  Gaps.wm,

                  _MiniInfo(
                    icon: Icons.pets_rounded,
                    label: 'Rocky',
                  ),
                ],
              ),
            ],
          ),
        ),

        Gaps.xl,

        // ─────────────────────────────────────────
        // TÍTULO
        // ─────────────────────────────────────────
        const Text(
          'Próximos recordatorios',
          style: Txt.h2,
        ),

        Gaps.m,

        // ─────────────────────────────────────────
        // LISTA PREMIUM
        // ─────────────────────────────────────────
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          child: Column(
            children: const [
              _ReminderRow(
                icon: Icons.directions_walk_rounded,
                text: 'Paseo de la tarde',
                date: '5:00 PM',
              ),

              _GlassDivider(),

              _ReminderRow(
                icon: Icons.medication_rounded,
                text: 'Desparasitación',
                date: '1 Mayo',
              ),

              _GlassDivider(),

              _ReminderRow(
                icon: Icons.bathtub_rounded,
                text: 'Baño y limpieza',
                date: '20 Mayo',
              ),

              _GlassDivider(),

              _ReminderRow(
                icon: Icons.restaurant_rounded,
                text: 'Comprar alimento',
                date: '22 Mayo',
              ),
            ],
          ),
        ),

        Gaps.xl,

        // ─────────────────────────────────────────
        // CARD TIPS
        // ─────────────────────────────────────────
        GestureDetector(
          onTap: _noop,
          child: AppCard(
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(.16),
                        Colors.white.withOpacity(.05),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                  ),
                ),

                Gaps.wm,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Consejos para tu mascota',
                        style: Txt.h3,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Descubre tips personalizados de cuidado.',
                        style: Txt.small,
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withOpacity(.65),
                ),
              ],
            ),
          ),
        ),

        Gaps.xl,

        // ─────────────────────────────────────────
        // BOTÓN
        // ─────────────────────────────────────────
        AppButton(
          label: 'Añadir recordatorio',
          icon: Icons.add_rounded,
          onPressed: _noop,
        ),

        Gaps.l,
      ],
    );
  }
}

void _noop() {}

/// ─────────────────────────────────────────────
/// FILA DE RECORDATORIO
/// ─────────────────────────────────────────────
class _ReminderRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String date;

  const _ReminderRow({
    required this.icon,
    required this.text,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(.14),
                  Colors.white.withOpacity(.05),
                ],
              ),
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),

          Gaps.wm,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Txt.h3,
                ),

                const SizedBox(height: 3),

                Text(
                  'Recordatorio programado',
                  style: Txt.small,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),

              color: Colors.white.withOpacity(.08),
            ),

            child: Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// MINI INFO
/// ─────────────────────────────────────────────
class _MiniInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MiniInfo({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),

        color: Colors.white.withOpacity(.08),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white.withOpacity(.85),
          ),

          const SizedBox(width: 8),

          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// DIVIDER PREMIUM
/// ─────────────────────────────────────────────
class _GlassDivider extends StatelessWidget {
  const _GlassDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        height: 1,
        color: Colors.white.withOpacity(.08),
      ),
    );
  }
}