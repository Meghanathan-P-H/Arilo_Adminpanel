import 'package:arilo_admin/utils/popups/animation_loder.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:iconsax/iconsax.dart';

class AriloPaginatedDataTable extends StatelessWidget {
  const AriloPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = 32 * 2,
    this.sortAscending = true,
    this.minWidth = 1000,
  });

  final List<DataColumn> columns;
  final DataTableSource source;
  final int rowsPerPage;
  final double tableHeight;
  final void Function(int)? onPageChanged;
  final int? sortColumnIndex;
  final double dataRowHeight;
  final bool sortAscending;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(cardTheme: const CardTheme(color: Colors.white, elevation: 0)),
      child: PaginatedDataTable2(
        source: source,

        /// COLUMNS & ROWS
        columns: columns,
        columnSpacing: 12,
        minWidth: minWidth,
        dividerThickness: 0,
        horizontalMargin: 12,
        rowsPerPage: rowsPerPage,
        dataRowHeight: dataRowHeight,

        /// CHECKBOX
        showCheckboxColumn: true,

        /// PAGINATION
        showFirstLastButtons: true,
        onPageChanged: onPageChanged,
        renderEmptyRowsInTheEnd: false,

        // HEADER DESIGN
        headingTextStyle: Theme.of(context).textTheme.titleMedium,
        headingRowColor: WidgetStateProperty.resolveWith(
          (states) => const Color(0xFFF5F6FA),
        ),
        headingRowDecoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),

        // EMPTY STATE WIDGET
        empty: AriloAnimationLoaderWidget(
          animation: 'assets/logos/loding.json',
          text: 'Nothing Found',
          height: 200,
          width: 200,
        ),

        /// SORTING
        sortAscending: sortAscending,
        sortColumnIndex: sortColumnIndex,
        sortArrowBuilder: (bool ascending, bool sorted) {
          if (sorted) {
            return Icon(
              ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
              size: 16,
            );
          } else {
            return const Icon(Iconsax.arrow_3, size: 16);
          }
        },
      ),
    );
  }
}
