import 'package:flutter/material.dart';
import 'package:lanars/src/common/widget/text/default_text.dart';
import 'package:lanars/src/feature/auth/widget/auth_scope.dart';

class DrawerProfile extends StatelessWidget {
  const DrawerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: DefaultText.titleSmall('Profile'),
        ),
        AuthScope.of(context).user.when(
          authenticated: (user) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(user.picture.medium),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText.bodyLarge(
                        user.name.fullName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      DefaultText.bodySmall(
                        user.email,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          notAuthenticated: () => const SizedBox(),
        ),
      ],
    );
  }
}
