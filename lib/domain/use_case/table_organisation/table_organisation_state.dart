part of 'table_organisation_bloc.dart';

@immutable
abstract class TableOrganisationInitState {}

List<PlutoRow> _organisationsRows = [];
List<List<PlutoRow>> _contractsRows = [];
int _selectedOrganisationRow = -1;
int _selectedContractRow = -1;
Map<PlutoRow, List<PlutoRow>> _searchedTable = {};
bool _isSearching = false;

class TableOrganisationState extends TableOrganisationInitState {
  final List<PlutoRow> organisationsRows;
  TableOrganisationState({required this.organisationsRows});
}

class TableContractState extends TableOrganisationInitState {
  final List<PlutoRow> contractsRows;
  TableContractState({required this.contractsRows});
}
