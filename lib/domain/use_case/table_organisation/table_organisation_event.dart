part of 'table_organisation_bloc.dart';

@immutable
abstract class TableOrganisationEvent {}

class SearchByChiefEvent extends TableOrganisationEvent {
  final DateTime dataSearch;
  final bool searcherByDate;
  final String chiefSearch;
  final String organisationSearch;
  final String adresSearch;

  SearchByChiefEvent(
      {required this.adresSearch,
      required this.chiefSearch,
      required this.dataSearch,
      required this.organisationSearch,
      required this.searcherByDate});
}

class AddClientEvent extends TableOrganisationEvent {
  final String adres;
  final String chief;
  final String organisation;

  AddClientEvent(
      {required this.organisation, required this.chief, required this.adres});
}

class EditClientEvent extends TableOrganisationEvent {
  final String adres;
  final String chief;
  final String organisation;

  EditClientEvent(
      {required this.organisation, required this.chief, required this.adres});
}

class ChangedSelectedOrganisationEvent extends TableOrganisationEvent {
  final int? selectedRow;
  ChangedSelectedOrganisationEvent({required this.selectedRow});
}

/*-------------------------------------------*/
class AddContractEvent extends TableOrganisationEvent {
  final String contractCoast;
  final DateTime date;

  AddContractEvent({required this.date, required this.contractCoast});
}

class EditContractEvent extends TableOrganisationEvent {
  final String contractCoast;
  final DateTime date;

  EditContractEvent({required this.date, required this.contractCoast});
}

class ChangedSelectedContractEvent extends TableOrganisationEvent {
  final int? selectedRow;
  ChangedSelectedContractEvent({required this.selectedRow});
}

class DeleteContractEvent extends TableOrganisationEvent {
  DeleteContractEvent();
}

class DeleteOrganisationEvent extends TableOrganisationEvent {
  DeleteOrganisationEvent();
}
