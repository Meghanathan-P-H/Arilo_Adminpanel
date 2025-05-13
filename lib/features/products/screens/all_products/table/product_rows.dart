import 'package:arilo_admin/common/widgets/containers/rounded_image.dart';
import 'package:arilo_admin/features/products/controller/product_controller.dart';
import 'package:arilo_admin/features/shop/screens/category/categories/table/table_action_button.dart';
import 'package:arilo_admin/routes/routes.dart';
import 'package:arilo_admin/utils/constants/colors.dart';
import 'package:arilo_admin/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsRows extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: ()=>Get.toNamed(AriloRoute.editProduct,arguments: product),
      onSelectChanged: (value)=>controller.selectedRows[index]=value??false,
      cells: [
        DataCell(
          Row(
            children: [
              AriloRoundedImage(
                width: 50,
                height: 50,
                padding: 4,
                image: product.thumbnail,
                imageType: ImageType.network,
                borderRadius: 8,
                backgroundColor: AriloColors.textSecondary,
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  product.title,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                        color: AriloColors.textPrimary,
                      ),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(controller.getProductStockTotal(product))),
        DataCell(Text(controller.getProductSoldQuantity(product))),
        // DataCell(
        //   Row(
        //     children: [
        //     AriloRoundedImage(
        //         width: 35,
        //         height: 35,
        //         padding: 4,
        //         borderRadius: 8,
        //         backgroundColor: A,
        //         imageType: product.brand != null
        //             ? ImageType.network
        //             : ImageType.asset,
        //         image: product.brand != null
        //             ? product.brand!.image
        //             : AImages.defaultImage,
        //       ),
        //     const SizedBox(width: 16,),
        //     Flexible(child: Text(product.brand!=null?product.brand!.name:'',
        //     style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: AriloColors.textSecondary),))
        //     ],
        //   ),
        // ),

        DataCell(Text('\$${controller.getProductPrice(product)}')),
        DataCell(Text(product.formattedDate)),
        DataCell(TableActionButtons(
          onEditPressed: ()=>Get.toNamed(AriloRoute.editProduct,arguments: product),
          onDeletePressed: ()=>controller.confirmAndDeleteItem(product),
          
        ))
      ],
    );
  }
  
  @override
  bool get isRowCountApproximate => false;
  
  @override
  int get rowCount => controller.filteredItems.length;
  
  @override
  int get selectedRowCount => controller.selectedRows.where((selected)=>selected).length;
}
