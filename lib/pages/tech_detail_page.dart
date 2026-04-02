import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/technologies.dart';
import '../models/tech_model.dart';
import '../widgets/section_card.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';

class TechDetailPage extends ConsumerWidget {
  final String id;

  const TechDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tech = technologies.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception('Not Found'),
    );
    final bookmarks = ref.watch(bookmarkProvider);
    final isBookmarked = bookmarks.contains(id);

    final sections = [
      {
        'title': 'What is it?',
        'icon': const Icon(LucideIcons.lightbulb),
        'content': tech.description
      },
      {
        'title': 'How it works',
        'icon': const Icon(LucideIcons.cog),
        'content': tech.working
      },
      {
        'title': 'Real-world Applications',
        'icon': const Icon(LucideIcons.globe),
        'content': tech.applications
      },
      {
        'title': 'Advantages',
        'icon': const Icon(LucideIcons.thumbsUp),
        'content': tech.advantages
      },
      {
        'title': 'Disadvantages',
        'icon': const Icon(LucideIcons.thumbsDown),
        'content': tech.disadvantages
      },
      {
        'title': 'Future Scope',
        'icon': const Icon(LucideIcons.rocket),
        'content': tech.futureScope
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBanner(context, tech, isBookmarked, ref),
            _buildTitleArea(context, tech),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: Column(
                children: sections.asMap().entries.map((entry) => SectionCard(
                      title: entry.value['title'] as String,
                      icon: entry.value['icon'] as Widget,
                      content: entry.value['content'] as String,
                      index: entry.key,
                    )).toList(),
              ),
            ),
            // Bottom spacing for safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(
      BuildContext context, TechModel tech, bool isBookmarked, WidgetRef ref) {
    final topPad = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // Hero image
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.asset(tech.image, fit: BoxFit.cover),
        ).animate().scale(duration: 400.ms).fadeIn(),

        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context)
                      .scaffoldBackgroundColor
                      .withValues(alpha: 0.25),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),

        // ← Back to home button
        Positioned(
          top: topPad + 12,
          left: 16,
          child: Material(
            color: Colors.black45,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/home');
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(LucideIcons.arrowLeft,
                    color: Colors.white, size: 20),
              ),
            ),
          ),
        ),

        // ♥ Bookmark button
        Positioned(
          top: topPad + 12,
          right: 16,
          child: Material(
            color: isBookmarked
                ? Colors.red.withValues(alpha: 0.85)
                : Colors.black45,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () =>
                  ref.read(bookmarkProvider.notifier).toggleBookmark(tech.id),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  isBookmarked ? LucideIcons.heart : LucideIcons.heart,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ).animate(target: isBookmarked ? 1 : 0).scale(
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
                duration: 200.ms,
              ),
        ),
      ],
    );
  }

  Widget _buildTitleArea(BuildContext context, TechModel tech) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, -36, 20, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: Theme.of(context).dividerColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  tech.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.primaryLight.withValues(alpha: 0.3)),
                ),
                child: Text(
                  tech.difficulty,
                  style: const TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            tech.tagline,
            style: const TextStyle(
              color: AppColors.mutedForegroundLight,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.secondaryDark
                  : AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              tech.category,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.primaryDark
                    : AppColors.primaryLight,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.1, duration: 400.ms, delay: 100.ms).fadeIn();
  }
}
