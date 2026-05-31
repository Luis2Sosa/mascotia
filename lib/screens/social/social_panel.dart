import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_ui.dart';

// ─────────────────────────────────────────────
// MODELO POST
// ─────────────────────────────────────────────
class Post {
  final int     id;
  final String  author;
  final String  text;
  final String? imageAsset;

  const Post({
    required this.id,
    required this.author,
    required this.text,
    this.imageAsset,
  });
}

// ─────────────────────────────────────────────
// SOCIAL PANEL
// ─────────────────────────────────────────────
class SocialPanel extends StatefulWidget {
  final List<Post>            posts;
  final bool Function(int)    isLiked;
  final void Function(int)    onToggleLike;
  final List<String>?         petNames;
  final ValueChanged<String>? onPetChosen;

  const SocialPanel({
    super.key,
    required this.posts,
    required this.isLiked,
    required this.onToggleLike,
    this.petNames,
    this.onPetChosen,
  });

  /// Bottom sheet para elegir con qué mascota publicar
  static Future<String?> showPublishAsPicker(
      BuildContext context, {
        required List<String> petNames,
      }) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF10263E),
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32)),
          border: Border.all(
              color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .22),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Publicar como',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                ...petNames.map(
                      (name) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: .10),
                          Colors.white.withValues(alpha: .04),
                        ],
                      ),
                      border: Border.all(
                          color:
                          Colors.white.withValues(alpha: .08)),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: .10),
                        ),
                        child: const Icon(Icons.pets_rounded,
                            color: Colors.white),
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white.withValues(alpha: .55),
                        size: 16,
                      ),
                      onTap: () => Navigator.pop<String>(ctx, name),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<SocialPanel> createState() => _SocialPanelState();
}

class _SocialPanelState extends State<SocialPanel> {
  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 10, bottom: bottomSafe + 24),
      itemCount: widget.posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (context, index) {
        final p = widget.posts[index];
        return PostCard(
          id: p.id,
          author: p.author,
          text: p.text,
          imageAsset: p.imageAsset,
          liked: widget.isLiked(p.id),
          onToggleLike: () => widget.onToggleLike(p.id),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// POST CARD
// ─────────────────────────────────────────────
class PostCard extends StatelessWidget {
  final int      id;
  final String   author;
  final String   text;
  final String?  imageAsset;
  final bool     liked;
  final VoidCallback onToggleLike;

  const PostCard({
    super.key,
    required this.id,
    required this.author,
    required this.text,
    required this.imageAsset,
    required this.liked,
    required this.onToggleLike,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: .12),
                Colors.white.withValues(alpha: .05),
              ],
            ),
            border: Border.all(
                color: Colors.white.withValues(alpha: .08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .12),
                blurRadius: 24,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: .10),
                    ),
                    child: const Icon(Icons.pets_rounded,
                        color: Colors.white),
                  ),
                  Gaps.wm,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          author,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Hace unos minutos',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .55),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_horiz_rounded,
                      color: Colors.white.withValues(alpha: .45)),
                ],
              ),

              const SizedBox(height: 16),

              // ── Texto ──
              Text(
                text,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .92),
                  fontSize: 15,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // ── Imagen ──
              if (imageAsset != null) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(imageAsset!, fit: BoxFit.cover),
                ),
              ],

              const SizedBox(height: 16),

              // ── Acciones ──
              Row(
                children: [
                  _ActionButton(
                    icon: liked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    label: 'Me gusta',
                    active: liked,
                    onTap: onToggleLike,
                  ),
                  const SizedBox(width: 12),
                  _ActionButton(
                    icon: Icons.mode_comment_outlined,
                    label: 'Comentar',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BOTÓN ACCIÓN
// ─────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String   label;
  final bool     active;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active
          ? const Color(0xFFFF4D6D).withValues(alpha: .18)
          : Colors.white.withValues(alpha: .08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 10),
          child: Row(
            children: [
              Icon(
                icon,
                color: active
                    ? const Color(0xFFFF4D6D)
                    : Colors.white.withValues(alpha: .85),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .92),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}