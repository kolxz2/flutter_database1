part of 'table_organisation_bloc.dart';

@immutable
abstract class TableOrganisationEvent {}

class SearchByChiefEvent extends TableOrganisationEvent {
  final DateTime dataSearch;
  final bool searcherByDate;
  final String chiefSearch;
  final String organisationSearch;
  final String adresSearch;

  SearchByChiefEvent({
    required this.adresSearch,
    required this.chiefSearch,
    required this.dataSearch,
    required this.organisationSearch,
    required this.searcherByDate,
  });
}

class AddClientEvent extends TableOrganisationEvent {
  final String adres;
  final String chief;
  final String organisation;
  final TablesRepository repository;

  AddClientEvent(
      {required this.organisation,
      required this.chief,
      required this.adres,
      required this.repository});
}

class EditClientEvent extends TableOrganisationEvent {
  final String adres;
  final String chief;
  final String organisation;
  final TablesRepository repository;

  EditClientEvent(
      {required this.organisation,
      required this.chief,
      required this.adres,
      required this.repository});
}

class ChangedSelectedOrganisationEvent extends TableOrganisationEvent {
  final int? selectedRow;
  ChangedSelectedOrganisationEvent({required this.selectedRow});
}

/*-------------------------------------------*/
class AddContractEvent extends TableOrganisationEvent {
  final String contractCoast;
  final DateTime date;
  final TablesRepository repository;

  AddContractEvent(
      {required this.date,
      required this.contractCoast,
      required this.repository});
}

class EditContractEvent extends TableOrganisationEvent {
  final String contractCoast;
  final DateTime date;
  final TablesRepository repository;

  EditContractEvent(
      {required this.date,
      required this.contractCoast,
      required this.repository});
}

class ChangedSelectedContractEvent extends TableOrganisationEvent {
  final int? selectedRow;
  ChangedSelectedContractEvent({required this.selectedRow});
}

class DeleteContractEvent extends TableOrganisationEvent {
  final TablesRepository repository;
  DeleteContractEvent({required this.repository});
}

class DeleteOrganisationEvent extends TableOrganisationEvent {
  final TablesRepository repository;
  DeleteOrganisationEvent({required this.repository});
}

class LoadingDataOrganisation extends TableOrganisationEvent {
  final TablesRepository repository;
  LoadingDataOrganisation({required this.repository});
}
