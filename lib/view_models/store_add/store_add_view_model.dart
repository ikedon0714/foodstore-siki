// lib/view_models/store_add/store_add_view_model.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/stores/store_model.dart';
import '../../repositories/repository_exception.dart';
import '../../repositories/store_repository.dart';
import '../store_add/malaysian_formatter.dart';
import '../store_add/store_add_state.dart';

class StoreAddViewModel extends StateNotifier<StoreAddState> {
  StoreAddViewModel(
      this._storeRepository,
      this._storage, {
        ImagePicker? picker,
      })  : _picker = picker ?? ImagePicker(),
        super(const StoreAddState());

  final StoreRepository _storeRepository;
  final FirebaseStorage _storage;
  final ImagePicker _picker;

  // ---------- UI から呼ぶロジック（Pageはこれだけ呼ぶ） ----------

  String? validatePhone(String? value) => MalaysianFormatter.validatePhone(value);

  String? validatePostalCode(String? value) =>
      MalaysianFormatter.validatePostalCode(value);

  String formatPhoneForStore(String input) =>
      MalaysianFormatter.formatPhoneForStore(input);

  String formatOpeningHours({
    required TimeOfDayLike? opening,
    required TimeOfDayLike? closing,
  }) =>
      MalaysianFormatter.formatOpeningHours(opening: opening, closing: closing);

  String buildFullAddress({
    required String postalCode,
    required String state,
    required String addressLine,
  }) =>
      '${postalCode.trim()}, $state, ${addressLine.trim()}';

  // ---------- Image ----------

  Future<void> pickImage() => _pick(ImageSource.gallery);

  Future<void> takePhoto() => _pick(ImageSource.camera);

  void clearImage() {
    state = state.copyWith(selectedImage: null, errorMessage: null);
  }

  // ---------- Create Store ----------

  Future<bool> createStore({
    required String storeName,
    required String tellNumber,
    required String address,
    required String openingHours,
    required List<String> regularHoliday,
    required int seats,
    required int parking,
    String? price,
    required String description,
  }) async {
    if (!_ensureImageSelected()) return false;

    _setLoading(true);

    try {
      final now = Timestamp.now();

      final tempStore = _buildTempStore(
        now: now,
        storeName: storeName,
        tellNumber: tellNumber,
        address: address,
        openingHours: openingHours,
        regularHoliday: regularHoliday,
        seats: seats,
        parking: parking,
        price: price,
        description: description,
      );

      final storeId = await _createStoreDoc(tempStore);
      final imageUrl = await _uploadStoreImage(storeId, state.selectedImage!);
      await _updateImagePath(storeId, imageUrl);

      _resetState();
      return true;
    } on RepositoryException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('店舗の作成に失敗しました: $e');
      return false;
    }
  }

  // ================== private ==================

  Future<void> _pick(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (image == null) return;

      state = state.copyWith(
        selectedImage: File(image.path),
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: source == ImageSource.camera
            ? 'カメラの起動に失敗しました: $e'
            : '画像の選択に失敗しました: $e',
      );
    }
  }

  bool _ensureImageSelected() {
    if (state.selectedImage != null) return true;
    state = state.copyWith(errorMessage: '店舗画像を選択してください');
    return false;
  }

  void _setLoading(bool loading) {
    state = state.copyWith(
      isLoading: loading,
      errorMessage: null,
      uploadProgress: loading ? 0.0 : null,
    );
  }

  void _setError(String message) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: message,
      uploadProgress: null,
    );
  }

  void _resetState() {
    state = const StoreAddState();
  }

  StoreModel _buildTempStore({
    required Timestamp now,
    required String storeName,
    required String tellNumber,
    required String address,
    required String openingHours,
    required List<String> regularHoliday,
    required int seats,
    required int parking,
    required String? price,
    required String description,
  }) {
    return StoreModel(
      storeId: '', // createStoreで自動生成される
      createdAt: now,
      updatedAt: now,
      storeName: storeName,
      imagePath: '', // 後で更新
      openingHours: openingHours,
      regularHoliday: regularHoliday,
      tellNumber: tellNumber,
      address: address,
      seats: seats,
      parking: parking,
      price: price,
      description: description,
    );
  }

  Future<String> _createStoreDoc(StoreModel tempStore) async {
    final docRef = await _storeRepository.createStore(tempStore);
    return docRef.id;
  }

  Future<String> _uploadStoreImage(String storeId, File imageFile) async {
    try {
      final ref = _storage.ref().child('stores/$storeId/main.jpg');
      final task = ref.putFile(imageFile);

      task.snapshotEvents.listen((snapshot) {
        final total = snapshot.totalBytes == 0 ? 1 : snapshot.totalBytes;
        state = state.copyWith(uploadProgress: snapshot.bytesTransferred / total);
      });

      final snapshot = await task;
      return snapshot.ref.getDownloadURL();
    } catch (e) {
      throw RepositoryException(
        '画像のアップロードに失敗しました',
        'upload-failed',
        original: e,
      );
    }
  }

  Future<void> _updateImagePath(String storeId, String imageUrl) {
    return _storeRepository.updateStore(storeId, {'imagePath': imageUrl});
  }
}

// ===== Providers（バケット等のハードコードをVMから排除）=====

/// 例: --dart-define=FIREBASE_STORAGE_BUCKET=gs://xxx.appspot.com
final firebaseStorageBucketProvider = Provider<String?>((ref) {
  const bucket =
  String.fromEnvironment('FIREBASE_STORAGE_BUCKET', defaultValue: '');
  return bucket.isEmpty ? null : bucket;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  final bucket = ref.watch(firebaseStorageBucketProvider);
  return bucket == null
      ? FirebaseStorage.instance
      : FirebaseStorage.instanceFor(bucket: bucket);
});

final storeAddViewModelProvider =
StateNotifierProvider<StoreAddViewModel, StoreAddState>((ref) {
  final repo = ref.watch(storeRepositoryProvider);
  final storage = ref.watch(firebaseStorageProvider);
  return StoreAddViewModel(repo, storage);
});
