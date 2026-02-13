// lib/view_models/store_add/store_add_state.dart
import 'dart:io';

class StoreAddState {
  final bool isLoading;
  final String? errorMessage;
  final File? selectedImage;
  final double? uploadProgress;

  const StoreAddState({
    this.isLoading = false,
    this.errorMessage,
    this.selectedImage,
    this.uploadProgress,
  });

  StoreAddState copyWith({
    bool? isLoading,
    String? errorMessage,
    File? selectedImage,
    double? uploadProgress,
  }) {
    return StoreAddState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      selectedImage: selectedImage ?? this.selectedImage,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}
