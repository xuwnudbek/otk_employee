import 'package:flutter/material.dart';
import 'package:otk_employee/ui/order/order_page.dart';
import 'package:otk_employee/ui/order/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:otk_employee/ui/home/provider/home_provider.dart';
import 'package:otk_employee/utils/widgets/app/custom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider()..initialize(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          final Map page = provider.menu[provider.selectedIndex];

          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${page['title']}',
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    await provider.logout(context);
                  },
                ),
              ],
            ),
            body: OrderPage(),
            // bottomNavigationBar: CustomNavbar(),
          );
        },
      ),
    );
  }
}
