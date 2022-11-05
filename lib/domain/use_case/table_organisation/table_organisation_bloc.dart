import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../repository/tables_repository.dart';

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
    on<LoadingDataOrganisation>(_loadingDateOrganisation);
  }

  _loadingDateOrganisation(LoadingDataOrganisation event,
      Emitter<TableOrganisationInitState> emit) async {
    _searchedTable = await event.repository.onStartLoadOrganisationsRows();
    _organisationsRows = _searchedTable.keys.toList();
    for (var item in _searchedTable.values) {
      _contractsRows.add(item);
    }
    emit(TableOrganisationState(organisationsRows: _organisationsRows));
  }

  _searchByChiefEvent(
      SearchByChiefEvent event, Emitter<TableOrganisationInitState> emit) {
    _searchedTable.clear();
    _isSearching = true;

    // если пришли все данные
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
        //    print(organisationRow.elementAt(1));
        // сравниваем что совпадает значение адреса в строчке с искомым адресом
        if (organisationRow.elementAt(1) == adresSearch &&
            organisationRow.elementAt(0) == organisationSearch &&
            organisationRow.elementAt(0) == chiefSearch) {
          // записываем в Мар строчку т.к. она подходит и в значение
          // кладём соостветсвующий список из контрактов
          _searchedTable.addAll({item: []});
          // переменаая для хранения всех подходящих по дате элементов
          List<PlutoRow> selectedDate = [];
          // проходимся по списку из контраков соответсующей оранизации
          for (var contractsItem in _contractsRows[operation]) {
            // возращаеться список из значений ы строке -> (сумма, дата сделки)
            var contractRow = contractsItem.cells.values.map((e) => e.value);
            // из списка забираем дату сделки она типа String
            var date = contractRow.elementAt(1);
            // пребразуем дату по которой производиться поиск в строку и берём
            // первые 10 символов, т.к. DateTime содержит ещё и минуты и секунды
            var dateSerched = dataSearch.toLocal().toString().substring(0, 10);
            if (date == dateSerched) {
              selectedDate.add(contractsItem);
            }
          }
          _searchedTable[item]!.addAll(selectedDate);
        }
        operation += 1;
      }
      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    }
    // пришли данные толко адреса
    else if (event.adresSearch != "") {
      var adresSearch = event.adresSearch;
      int operation = 0;
      for (var item in _organisationsRows) {
        // достаём Map из PlutoRow c данными в одной стрчке
        var adresRow = item.cells.values.map((e) => e.value);
        // выводим элемент MAp -> 1 == полю адреса
        //  print(adresRow.elementAt(1));
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
    // пришли данные о начальнике
    else if (event.chiefSearch != "") {
      var chiefSearch = event.chiefSearch;
      int operation = 0;
      for (var item in _organisationsRows) {
        // достаём Map из PlutoRow c данными в одной стрчке
        var adresRow = item.cells.values.map((e) => e.value);
        // выводим элемент MAp -> 2 == полю шефа
        //     print(adresRow.elementAt(2));
        // сравниваем что совпадает значение адреса в строчке с искомым адресом
        if (adresRow.elementAt(2) == chiefSearch) {
          // записываем в Мар строчку т.к. она подходит и в значение
          // кладём соостветсвующий список из контрактов
          _searchedTable.addAll({item: _contractsRows[operation]});
        }
        operation += 1;
      }
      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    }
    // пришли данные о оранизации
    else if (event.organisationSearch != "") {
      var organisationSearch = event.organisationSearch;
      int operation = 0;
      for (var item in _organisationsRows) {
        // достаём Map из PlutoRow c данными в одной стрчке
        var adresRow = item.cells.values.map((e) => e.value);
        // выводим элемент MAp -> 0 == полю имени организации
        //     print(adresRow.elementAt(0));
        // сравниваем что совпадает значение адреса в строчке с искомым адресом
        if (adresRow.elementAt(0) == organisationSearch) {
          // записываем в Мар строчку т.к. она подходит и в значение
          // кладём соостветсвующий список из контрактов
          _searchedTable.addAll({item: _contractsRows[operation]});
        }
        operation += 1;
      }
      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    }
    // пришли данные с датой контрактов
    else if (event.searcherByDate != false) {
      var dataSearch = event.dataSearch;
      int operation = 0;
      _organisationsRows.map((e) => _searchedTable[e] = []);
      for (var item in _organisationsRows) {
        List<PlutoRow> correctDate = [];
        for (var contractsItem in _contractsRows[operation]) {
          var contractRow = contractsItem.cells.values.map((e) => e.value);
          var date = contractRow.elementAt(1);
          var dateSerched = dataSearch.toLocal().toString().substring(0, 10);
          if (date == dateSerched) {
            correctDate.add(contractsItem);
          }
        }
        _searchedTable[item] = correctDate;
        operation += 1;
      }
      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    }
  }

  _deleteContractEvent(
      DeleteContractEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    event.repository.onDeleteContract(_getOrganisation()[0],
        _getOrganisation()[2], _getOrganisation()[1], _selectedContractRow);
    _contractsRows[_selectedOrganisationRow].removeAt(_selectedContractRow);
    emit(TableContractState(
        contractsRows: _contractsRows[_selectedOrganisationRow]));
  }

  _deleteOrganisationEvent(
      DeleteOrganisationEvent event, Emitter<TableOrganisationInitState> emit) {
    _isSearching = false;
    event.repository.onDeleteOrganisation(
        _getOrganisation()[0], _getOrganisation()[2], _getOrganisation()[1]);
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
    event.repository
        .onAddOrganisation(event.organisation, event.chief, event.adres);
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
    //   print("_selectedContractRow ${event.selectedRow!}");
  }

  _editClientEvent(
      EditClientEvent event, Emitter<TableOrganisationInitState> emit) {
    final itemRow = PlutoRow(
      cells: {
        'text_field': PlutoCell(value: event.organisation),
        'text_Adres': PlutoCell(value: event.adres),
        'text_Chief': PlutoCell(value: event.chief),
      },
    );
    event.repository.onEditOrganisation(
        event.organisation,
        event.chief,
        event.adres,
        _getOrganisation()[0],
        _getOrganisation()[2],
        _getOrganisation()[1]);

    if (_isSearching == false) {
      _organisationsRows[_selectedOrganisationRow] = itemRow;
      emit(TableOrganisationState(organisationsRows: _organisationsRows));
    } else {
      // получили элемент который выбрал пользователь во временном Map
      var editingOrganisationSearch =
          _searchedTable.keys.elementAt(_selectedOrganisationRow);
      // создаём новый список и изменеённым значением кулюча (PlutoRow)
      Map<PlutoRow, List<PlutoRow>> searchedTableTemp =
          _searchedTable.map((key, value) {
        if (editingOrganisationSearch == key) {
          return MapEntry(itemRow, value);
        } else {
          return MapEntry(key, value);
        }
      });

      int position = 0;
      // поиск соответсвующего элемента в спике оранизаций c запоминаем его позицию
      for (var item in _organisationsRows) {
        if (item == editingOrganisationSearch) {
          // меняем данные в основном списке
          _organisationsRows[position] = itemRow;
          // меняем значения скиска
          _searchedTable = searchedTableTemp;
        }
        position += 1;
      }

      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    }

    //  _isSearching = false;
  }

  _editContractEvent(
      EditContractEvent event, Emitter<TableOrganisationInitState> emit) {
    // _isSearching = false;
    final itemRow = PlutoRow(
      cells: {
        'number_field': PlutoCell(value: event.contractCoast),
        'date_field': PlutoCell(value: event.date),
      },
    );
    var oldContract = _contractsRows[_selectedOrganisationRow]
            [_selectedContractRow]
        .cells
        .values
        .map((e) => e.value.toString())
        .toList();
    event.repository.onEditContract(
        _getOrganisation().elementAt(0),
        _getOrganisation().elementAt(2),
        _getOrganisation().elementAt(1),
        double.parse(event.contractCoast),
        event.date,
        double.parse(oldContract.elementAt(0)),
        DateTime.parse(oldContract.elementAt(1)));
    if (_isSearching == false) {
      _contractsRows[_selectedOrganisationRow][_selectedContractRow] = itemRow;
      emit(TableContractState(
          contractsRows: _contractsRows[_selectedOrganisationRow]));
    } else {
      // получили элемент который выбрал пользователь во временном Map в организациях
      var editingOrganisationSearch =
          _searchedTable.keys.elementAt(_selectedOrganisationRow);
      // меняем в поисковом Map значение в списке контрактов по выбранной организации
      var tempListContracts = _searchedTable[editingOrganisationSearch];
      tempListContracts![_selectedContractRow] = itemRow;
      _searchedTable[editingOrganisationSearch] = tempListContracts;
      int position = 0;
      // поиск соответсвующего элемента в спике оранизаций c запоминаем его позицию
      for (var item in _organisationsRows) {
        if (item == editingOrganisationSearch) {
          // если организация найдена изменяем данные о контракте
          _contractsRows[position][_selectedContractRow] = itemRow;
        }
        position += 1;
      }
      emit(TableOrganisationState(
          organisationsRows: _searchedTable.keys.toList()));
    }
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
    event.repository.onAddContract(_getOrganisation()[0], _getOrganisation()[2],
        _getOrganisation()[1], double.parse(event.contractCoast), event.date);
    _contractsRows[_selectedOrganisationRow]
        .insert(_selectedContractRow + 1, item);
    emit(TableContractState(
        contractsRows: _contractsRows[_selectedOrganisationRow]));
  }
}

List<String> _getOrganisation() {
  List<String> list = _organisationsRows[_selectedOrganisationRow]
      .cells
      .values
      .map((e) => e.value.toString())
      .toList();
  return list;
}
