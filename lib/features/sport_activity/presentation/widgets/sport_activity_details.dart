import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';

class SportActivityDetails extends StatelessWidget {
  final SportActivityEntity activity;
  final VoidCallback? onJoin;

  const SportActivityDetails({
    super.key,
    required this.activity,
    this.onJoin,
  });

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final availableSlots = activity.slot - activity.participants.length;
    final isFull = availableSlots <= 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            activity.title,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),

          /// Organizer
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Text(
                  activity.organizer.name.isNotEmpty
                      ? activity.organizer.name[0].toUpperCase()
                      : '?',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Organized by ${activity.organizer.name}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Availability
          Row(
            children: [
              Icon(Icons.people, size: 20, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                isFull
                    ? 'Full (0 of ${activity.slot} slots left)'
                    : '$availableSlots of ${activity.slot} slots available',
                style: textTheme.bodyMedium?.copyWith(
                  color: isFull ? colorScheme.error : colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Date & Time
          _InfoRow(
            icon: Icons.calendar_today,
            label: _formatDate(activity.activityDate),
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.access_time,
            label: '${activity.startTime} – ${activity.endTime}',
          ),
          const SizedBox(height: 16),

          /// Location
          _InfoRow(
            icon: Icons.location_on,
            label: activity.address,
            maxLines: 2,
          ),
          const SizedBox(height: 16),

          /// Price
          if (activity.price != null && activity.price! > 0)
            Text(
              'Rp ${activity.price}',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Text(
              'Free',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 24),

          /// Participants
          Text(
            'Participants',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: activity.participants.map((p) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text(
                      p.user.name.isNotEmpty
                          ? p.user.name[0].toUpperCase()
                          : '?',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.user.name,
                    style: textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 32),

          /// Join button
          if (onJoin != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFull ? null : onJoin,
                child: Text(isFull ? 'Activity Full' : 'Join Activity'),
              ),
            ),
        ],
      ),
    );
  }
}

/// Reusable row for info
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int maxLines;

  const _InfoRow({
    required this.icon,
    required this.label,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
