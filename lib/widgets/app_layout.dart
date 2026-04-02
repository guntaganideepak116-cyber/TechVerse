import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';

class AppLayout extends ConsumerWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final isDark = theme == ThemeMode.dark;
    final location = GoRouterState.of(context).uri.toString();

    final navItems = [
      {'path': '/home', 'label': 'Home', 'icon': LucideIcons.home},
      {'path': '/about', 'label': 'About', 'icon': LucideIcons.info},
      {'path': '/contact', 'label': 'Contact', 'icon': LucideIcons.mail},
    ];

    int currentIndex =
        navItems.indexWhere((item) => item['path'] == location);
    if (currentIndex == -1 && location.startsWith('/tech/')) {
      currentIndex = 0;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context, isDark, themeNotifier),
        drawer: _buildDrawer(context, location, navItems),
        body: child,
        bottomNavigationBar: _buildBottomNav(context, navItems, currentIndex),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, bool isDark, themeNotifier) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AppBar(
            backgroundColor:
                Theme.of(context).cardColor.withOpacity(0.88),
            elevation: 0,
            shape: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor, width: 0.8),
            ),
            titleSpacing: 0,
            // ← Back arrow that goes to landing
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(LucideIcons.menu, size: 20),
                tooltip: 'Menu',
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            title: GestureDetector(
              onTap: () => context.go('/'),
              child: ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: const Text(
                  'TechVerse',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            actions: [
              // Back to landing page button
              IconButton(
                icon: const Icon(LucideIcons.arrowLeft, size: 20),
                tooltip: 'Back to Landing',
                onPressed: () => context.go('/'),
              ),
              IconButton(
                icon: const Icon(LucideIcons.heart, size: 20),
                tooltip: 'Bookmarks',
                onPressed: () => context.go('/bookmarks'),
              ),
              IconButton(
                icon: Icon(
                  isDark ? LucideIcons.sun : LucideIcons.moon,
                  size: 20,
                ),
                tooltip: isDark ? 'Light Mode' : 'Dark Mode',
                onPressed: () => themeNotifier.toggleTheme(),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, String location,
      List<Map<String, Object>> navItems) {
    return Drawer(
      width: 272,
      backgroundColor: Theme.of(context).cardColor,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer header
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 0.8)),
              ),
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
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.x, size: 18),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  // Back to Landing
                  _drawerItem(
                    context,
                    icon: LucideIcons.home,
                    label: 'Landing Page',
                    active: false,
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/');
                    },
                  ),
                  const SizedBox(height: 4),
                  ...navItems.map((item) {
                    final active = location == item['path'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: _drawerItem(
                        context,
                        icon: item['icon'] as IconData,
                        label: item['label'] as String,
                        active: active,
                        onTap: () {
                          Navigator.pop(context);
                          context.go(item['path'] as String);
                        },
                      ),
                    );
                  }),
                  const Divider(height: 24),
                  _drawerItem(
                    context,
                    icon: LucideIcons.heart,
                    label: 'Bookmarks',
                    active: location == '/bookmarks',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/bookmarks');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'TechVerse v1.0 — Offline Learning',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Material(
      color: active ? AppColors.primaryLight.withOpacity(0.12) : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: active
                    ? AppColors.primaryLight
                    : Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      active ? FontWeight.bold : FontWeight.w500,
                  color: active ? AppColors.primaryLight : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context,
      List<Map<String, Object>> navItems, int currentIndex) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 60 + MediaQuery.of(context).padding.bottom,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.88),
            border: Border(
                top: BorderSide(
                    color: Theme.of(context).dividerColor, width: 0.8)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final active = currentIndex == index;
                return Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context.go(item['path'] as String),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primaryLight.withOpacity(0.12)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              size: 20,
                              color: active
                                  ? AppColors.primaryLight
                                  : AppColors.mutedForegroundLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['label'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: active
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: active
                                  ? AppColors.primaryLight
                                  : AppColors.mutedForegroundLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
