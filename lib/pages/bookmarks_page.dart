import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/technologies.dart';
import '../widgets/tech_card.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarkProvider);
    final filtered =
        technologies.where((t) => bookmarkedIds.contains(t.id)).toList();

    final topPad = MediaQuery.of(context).padding.top + 56;
    final bottomPad = MediaQuery.of(context).padding.bottom + 72;

    return Scaffold(
      body: filtered.isEmpty
          ? _buildEmptyState(context, topPad, bottomPad)
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, topPad + 20, 16, 0),
                  sliver: SliverToBoxAdapter(child: _buildHero(context, filtered.length)),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) =>
                          TechCard(tech: filtered[index], index: index),
                      childCount: filtered.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.82,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHero(BuildContext context, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              color: Theme.of(context).textTheme.displayLarge?.color,
            ),
            children: [
              const TextSpan(text: 'Your '),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: const Text(
                    'Bookmarks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(),
        const SizedBox(height: 6),
        Text(
          '$count saved ${count == 1 ? 'technology' : 'technologies'} — available offline.',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.mutedForegroundLight,
            height: 1.5,
          ),
        ).animate().fadeIn(delay: 80.ms).slideY(begin: 0.08),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildEmptyState(
      BuildContext context, double topPad, double bottomPad) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            32, topPad, 32, bottomPad),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).dividerColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: const Icon(
                LucideIcons.heart,
                size: 40,
                color: AppColors.mutedForegroundLight,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Bookmarks Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore technologies and tap the\nheart icon to save them here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.mutedForegroundLight,
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ],
        ).animate().fadeIn().scale(begin: const Offset(0.85, 0.85)),
      ),
    );
  }
}
