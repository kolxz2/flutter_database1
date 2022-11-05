import 'package:pluto_grid/pluto_grid.dart';

abstract class TablesRepository {
  Future<Map<PlutoRow, List<PlutoRow>>> onStartLoadOrganisationsRows() async {
    Map<PlutoRow, List<PlutoRow>> loadedList = {};
    return loadedList;
  }

  Future<void> onAddOrganisation(
      String organisation, String chief, String adres) async {}

  Future<void> onDeleteOrganisation(
      String organisation, String chief, String adres) async {}

  Future<void> onEditOrganisation(
      String organisation,
      String chief,
      String adres,
      String organisationOld,
      String chiefOld,
      String adresOld) async {}

  Future<void> onAddContract(String organisation, String chief, String adres,
      double coast, DateTime date) async {}

  Future<void> onEditContract(String organisation, String chief, String adres,
      double coast, DateTime date, double coastOld, DateTime dateOld) async {}

  Future<void> onDeleteContract(
    String organisation,
    String chief,
    String adres,
    int index,
  ) async {}
}
