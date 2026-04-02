import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/landing_page.dart';
import '../pages/home_page.dart';
import '../pages/tech_detail_page.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';
import '../pages/bookmarks_page.dart';
import '../widgets/app_layout.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/tech/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return TechDetailPage(id: id);
          },
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactPage(),
        ),
        GoRoute(
          path: '/bookmarks',
          builder: (context, state) => const BookmarksPage(),
        ),
      ],
    ),
  ],
);
