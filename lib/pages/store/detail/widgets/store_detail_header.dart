import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../models/stores/store_model.dart';



class StoreDetailHeader extends StatelessWidget {
  final StoreModel store;
  final bool isFollowing;
  final VoidCallback onToggleFollow;

  const StoreDetailHeader({
    super.key,
    required this.store,
    required this.isFollowing,
    required this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _HeaderImage(imageUrl: store.imagePath),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onToggleFollow,
              icon: Icon(isFollowing ? Icons.favorite : Icons.favorite_border),
              label: Text(isFollowing ? 'フォロー中' : 'フォローする'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing
                    ? AppColors.primary
                    : theme.colorScheme.surfaceContainerHighest,
                foregroundColor: isFollowing
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderImage extends StatelessWidget {
  final String imageUrl;

  const _HeaderImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 200,
      color: theme.colorScheme.surfaceContainerHighest,
      child: imageUrl.isNotEmpty
          ? Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _PlaceholderImage(),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      )
          : const _PlaceholderImage(),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  const _PlaceholderImage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Icon(
        Icons.store,
        size: 80,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
