import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DataFetcherApp(),
    );
  }
}

class DataFetcherApp extends StatefulWidget {
  const DataFetcherApp({super.key});

  @override
  State<DataFetcherApp> createState() {
   return _DataFetcherAppState();
  }
} 

class _DataFetcherAppState extends State<DataFetcherApp> {
  
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return "Data fetched successfully!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Fetcher App'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error fetching data');
            } else {
              return Text(
                snapshot.data ?? 'No data available',
                style:const TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}
