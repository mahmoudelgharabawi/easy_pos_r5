import 'package:easy_pos_r5/helpers/sql_helper.dart';
import 'package:easy_pos_r5/pages/all_sales.dart';
import 'package:easy_pos_r5/pages/categories.dart';
import 'package:easy_pos_r5/pages/products.dart';
import 'package:easy_pos_r5/pages/sale_op.page.dart';
import 'package:easy_pos_r5/widgets/grid_view_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool isTableIntilized = false;
  @override
  void initState() {
    intilizeTables();
    super.initState();
  }

  void intilizeTables() async {
    var sqlHelper = GetIt.I.get<SqlHelper>();
    isTableIntilized = await sqlHelper.createTables();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3 +
                      (kIsWeb ? 40 : 0),
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Easy Pos',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: isLoading
                                  ? Transform.scale(
                                      scale: .5,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: isTableIntilized
                                          ? Colors.green
                                          : Colors.red,
                                      radius: 10,
                                    ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        headerItem('Exchange Rate', '1USD = 50 EGP'),
                        headerItem('Today\'s Sales', '1000 EGP'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: Container(
            color: const Color(0xfffbfafb),
            padding: const EdgeInsets.all(20),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                GridViewItem(
                  color: Colors.orange,
                  iconData: Icons.calculate,
                  label: 'All Sales',
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => AllSales()));
                  },
                ),
                GridViewItem(
                  color: Colors.pink,
                  iconData: Icons.inventory_2,
                  label: 'Products',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProductsPage()));
                  },
                ),
                GridViewItem(
                  color: Colors.lightBlue,
                  iconData: Icons.groups,
                  label: 'Clients',
                  onPressed: () {},
                ),
                GridViewItem(
                  color: Colors.green,
                  iconData: Icons.point_of_sale,
                  label: 'New Sale',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SaleOpsPage()));
                  },
                ),
                GridViewItem(
                  color: Colors.yellow,
                  iconData: Icons.category,
                  label: 'Categories',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CategoriesPage()));
                  },
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget headerItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: const Color(0xff206ce1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
