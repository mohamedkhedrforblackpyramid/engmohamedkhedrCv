import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/cv_data.dart';

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.sizeOf(context).width > 800;
    final padding = isWide ? 80.0 : 24.0;
    const accentColor = Color(0xFF0D9488); // Teal
    const surfaceColor = Color(0xFF0F172A); // Slate 900
    const cardColor = Color(0xFF1E293B);   // Slate 800
    const textLight = Color(0xFF94A3B8);
    const textWhite = Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: surfaceColor,
      body: CustomScrollView(
        slivers: [
          // ─── Hero ─────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(padding, 56, padding, 48),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF134E4A),
                  ],
                ),
              ),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _HeroContent(
                            accentColor: accentColor,
                            textWhite: textWhite,
                            textLight: textLight,
                            onLaunch: _openUrl,
                          ),
                        ),
                        const SizedBox(width: 32),
                        _ProfilePhoto(size: 140),
                      ],
                    )
                  : Column(
                      children: [
                        _ProfilePhoto(size: 120),
                        const SizedBox(height: 24),
                        _HeroContent(
                          accentColor: accentColor,
                          textWhite: textWhite,
                          textLight: textLight,
                          onLaunch: _openUrl,
                        ),
                      ],
                    ),
            ),
          ),

          // ─── Content wrapper ───────────────────────────────────────────────
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SectionTitle('Professional Summary', accentColor),
                const SizedBox(height: 12),
                _Card(
                  backgroundColor: cardColor,
                  child: Text(
                    CvData.summary,
                    style: GoogleFonts.inter(
                      color: textLight,
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                _SectionTitle('Core Skills', accentColor),
                const SizedBox(height: 12),
                ...CvData.coreSkills.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _Card(
                      backgroundColor: cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.key,
                            style: GoogleFonts.inter(
                              color: accentColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: e.value
                                .map(
                                  (s) => Chip(
                                    label: Text(
                                      s,
                                      style: GoogleFonts.inter(fontSize: 12),
                                    ),
                                    backgroundColor: surfaceColor,
                                    side: BorderSide(
                                      color: accentColor.withValues(alpha: 0.5),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                _SectionTitle('Professional Experience', accentColor),
                const SizedBox(height: 12),
                ...CvData.experience.map(
                  (exp) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _ExperienceCard(
                      item: exp,
                      accentColor: accentColor,
                      cardColor: cardColor,
                      textLight: textLight,
                      textWhite: textWhite,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                _SectionTitle('Education', accentColor),
                const SizedBox(height: 12),
                _Card(
                  backgroundColor: cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${CvData.educationDegree}, ${CvData.educationSchool}',
                        style: GoogleFonts.inter(
                          color: textWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CvData.educationPeriod,
                        style: GoogleFonts.inter(
                          color: accentColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                if (CvData.publishedApps.isNotEmpty) ...[
                  _SectionTitle('Published Apps', accentColor),
                  const SizedBox(height: 6),
                  Text(
                    'Some of my published applications',
                    style: GoogleFonts.inter(
                      color: textLight,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...CvData.publishedApps.map(
                    (app) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _Card(
                        backgroundColor: cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  app.stores.length > 1
                                      ? Icons.apps_rounded
                                      : Icons.android_rounded,
                                  color: accentColor,
                                  size: 28,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    app.name,
                                    style: GoogleFonts.inter(
                                      color: textWhite,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: app.stores.map((store) {
                                return InkWell(
                                  onTap: () => CvScreen._openUrl(store.url),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: accentColor.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: accentColor.withValues(alpha: 0.5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          store.label.contains('Play')
                                              ? Icons.android_rounded
                                              : Icons.apple_rounded,
                                          color: accentColor,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          store.label,
                                          style: GoogleFonts.inter(
                                            color: textLight,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.open_in_new_rounded,
                                          color: accentColor,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],

                _SectionTitle('Languages', accentColor),
                const SizedBox(height: 12),
                _Card(
                  backgroundColor: cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: CvData.languages
                        .map(
                          (l) => Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.translate_rounded,
                                  color: accentColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${l.name} (${l.level})',
                                  style: GoogleFonts.inter(
                                    color: textLight,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 48),

                // Footer
                Center(
                  child: Text(
                    'Mohamed Omar Khedr · Lead Mobile Developer',
                    style: GoogleFonts.inter(
                      color: textLight.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({required this.size});

  final double size;

  static const Color _accent = Color(0xFF0D9488);
  static const Color _accentLight = Color(0xFF14B8A6);

  @override
  Widget build(BuildContext context) {
    const ringWidth = 4.0;
    const innerHighlight = 1.5;
    const padding = 5.0; // مساحة بين الصورة والإطار
    final imageSize = size - (ringWidth * 2) - (padding * 2);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          // ظل بعيد ناعم للعمق
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 28,
            spreadRadius: -4,
            offset: const Offset(0, 10),
          ),
          // توهج بلون الثيم
          BoxShadow(
            color: _accent.withValues(alpha: 0.35),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
          // حلقة ضوئية خفيفة
          BoxShadow(
            color: _accentLight.withValues(alpha: 0.2),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // إطار مزدوج: تدرج داخلي + حدود احترافية
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _accent,
                width: ringWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.12),
                  blurRadius: 0,
                  spreadRadius: -innerHighlight,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
          ),
          // حلقة داخلية فاتحة للأناقة
          Container(
            width: size - ringWidth * 2,
            height: size - ringWidth * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _accentLight.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
          // الصورة مع مسافة بسيطة عن الإطار
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: kIsWeb
                  ? Image.network(
                      'profile.png',
                      fit: BoxFit.cover,
                      width: imageSize,
                      height: imageSize,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (_, __, ___) => _placeholderIcon(size),
                    )
                  : Image.asset(
                      'assets/profile.png',
                      fit: BoxFit.cover,
                      width: imageSize,
                      height: imageSize,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (_, __, ___) => _placeholderIcon(size),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _placeholderIcon(double size) {
    return Icon(
      Icons.person_rounded,
      size: size * 0.5,
      color: _accent.withValues(alpha: 0.5),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.accentColor,
    required this.textWhite,
    required this.textLight,
    required this.onLaunch,
  });

  final Color accentColor;
  final Color textWhite;
  final Color textLight;
  final void Function(String) onLaunch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CvData.name,
          style: GoogleFonts.plusJakartaSans(
            color: textWhite,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          CvData.title,
          style: GoogleFonts.inter(
            color: accentColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _ContactChip(
              icon: Icons.email_outlined,
              label: CvData.email,
              onTap: () => onLaunch('mailto:${CvData.email}'),
              accentColor: accentColor,
              textLight: textLight,
            ),
            _ContactChip(
              icon: Icons.phone_outlined,
              label: CvData.phone,
              onTap: () => onLaunch('tel:${CvData.phone.replaceAll(' ', '')}'),
              accentColor: accentColor,
              textLight: textLight,
            ),
            _ContactChip(
              icon: Icons.link,
              label: 'LinkedIn',
              onTap: () => onLaunch(CvData.linkedIn),
              accentColor: accentColor,
              textLight: textLight,
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.accentColor,
    required this.textLight,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color accentColor;
  final Color textLight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accentColor.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: accentColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(color: textLight, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, this.accentColor);

  final String title;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.backgroundColor,
    required this.child,
  });

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF0D9488).withValues(alpha: 0.2),
        ),
      ),
      child: child,
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.item,
    required this.accentColor,
    required this.cardColor,
    required this.textLight,
    required this.textWhite,
  });

  final ExperienceItem item;
  final Color accentColor;
  final Color cardColor;
  final Color textLight;
  final Color textWhite;

  @override
  Widget build(BuildContext context) {
    return _Card(
      backgroundColor: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.role,
                      style: GoogleFonts.inter(
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.company} · ${item.location}',
                      style: GoogleFonts.inter(
                        color: textWhite,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item.period,
                style: GoogleFonts.inter(
                  color: textLight,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...item.highlights.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: GoogleFonts.inter(color: accentColor, fontSize: 14),
                  ),
                  Expanded(
                    child: Text(
                      h,
                      style: GoogleFonts.inter(
                        color: textLight,
                        height: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (item.keyProjects.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Key Projects:',
              style: GoogleFonts.inter(
                color: accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            ...item.keyProjects.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '◦ ',
                      style: GoogleFonts.inter(color: accentColor, fontSize: 12),
                    ),
                    Expanded(
                      child: Text(
                        p,
                        style: GoogleFonts.inter(
                          color: textLight,
                          height: 1.45,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
