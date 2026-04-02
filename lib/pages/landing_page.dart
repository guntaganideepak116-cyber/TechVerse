import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: AppBar(
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
              elevation: 0,
              centerTitle: false,
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      child: const Text(
                        'TechVerse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go('/home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Explore Now',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              shape: Border(
                  bottom:
                      BorderSide(color: Theme.of(context).dividerColor)),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(context),
            _buildStats(context),
            _buildFeatures(context),
            _buildWhyTechVerse(context),
            _buildCTA(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: screenHeight * 0.72,
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context)
                    .scaffoldBackgroundColor
                    .withOpacity(0.5),
                Colors.transparent,
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
          child: Image.asset(
            'assets/landing-hero.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color:
                              AppColors.primaryLight.withOpacity(0.4)),
                    ),
                    child: const Text(
                      '✨ YOUR OFFLINE TECH ENCYCLOPEDIA',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ).animate().scale(duration: 500.ms, delay: 200.ms).fadeIn(),
                  const SizedBox(height: 20),
                  // Title — all white, centered, no overflow
                  const Text(
                    'Learn Modern Tech,\nAnytime, Anywhere',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.2,
                      height: 1.25,
                    ),
                  ).animate().slideY(begin: 0.2, duration: 800.ms).fadeIn(),
                  const SizedBox(height: 16),
                  // Subtitle
                  Text(
                    'A beautifully crafted, fully offline encyclopedia of 25+ technologies. No internet needed — just pure knowledge.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.85),
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ).animate()
                      .slideY(begin: 0.2, duration: 800.ms, delay: 200.ms)
                      .fadeIn(),
                  const SizedBox(height: 28),
                  // CTA Button
                  ElevatedButton(
                    onPressed: () => context.go('/home'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 16),
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      shadowColor:
                          AppColors.primaryLight.withOpacity(0.4),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Start Exploring',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(width: 8),
                        Icon(LucideIcons.arrowRight, size: 18),
                      ],
                    ),
                  ).animate()
                      .slideY(begin: 0.3, duration: 700.ms, delay: 400.ms)
                      .fadeIn(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    final stats = [
      {'value': '25+', 'label': 'Technologies'},
      {'value': '6', 'label': 'Categories'},
      {'value': '100%', 'label': 'Offline'},
      {'value': 'Free', 'label': 'Forever'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
            bottom:
                BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats
            .map((stat) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      child: Text(
                        stat['value']!,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stat['label']!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.mutedForegroundLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final features = [
      {
        'icon': LucideIcons.brain,
        'title': 'AI & Machine Learning',
        'desc': 'Deep dive into neural networks, deep learning, and automation.'
      },
      {
        'icon': LucideIcons.shield,
        'title': 'Cybersecurity',
        'desc': 'Understand threats, encryption, and digital safety.'
      },
      {
        'icon': LucideIcons.cloud,
        'title': 'Cloud & Edge',
        'desc': 'Explore cloud computing, serverless, and edge processing.'
      },
      {
        'icon': LucideIcons.wifi,
        'title': 'IoT & 5G',
        'desc': 'Learn how billions of devices connect seamlessly.'
      },
      {
        'icon': LucideIcons.barChart3,
        'title': 'Data Science',
        'desc': 'Master big data, analytics, and data-driven decisions.'
      },
      {
        'icon': LucideIcons.zap,
        'title': 'Blockchain & Web3',
        'desc': 'Discover decentralized systems and the future web.'
      },
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).textTheme.displayLarge?.color,
                letterSpacing: -1,
              ),
              children: [
                const TextSpan(text: "What You'll "),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: const Text(
                      'Discover',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'From AI to blockchain, explore technologies\nshaping our future.',
            style: TextStyle(
              color: AppColors.mutedForegroundLight,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final feat = features[index];
              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                      color: Theme.of(context).dividerColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(feat['icon'] as IconData,
                          color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feat['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            feat['desc'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.mutedForegroundLight,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate()
                  .slideX(begin: -0.05, delay: (index * 60).ms)
                  .fadeIn();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWhyTechVerse(BuildContext context) {
    final items = [
      {
        'icon': LucideIcons.bookOpen,
        'title': 'Beginner Friendly',
        'desc': 'Simple explanations anyone can understand. No jargon.'
      },
      {
        'icon': LucideIcons.star,
        'title': 'Premium Design',
        'desc': 'Clean, modern UI with smooth animations and dark mode.'
      },
      {
        'icon': LucideIcons.users,
        'title': 'Made for Students',
        'desc': 'Perfect for learners, researchers, and curious minds.'
      },
    ];

    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).textTheme.displayLarge?.color,
                letterSpacing: -1,
              ),
              children: [
                const TextSpan(text: "Why "),
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
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...items.asMap().entries.map((entry) {
            final item = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['icon'] as IconData,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['desc'] as String,
                          style: const TextStyle(
                            color: AppColors.mutedForegroundLight,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate()
                .slideX(begin: 0.05, delay: (entry.key * 80).ms)
                .fadeIn();
          }),
        ],
      ),
    );
  }

  Widget _buildCTA(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 28, 20, 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Ready to Explore\nthe Future?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Dive into 25+ technologies with beautiful visuals,\nsimple explanations, and zero internet needed.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                  horizontal: 36, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(width: 8),
                Icon(LucideIcons.arrowRight, size: 18),
              ],
            ),
          ),
        ],
      ),
    ).animate()
        .scale(delay: 200.ms, begin: const Offset(0.95, 0.95))
        .fadeIn();
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 24,
        top: 16,
        left: 20,
        right: 20,
      ),
      child: const Text(
        '© 2025 TechVerse — Offline Tech Encyclopedia.\nMade with ❤️ for learners.',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.mutedForegroundLight, fontSize: 12, height: 1.6),
      ),
    );
  }
}
