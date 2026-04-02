import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/technologies.dart';
import '../widgets/tech_card.dart';
import '../widgets/category_chip.dart';
import '../theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  final TextEditingController _searchController = TextEditingController();
  String activeCategory = 'All';

  final List<Map<String, String>> categories = const [
    {'label': 'All', 'value': 'All'},
    {'label': '🤖 AI', 'value': 'AI'},
    {'label': '🌐 Web', 'value': 'Web'},
    {'label': '🔒 Security', 'value': 'Security'},
    {'label': '📡 IoT', 'value': 'IoT'},
    {'label': '📊 Data', 'value': 'Data'},
    {'label': '☁️ Cloud', 'value': 'Cloud'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = technologies.where((tech) {
      final matchesSearch =
          tech.title.toLowerCase().contains(search.toLowerCase()) ||
              tech.tagline.toLowerCase().contains(search.toLowerCase());
      final matchesCategory =
          activeCategory == 'All' || tech.category == activeCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    final topPad = MediaQuery.of(context).padding.top + 56;
    final bottomPad = MediaQuery.of(context).padding.bottom + 72;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, topPad + 20, 16, 0),
            sliver: SliverToBoxAdapter(child: _buildHero()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            sliver: SliverToBoxAdapter(child: _buildSearch(context)),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            sliver: SliverToBoxAdapter(child: _buildCategories()),
          ),
          if (filtered.isEmpty)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPad),
              sliver: SliverToBoxAdapter(child: _buildEmptyState()),
            )
          else
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
              sliver: _buildGrid(filtered),
            ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 1.15,
            ),
            children: [
              const TextSpan(text: 'Explore '),
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
        ),
        const SizedBox(height: 6),
        const Text(
          'Discover 25+ modern technologies, fully offline.',
          style: TextStyle(
            color: AppColors.mutedForegroundLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
      ],
    ).animate().slideY(begin: -0.08, duration: 500.ms).fadeIn();
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: Theme.of(context).dividerColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => search = val),
        cursorColor: AppColors.primaryLight,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: const Icon(LucideIcons.search,
              size: 18, color: AppColors.mutedForegroundLight),
          suffixIcon: search.isNotEmpty
              ? IconButton(
                  icon: const Icon(LucideIcons.x,
                      size: 14, color: AppColors.mutedForegroundLight),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => search = '');
                  },
                )
              : null,
          hintText: 'Search technologies...',
          hintStyle: const TextStyle(
              color: AppColors.mutedForegroundLight,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
    ).animate().fadeIn(delay: 80.ms).scale(begin: const Offset(0.98, 0.98));
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        clipBehavior: Clip.none,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return CategoryChip(
            label: cat['label']!,
            active: activeCategory == cat['value'],
            onClick: () =>
                setState(() => activeCategory = cat['value']!),
          );
        },
      ),
    ).animate().fadeIn(delay: 160.ms);
  }

  Widget _buildGrid(List filtered) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => TechCard(tech: filtered[index], index: index),
        childCount: filtered.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: Column(
          children: [
            Icon(
              LucideIcons.search,
              size: 44,
              color: AppColors.mutedForegroundLight.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'No technologies found',
              style: TextStyle(
                color: AppColors.mutedForegroundLight,
                fontWeight: FontWeight.bold,
                fontSize: 17,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try a different keyword or category.',
              style: TextStyle(
                  color: AppColors.mutedForegroundLight, fontSize: 13),
            ),
          ],
        ),
      ).animate().fadeIn(),
    );
  }
}
