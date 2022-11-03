import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pluto_grid/pluto_grid.dart';

part 'table_organisation_event.dart';
part 'table_organisation_state.dart';

class TableOrganisationBloc
    extends Bloc<TableOrganisationEvent, TableOrganisationInitState> {
  TableOrganisationBloc()
      : super(TableOrganisationState(organisationsRows: [])) {
    on<AddClientEvent>(_addClientEvent);
    on<ChangedSelectedOrganisationEvent>(_changedSelectedOrganisationEvent);
    on<EditClientEvent>(_editClientEvent);
    on<AddContractEvent>(_addContractEvent);
    on<EditContractEvent>(_editContractEvent);
    on<ChangedSelectedContractEvent>(_changedSelectedContractEvent);
    on<DeleteContractEvent>(_deleteContractEvent);
    on<DeleteOrganisationEvent>(_deleteOrganisationEvent);
    on<SearchByChiefEvent>(_searchByChiefEvent);
  }

  _searchByChiefEvent(
      SearchByChiefEvent event, Emitter<TableOrganisationInitState> emit) {
    _searchedTable.clear();
    _isSearching = true;
    if (event.adresSearch != "" &&
        event.organisationSearch != "" &&
        event.chiefSearch != "" &&
        event.searcherByDate) {
      var adresSearch = event.adresSearch;
      var organisationSearch = event.organisationSearch;
      var chiefSearch = event.chiefSearch;
      var dataSearch = event.dataSearch;
      int operation = 0;
      for (var item in _organisationsRows) {
        // достаём Map из PlutoRow c данными в одной стрчке
        var organisationRow = item.cells.values.map((e) => e.value);
        // выводим элемент MAp -> 1 == полю адреса
        print(organisationRow.elementAt(1));
        // сравниваем что совпадает значение адреса в строчке с искомым адресом
        if (organisationRow.elementAt(1) == adresSearch &&
            organisationRow.elementAt(0) == organisationSearch &&
            organisationRow.elementAt(0) == chiefSearch) {
          // записываем в Мар строчку т.к. она подходит и в значение
          // кладём соостветсвующий список из контрактов
          _searchedTable.addAll({item: []});
          List<PlutoRow> selectedDate = [];
          for (var contractsItem in _contractsRows[operation]) {
            var contractRow = contractsItem.cells.values.map((e) => e.value);
            if (contractRow.elementAt(1) == dataSearch.toString()) {
              selectedDate.add(contractsItem);
            }
          }
          _searchedTable[item]!.addAll(selectedDate);
        }
        operation += 1;
      }
      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    } else if (event.adresSearch != "") {
      var adresSearch = event.adresSearch;
      int operation = 0;
      for (var item in _organisationsRows) {
        // достаём Map из PlutoRow c данными в одной стрчке
        var adresRow = item.cells.values.map((e) => e.value);
        // выводим элемент MAp -> 1 == полю адреса
        print(adresRow.elementAt(1));
        // сравниваем что совпадает значение адреса в строчке с искомым адресом
        if (adresRow.elementAt(1) == adresSearch) {
          // записываем в Мар строчку т.к. она подходит и в значение
          // кладём соостветсвующий список из контрактов
          _searchedTable.addAll({item: _contractsRows[operation]});
        }
        operation += 1;
      }
      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    }
  }

  _deleteContractEvent(
      DeleteContractEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    _contractsRows[_selectedOrganisationRow].removeAt(_selectedContractRow);
    emit(TableContractState(
        contractsRows: _contractsRows[_selectedOrganisationRow]));
  }

  _deleteOrganisationEvent(
      DeleteOrganisationEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    _organisationsRows.removeAt(_selectedOrganisationRow);
    _contractsRows.removeAt(_selectedOrganisationRow);
    emit(TableOrganisationState(organisationsRows: _organisationsRows));
  }

  _addClientEvent(
      AddClientEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    final item = PlutoRow(
      cells: {
        'text_field': PlutoCell(value: event.organisation),
        'text_Adres': PlutoCell(value: event.adres),
        'text_Chief': PlutoCell(value: event.chief),
      },
    );

    _organisationsRows.insert(_selectedOrganisationRow + 1, item);
    _contractsRows.insert(_selectedOrganisationRow + 1, []);
    emit(TableOrganisationState(organisationsRows: _organisationsRows));
  }

  _changedSelectedOrganisationEvent(ChangedSelectedOrganisationEvent event,
      Emitter<TableOrganisationInitState> emit) {
    _selectedOrganisationRow = event.selectedRow!;
    //print("_selectedOrganisationRow ${event.selectedRow!}");
    if (_isSearching == false) {
      emit(TableContractState(
          contractsRows: _contractsRows[_selectedOrganisationRow]));
    } else {
      emit(TableContractState(
          contractsRows:
              _searchedTable.values.elementAt(_selectedOrganisationRow)));
    }
  }

  // обработка события изменения выбора в поле с данными о контрактах организации
  _changedSelectedContractEvent(ChangedSelectedContractEvent event,
      Emitter<TableOrganisationInitState> emit) {
    _selectedContractRow = event.selectedRow!;
    print("_selectedContractRow ${event.selectedRow!}");
  }

  _editClientEvent(
      EditClientEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    final item = PlutoRow(
      cells: {
        'text_field': PlutoCell(value: event.organisation),
        'text_Adres': PlutoCell(value: event.adres),
        'text_Chief': PlutoCell(value: event.chief),
      },
    );
    _organisationsRows[_selectedOrganisationRow] = item;
    emit(TableOrganisationState(organisationsRows: _organisationsRows));
  }

  _addContractEvent(
      AddContractEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    final item = PlutoRow(
      cells: {
        'number_field': PlutoCell(value: event.contractCoast),
        'date_field': PlutoCell(value: event.date),
      },
    );
    _contractsRows[_selectedOrganisationRow]
        .insert(_selectedContractRow + 1, item);
    emit(TableContractState(
        contractsRows: _contractsRows[_selectedOrganisationRow]));
  }

  _editContractEvent(
      EditContractEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    final item = PlutoRow(
      cells: {
        'number_field': PlutoCell(value: event.contractCoast),
        'date_field': PlutoCell(value: event.date),
      },
    );
    _contractsRows[_selectedOrganisationRow][_selectedContractRow] = item;
    emit(TableContractState(
        contractsRows: _contractsRows[_selectedOrganisationRow]));
  }
}
