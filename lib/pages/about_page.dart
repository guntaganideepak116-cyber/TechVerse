import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top + 56;
    final bottomPad = MediaQuery.of(context).padding.bottom + 72;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, topPad + 20, 16, bottomPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(context),
            const SizedBox(height: 24),
            _buildMission(context),
            const SizedBox(height: 24),
            _buildWhySection(context),
            const SizedBox(height: 24),
            _buildVersionCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
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
              const TextSpan(text: 'About '),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: const Text(
                    'TechVerse',
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
        const SizedBox(height: 10),
        const Text(
          'TechVerse is a dedicated platform for technology enthusiasts and students to explore, learn, and grow. Our mission is to simplify complex tech concepts and make them accessible to everyone, anywhere, anytime.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.mutedForegroundLight,
            height: 1.65,
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.08),
      ],
    );
  }

  Widget _buildMission(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLight.withOpacity(0.08),
            AppColors.accentLight.withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(LucideIcons.target,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'We believe that education should be barrier-free. By providing a curated, offline-first encyclopedia of modern technologies, we empower learners to stay ahead in the digital age without worrying about connectivity.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.mutedForegroundLight,
              height: 1.65,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 150.ms).scale(begin: const Offset(0.97, 0.97));
  }

  Widget _buildWhySection(BuildContext context) {
    const points = [
      {
        'title': 'Accessible Learning',
        'desc': 'Designed for accessibility and ease of use for everyone.',
      },
      {
        'title': 'Curated Content',
        'desc': 'In-depth guides on 25+ cutting-edge technologies.',
      },
      {
        'title': 'Premium Design',
        'desc': 'Beautiful, distraction-free environment for deep learning.',
      },
      {
        'title': '100% Offline',
        'desc': 'All content works without any internet connection.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Why We Built This',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        ...points.asMap().entries.map((entry) {
          final i = entry.key;
          final p = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(LucideIcons.check,
                      color: Colors.white, size: 10),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        p['desc']!,
                        style: const TextStyle(
                          color: AppColors.mutedForegroundLight,
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: (200 + i * 60).ms).slideX(begin: 0.06);
        }),
      ],
    );
  }

  Widget _buildVersionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'TechVerse v1.0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Built with Flutter • 100% Offline • 25+ Technologies\nMade with ❤️ for learners everywhere.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.08);
  }
}
