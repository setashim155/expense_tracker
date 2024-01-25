import 'package:expense_tracker/constants/enums.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common_providers.g.dart';

// For password visibility
@riverpod
class PasswordVisibility extends _$PasswordVisibility {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

// For image
@riverpod
class ImageNotifier extends _$ImageNotifier {
  @override
  XFile? build() => null;

  Future<void> pickImage({bool isCamera = false}) async {
    final picker = ImagePicker();

    state = await picker.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
  }
}

// For editing status of the text field
@riverpod
class EditStatus extends _$EditStatus {
  @override
  bool build({required String id}) {
    return false;
  }

  void change(bool isEditing) {
    state = isEditing;
  }
}

@riverpod
class ChartPeriodNotifier extends _$ChartPeriodNotifier {
  @override
  ChartPeriod? build() {
    return null;
  }

  void change(ChartPeriod chartPeriod) {
    state = chartPeriod;
  }
}

@riverpod
class ChartBuildStatus extends _$ChartBuildStatus {
  @override
  bool? build() {
    return null;
  }

  void toggle() {
    state = state == null ? true : !state!;
  }
}
