import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pluto_grid/pluto_grid.dart';

part 'table_organisation_event.dart';
part 'table_organisation_state.dart';

class TableOrganisationBloc
    extends Bloc<TableOrganisationEvent, TableOrganisationState> {
  TableOrganisationBloc() : super(TableOrganisationInitial()) {
    on<AddClientEvent>(_addClientEvent);
  }

  _addClientEvent(AddClientEvent event, Emitter<TableOrganisationState> emit) {
    var listRows = rowse;
    final item = PlutoRow(
      cells: {
        'text_field': PlutoCell(value: event.organisation),
        'text_Adres': PlutoCell(value: event.adres),
        'text_Chief': PlutoCell(value: event.chief),
      },
    );
    listRows.add(item);
    emit(TableOrganisationInitialState(listRows));
  }
}
