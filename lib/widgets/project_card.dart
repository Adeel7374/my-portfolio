import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/hover_scale.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? url;
  const ProjectCard({super.key, required this.title, required this.subtitle, this.url});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: HoverScale(
        onTap: widget.url == null ? null : () => _open(widget.url!),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, hovering ? -4.0 : 0.0)
          ..scale(hovering ? 1.01 : 1.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.cardBlueGrey.withValues(alpha: 0.9),
              AppTheme.cardBlueGrey.withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppTheme.textPrimary, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(widget.subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppTheme.textSecondary)),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                onPressed: widget.url == null ? null : () => _open(widget.url!),
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('View'),
              ),
            )
          ],
        ),
      ),
    ),
  );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }
}


