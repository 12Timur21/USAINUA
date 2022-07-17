import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usainua/models/recipient_address_model.dart';
import 'package:usainua/repositories/firestore_repository.dart';

part 'recipient_address_event.dart';
part 'recipient_address_state.dart';

class RecipientAddressBloc
    extends Bloc<RecipientAddressEvent, RecipientAddressState> {
  RecipientAddressBloc() : super(const RecipientAddressState()) {
    on<SyncRecipientAddressWithFirebaseEvent>((event, emit) async {
      List<RecipentAddressModel> recipientAdressModels =
          await FirestoreRepository.instance.getAllRecipientAddressModels();
      String? selectedRecipentAddressID =
          await FirestoreRepository.instance.getSelectedRecipientAddressModel();

      emit(
        RecipientAddressState(
          recipientAddressModels: recipientAdressModels,
          selectedRecipentAddressID: selectedRecipentAddressID,
        ),
      );
    });

    on<AddRecipientAddressEvent>((event, emit) {
      List<RecipentAddressModel> allRecipientAddressModels = [
        ...state.recipientAddressModels
      ];

      FirestoreRepository.instance.saveRecipientAddressModel(
        recipentAddressModel: event.recipentAddressModel,
      );

      allRecipientAddressModels.add(event.recipentAddressModel);

      emit(
        state.copyWith(
          recipientAddressModels: allRecipientAddressModels,
        ),
      );
    });

    on<UpdateRecipientAddressEvent>((event, emit) {
      List<RecipentAddressModel> allRecipientAddressModels = [
        ...state.recipientAddressModels
      ];

      FirestoreRepository.instance.updateRecipientAddressModel(
        recipentAddressModel: event.recipentAddressModel,
      );

      final int updateIndex = allRecipientAddressModels.indexWhere(
        (element) => element.id == event.recipentAddressModel.id,
      );

      allRecipientAddressModels[updateIndex] = event.recipentAddressModel;

      emit(
        state.copyWith(
          recipientAddressModels: allRecipientAddressModels,
        ),
      );
    });

    on<DeleteRecipientAddressEvent>((event, emit) {
      List<RecipentAddressModel> allRecipientAddressModels = [
        ...state.recipientAddressModels
      ];

      FirestoreRepository.instance.deleteRecipientAddressModel(
        recipentAddressID: event.recipentAddressID,
      );

      allRecipientAddressModels.removeWhere(
        (element) => element.id == event.recipentAddressID,
      );

      emit(
        state.copyWith(
          recipientAddressModels: allRecipientAddressModels,
        ),
      );
    });

    on<UpdateSelectedRecipientAddressIDEvent>((event, emit) {
      FirestoreRepository.instance.updateSelectedRecipientAddressModel(
        recipentAddressID: event.recipentAddressID,
      );

      emit(
        state.copyWith(
          selectedRecipentAddressID: event.recipentAddressID,
        ),
      );
    });
  }
}
