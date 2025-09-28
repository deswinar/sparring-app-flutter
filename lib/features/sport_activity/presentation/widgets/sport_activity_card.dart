import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sparring/features/sport_activity/domain/entities/sport_activity_entity.dart';

class SportActivityCard extends StatelessWidget {
  final SportActivityEntity activity;
  final VoidCallback? onTap;

  const SportActivityCard({
    super.key,
    required this.activity,
    this.onTap,
  });

  String _formatDate(DateTime date) {
    return DateFormat('EEE, d MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      activity.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (activity.price != null && activity.price! > 0)
                    Text(
                      'Rp ${activity.price}',
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  else
                    Text(
                      'Free',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              /// Date & Time
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    _formatDate(activity.activityDate),
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.access_time, size: 16, color: colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    '${activity.startTime} - ${activity.endTime}',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// Location
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: colorScheme.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      activity.address,
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// Organizer
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    child: Text(
                      activity.organizer.name.isNotEmpty
                          ? activity.organizer.name[0].toUpperCase()
                          : '?',
                      style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    activity.organizer.name,
                    style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Participants
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...activity.participants.take(5).map((p) => CircleAvatar(
                        radius: 14,
                        child: Text(
                          p.user.name.isNotEmpty ? p.user.name[0].toUpperCase() : '?',
                          style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary),
                        ),
                      )),
                  if (activity.participants.length > 5)
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: colorScheme.secondaryContainer,
                      child: Text(
                        '+${activity.participants.length - 5}',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
