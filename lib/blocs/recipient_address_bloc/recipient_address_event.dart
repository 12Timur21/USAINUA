part of 'recipient_address_bloc.dart';

abstract class RecipientAddressEvent extends Equatable {
  const RecipientAddressEvent();

  @override
  List<Object> get props => [];
}

class SyncRecipientAddressWithFirebaseEvent extends RecipientAddressEvent {
  const SyncRecipientAddressWithFirebaseEvent();
}

class AddRecipientAddressEvent extends RecipientAddressEvent {
  const AddRecipientAddressEvent({
    required this.recipentAddressModel,
  });

  final RecipentAddressModel recipentAddressModel;
}

class UpdateRecipientAddressEvent extends RecipientAddressEvent {
  const UpdateRecipientAddressEvent({
    required this.recipentAddressModel,
  });

  final RecipentAddressModel recipentAddressModel;
}

class DeleteRecipientAddressEvent extends RecipientAddressEvent {
  const DeleteRecipientAddressEvent({
    required this.recipentAddressID,
  });

  final String recipentAddressID;
}

class UpdateSelectedRecipientAddressIDEvent extends RecipientAddressEvent {
  const UpdateSelectedRecipientAddressIDEvent({
    required this.recipentAddressID,
  });

  final String? recipentAddressID;
}
