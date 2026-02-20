import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/utils/ThemaHelper.dart';

class CastMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final BuildContext context;

  const CastMemberCard({
    Key? key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colors.surface,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: context.colors.surface,
                    child: Icon(
                      Icons.person,
                      color: context.colors.textSecondary,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Name
          SizedBox(
            width: 80,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Role
          SizedBox(
            width: 80,
            child: Text(
              role,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.colors.textSecondary,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
