import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/profile_picture_cubit.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => BlocProvider.of<ProfilePictureCubit>(context)
                  .addImagePicker(),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      width: 110.0,
                      height: 110.0,
                      color: theme.colorScheme.surfaceVariant,
                      child: state.profilePicturePath.isEmpty
                          ? const Icon(
                              Icons.person_add_alt_1_rounded,
                              size: 60,
                            )
                          : Image.file(
                              File(state.profilePicturePath),
                              fit: BoxFit.cover,
                              semanticLabel: 'image',
                            ),
                    ),
                  ),
                  if (state.profilePicturePath.isNotEmpty)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ),
                ],
              ),
            ),
            if (state.profilePicturePath.isEmpty)
              TextButton(
                onPressed: () => BlocProvider.of<ProfilePictureCubit>(context)
                    .addImagePicker(),
                child: const Text('Add profile picture'),
              ),
            if (state.profilePicturePath.isNotEmpty)
              TextButton(
                onPressed: () =>
                    context.read<ProfilePictureCubit>().removeImage(),
                child: const Text('Remove profile picture'),
              ),
          ],
        );
      },
    );
  }
}
