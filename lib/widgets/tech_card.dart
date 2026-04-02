import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/tech_model.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';

class TechCard extends ConsumerStatefulWidget {
  final TechModel tech;
  final int index;

  const TechCard({super.key, required this.tech, required this.index});

  @override
  ConsumerState<TechCard> createState() => _TechCardState();
}

class _TechCardState extends ConsumerState<TechCard> {
  bool _isHovering = false;
  double _rotateX = 0;
  double _rotateY = 0;

  void _handlePointerMove(PointerEvent event, BoxConstraints constraints) {
    if (!context.mounted) return;
    
    // Tilt calculation
    final x = event.localPosition.dx / constraints.maxWidth;
    final y = event.localPosition.dy / constraints.maxHeight;
    
    setState(() {
      _rotateX = (y - 0.5) * -0.2; // roughly -20 degrees mapping
      _rotateY = (x - 0.5) * 0.2; // roughly 20 degrees mapping
      _isHovering = true;
    });
  }

  void _handlePointerExit(PointerEvent event) {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _isHovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookmarked = ref.watch(bookmarkProvider).contains(widget.tech.id);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: _handlePointerExit,
      onHover: (e) => _handlePointerMove(e, const BoxConstraints(maxWidth: 200, maxHeight: 200)), // Approximate, fixed in build
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Listener(
            onPointerMove: (e) => _handlePointerMove(e, constraints),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 200),
              tween: Tween(begin: 0, end: _isHovering ? 1.04 : 1.0),
              builder: (context, scale, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002) // Perspective
                    ..rotateX(_rotateX)
                    ..rotateY(_rotateY)
                    ..scaleByDouble(scale, scale, 1.0, 1.0),
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: () => context.go('/tech/${widget.tech.id}'),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).dividerColor),
                    boxShadow: _isHovering ? AppColors.cardShadowHover(isDark) : AppColors.cardShadow(isDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Header
                      Stack(
                        children: [
                          SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: Image.asset(
                              widget.tech.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Gradient Overlay
                          Positioned.fill(
                             child: Container(
                               decoration: BoxDecoration(
                                 gradient: LinearGradient(
                                   begin: Alignment.bottomCenter,
                                   end: Alignment.topCenter,
                                   colors: [
                                      Theme.of(context).cardColor.withValues(alpha: 0.8),
                                      Colors.transparent,
                                   ],
                                 ),
                               ),
                             ),
                          ),
                          // Heart Button
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () => ref.read(bookmarkProvider.notifier).toggleBookmark(widget.tech.id),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  child: Icon(
                                    LucideIcons.heart,
                                    size: 14,
                                    color: bookmarked ? Colors.red : Colors.white,
                                    fill: bookmarked ? 1.0 : 0.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.tech.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getDifficultyColor(widget.tech.difficulty, isDark).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.tech.difficulty,
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800,
                                      color: _getDifficultyColor(widget.tech.difficulty, isDark),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.tech.tagline,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.mutedForegroundLight,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ).animate().slideY(begin: 0.1, duration: 400.ms, delay: (widget.index * 50).ms).fadeIn(),
    );
  }

  Color _getDifficultyColor(String diff, bool isDark) {
    switch (diff) {
      case 'Beginner':
        return AppColors.accentLight;
      case 'Intermediate':
        return AppColors.primaryLight;
      case 'Advanced':
        return Colors.redAccent;
      default:
        return AppColors.primaryLight;
    }
  }
}
