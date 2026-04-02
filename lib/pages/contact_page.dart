import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  bool _sent = false;

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
            const SizedBox(height: 20),
            _buildContactCards(context),
            const SizedBox(height: 24),
            _buildForm(context),
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
              const TextSpan(text: 'Contact '),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: const Text(
                    'Us',
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
        const SizedBox(height: 8),
        const Text(
          'Have questions or feedback? We\'d love to hear from you.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.mutedForegroundLight,
            height: 1.55,
          ),
        ).animate().fadeIn(delay: 80.ms).slideY(begin: 0.08),
      ],
    );
  }

  Widget _buildContactCards(BuildContext context) {
    final infos = [
      {
        'icon': LucideIcons.mail,
        'title': 'Email',
        'value': 'hello@techverse.com',
      },
      {
        'icon': LucideIcons.twitter,
        'title': 'Twitter',
        'value': '@techverse_app',
      },
      {
        'icon': LucideIcons.github,
        'title': 'GitHub',
        'value': 'techverse-org',
      },
    ];

    return Column(
      children: infos.asMap().entries.map((entry) {
        final i = entry.key;
        final info = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(info['icon'] as IconData,
                    color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    info['value'] as String,
                    style: const TextStyle(
                      color: AppColors.mutedForegroundLight,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(delay: (100 + i * 60).ms).slideX(begin: 0.06);
      }).toList(),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send Us a Message',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(context, 'Full Name', LucideIcons.user),
          const SizedBox(height: 12),
          _buildTextField(context, 'Email Address', LucideIcons.mail),
          const SizedBox(height: 12),
          _buildTextField(
            context,
            'Your Message',
            LucideIcons.messageSquare,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _sent
                  ? Container(
                      key: const ValueKey('sent'),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            color: AppColors.primaryLight.withOpacity(0.4)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.checkCircle,
                              color: AppColors.primaryLight, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Message sent successfully!',
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      key: const ValueKey('send'),
                      onPressed: () {
                        setState(() => _sent = true);
                        Future.delayed(const Duration(seconds: 3), () {
                          if (mounted) setState(() => _sent = false);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        elevation: 6,
                        shadowColor:
                            AppColors.primaryLight.withOpacity(0.35),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.send, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Send Message',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.08);
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: Icon(icon,
                size: 17, color: AppColors.mutedForegroundLight),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 44, minHeight: 44),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                  color: AppColors.primaryLight, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
