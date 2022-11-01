part of 'table_organisation_bloc.dart';

@immutable
abstract class TableOrganisationEvent {}

class SearchByChiefEvent extends TableOrganisationEvent {}

class AddClientEvent extends TableOrganisationEvent {
  final String adres;
  final String chief;
  final String organisation;

  AddClientEvent(
      {required this.organisation, required this.chief, required this.adres});
}
