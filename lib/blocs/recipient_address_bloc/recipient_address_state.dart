part of 'recipient_address_bloc.dart';

class RecipientAddressState extends Equatable {
  const RecipientAddressState({
    this.recipientAddressModels = const [],
    this.selectedRecipentAddressID,
  });

  final List<RecipentAddressModel> recipientAddressModels;
  final String? selectedRecipentAddressID;

  RecipientAddressState copyWith({
    List<RecipentAddressModel>? recipientAddressModels,
    String? selectedRecipentAddressID,
  }) {
    return RecipientAddressState(
      recipientAddressModels:
          recipientAddressModels ?? this.recipientAddressModels,
      selectedRecipentAddressID:
          selectedRecipentAddressID ?? this.selectedRecipentAddressID,
    );
  }

  @override
  List<Object> get props => [
        recipientAddressModels,
        selectedRecipentAddressID ?? '',
      ];
}
