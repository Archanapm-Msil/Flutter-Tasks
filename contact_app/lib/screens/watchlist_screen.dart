import 'package:contact_app/bloc/WatchlistBloc/watchlist_bloc.dart';
import 'package:contact_app/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  
  void _navigateToContactScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  ContactScreen( onBackButtonPressed: () => _handleBackButton(),
         
        ),
      ),
    );
  }
  void _handleBackButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        return DefaultTabController(
          length: state.tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Watchlist App'),
              bottom: TabBar(
                tabs: state.tabs.map((tabName) => Tab(text: tabName)).toList(),
              ),
            ),
            body: state.tabs.isNotEmpty
                ? TabBarView(
        children: state.tabs.map((tabName) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToContactScreen(),

                  child: const Text('Add Contacts'),
                ),
                const SizedBox(height: 20),
                
              ],
            ),
          );
        }).toList(),
      )

                : const Center(child: Text('No tabs added.')
                ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddTabBottomSheet(context),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );


  }

void _showAddTabBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return _AddTabBottomSheet(); 
    },
  );
}
}

class _AddTabBottomSheet extends StatefulWidget {
  @override
  __AddTabBottomSheetState createState() => __AddTabBottomSheetState();
}

class __AddTabBottomSheetState extends State<_AddTabBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Tab Name'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final tabName = _controller.text;
              if (tabName.isNotEmpty) {
                BlocProvider.of<WatchlistBloc>(context).add(AddTabEvent(tabName));
              }
              Navigator.pop(context);
            },
            child: const Text('Add Tab'),
          ),
        ],
      ),
    );
  }
}

