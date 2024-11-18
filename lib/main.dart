import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkMode = false;

  ThemeData _buildTheme(bool isDark) {
    return ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.grey,
            brightness: isDark ? Brightness.dark : Brightness.light),
        cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Inventario",
      theme: _buildTheme(isDarkMode),
      home: DashboardScreen(
        toggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const DashboardScreen(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final ColorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;

    if (screenWidth < 800) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 4;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Inventario"),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: toggleTheme,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSummaryCard(context, 'Total de Clientes', '2,495',
                    Icons.people, ColorScheme.primary),
                _buildSummaryCard(context, 'Productos Agotados', '120',
                    Icons.remove_shopping_cart_outlined, ColorScheme.error),
                _buildSummaryCard(context, 'Ordenes Pendientes', '2,004',
                    Icons.attach_money, ColorScheme.secondary),
                _buildSummaryCard(context, 'Inventario Total', '3,124,909',
                    Icons.inventory_outlined, ColorScheme.primary)
              ],
            ),
            const SizedBox(height: 20),
            Text("Pedidos más vendidos del 2024",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 15),
            _buildRecentOrderList(context),
            Text("Promedio de ventas de los últimos 5 años",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 15),
            _buildStatisticCard(context),
            const SizedBox(height: 15),
            Text(
              "Clientes Potenciales",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            _buildStatisticClientCard(context)
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatisticcRow('2019', '321,458,633'),
            _buildStatisticcRow('2020', '1,020,002'),
            _buildStatisticcRow('2021', '265,342,019'),
            _buildStatisticcRow('2022', '468,231,098'),
            _buildStatisticcRow('2023', '2,987,997,124')
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticClientCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatisticcRow('Luis Feliz', '324,651'),
            _buildStatisticcRow('Juana Medina', '120,202'),
            _buildStatisticcRow('Laura Morel', '245,392'),
            _buildStatisticcRow('Nelson Frias', '497,504'),
            _buildStatisticcRow('David Gil', '1,451,124')
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticcRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildRecentOrderList(BuildContext context) {
    return Card(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text('#${index + 1}'),
            ),
            title: Text('Producto #${index + 2000}'),
            trailing: Text('\$${(index + 1) * 100}'),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 32,
                  ),
                  Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: color),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          )),
    );
  }
}
