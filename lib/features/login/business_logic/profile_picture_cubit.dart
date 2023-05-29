import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../data/repository/auth_repository.dart';

part 'profile_picture_state.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  final AuthRepository authRepository;

  ProfilePictureCubit({required this.authRepository})
      : super(ProfilePictureState(''));

  void addImagePicker() async {
    final picker = ImagePicker();
    final pick = await picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      String profilePicturePath = pick.path;
      authRepository.addProfilePicture(profilePicturePath);
      emit(ProfilePictureState(profilePicturePath));
    }
  }

  void removeImage() {
    emit(ProfilePictureState(''));
  }
}
