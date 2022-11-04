import 'package:pluto_grid/pluto_grid.dart';

abstract class TablesRepository {
  Future<List<PlutoRow>> onStartLoadOrganisationsRows() async {
    List<PlutoRow> loadedList = [];
    return loadedList;
  }

  onAddOrganisation() {}

  onDeleteOrganisation() {}

  onEditOrganisation() {}

  onAddContract() {}

  onEditContract() {}

  onDeleteContract() {}
}
