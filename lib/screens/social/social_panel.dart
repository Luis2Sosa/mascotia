import 'package:flutter/material.dart';
import '../../core/app_ui.dart';
import '../../core/theme/app_theme.dart';

/// ——— Modelo simple de Post (usado por HomeScreen)
class Post {
  final int id;
  final String author;
  final String text;
  final String? imageAsset;
  const Post({
    required this.id,
    required this.author,
    required this.text,
    this.imageAsset,
  });
}

/// ——— Panel Social: SOLO el feed scrollea (sin “publicar como” visible aquí)
class SocialPanel extends StatefulWidget {
  final List<Post> posts;
  final bool Function(int id) isLiked;
  final void Function(int id) onToggleLike;

  /// Opcional: nombres de mascotas disponibles para publicar (para el picker)
  final List<String>? petNames;

  /// Opcional: callback para avisar qué mascota eligió el usuario
  final ValueChanged<String>? onPetChosen;

  const SocialPanel({
    super.key,
    required this.posts,
    required this.isLiked,
    required this.onToggleLike,
    this.petNames,
    this.onPetChosen,
  });

  /// LLÁMALO desde tu FAB en Home:
  /// final name = await SocialPanel.showPublishAsPicker(context, petNames: ['Rocky','Luna']);
  /// if (name != null) { /* setState perfil activo y abrir flujo de foto */ }
  static Future<String?> showPublishAsPicker(
      BuildContext context, {
        required List<String> petNames,
      }) async {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12, borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Publicar como', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                const SizedBox(height: 10),
                ...petNames.map((name) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    radius: 16, backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.pets, color: Colors.black54, size: 18),
                    ),
                  ),
                  title: Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  onTap: () => Navigator.pop<String>(context, name),
                )),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  State<SocialPanel> createState() => _SocialPanelState();
}

class _SocialPanelState extends State<SocialPanel> {
  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return ClipRRect(
      // bordes suaves arriba para fundirse con el fondo
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        // transparente para NO crear “franja” oscura al hacer scroll
        color: Colors.transparent,
        child: ListView.separated(
          // rebote tipo trampolín
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          // pegado a la barra de tabs
          padding: EdgeInsets.only(top: 8, bottom: bottomSafe + 16),
          itemCount: widget.posts.length,
          separatorBuilder: (_, __) => Gaps.m,
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
        ),
      ),
    );
  }
}

/// ——— Tarjeta de publicación
class PostCard extends StatelessWidget {
  final int id;
  final String author;
  final String text;
  final String? imageAsset;
  final bool liked;
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
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera del post
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.black12,
                child: Icon(Icons.pets, color: Colors.black54),
              ),
              Gaps.wm,
              Text(author, style: Txt.h3),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Colors.black38),
            ],
          ),
          Gaps.s,
          Text(text, style: Txt.body),

          // Imagen (opcional)
          if (imageAsset != null) ...[
            Gaps.m,
            ClipRRect(
              borderRadius: AppTheme.cardRadius,
              child: Image.asset(
                imageAsset!,
                fit: BoxFit.cover,
                // cacheWidth: 1080, // opcional si las imágenes son grandes
              ),
            ),
          ],

          Gaps.m,
          // Acciones
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.mode_comment_outlined),
                onPressed: () {
                  // Aquí luego abres pantalla de comentarios
                },
                tooltip: 'Comentar',
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onToggleLike,
                child: Row(
                  children: [
                    Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: liked ? Colors.red : Colors.black54,
                    ),
                    const SizedBox(width: 6),
                    const Text('Me gusta', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}