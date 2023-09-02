import 'package:contact_app/bloc/WatchlistBloc/watchlist_bloc.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistScreen extends StatefulWidget {
  final Set<Contact> selectedContacts;

  const WatchlistScreen({Key? key, required this.selectedContacts})
      : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  void _navigateToContactScreen(int tabIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactScreen(
          onBackButtonPressed: () => _handleBackButton(tabIndex),
          tabIndex: tabIndex,
        ),
      ),
    );
  }

  void _handleBackButton(int tabIndex) {
    // Access selectedContacts from the widget property
    final selectedContacts = widget.selectedContacts;

    // Send the selected contacts back to the WatchlistBloc.
    context
        .read<WatchlistBloc>()
        .add(AddToWatchlistEvent(selectedContacts.toList(), tabIndex));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("Selected Contacts in WatchlistScreen: ${widget.selectedContacts}");
    double height = MediaQuery.of(context).size.height;

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
            body: TabBarView(
              children: state.tabs.map((tabName) {
                final tabIndex = state.tabs.indexOf(tabName);
                final watchlist = state.watchlists.elementAt(tabIndex);

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.selectedContacts.isEmpty)
                        ElevatedButton(
                          onPressed: () => _navigateToContactScreen(tabIndex),
                          child: const Text('Add Contacts'),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.selectedContacts.length,
                            itemBuilder: (context, index) {
                              final contact =
                                  widget.selectedContacts.elementAt(index);

                              return Container(
                                margin: EdgeInsets.only(bottom: height * 0.01),
                                padding:
                                    const EdgeInsets.only(right: 8, left: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8.0),
                                  title: Text(
                                    contact.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(contact.contacts),
                                  trailing: const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'https://via.placeholder.com/150',
                                    ),
                                    radius: 20,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  _showAddTabBottomSheetDialog(context, state.tabs.length),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void _showAddTabBottomSheetDialog(BuildContext context, int tabIndex) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _AddTabBottomSheet(
          onTabAdded: () {
            // After adding the tab, navigate to the ContactScreen
            Navigator.pop(context);
            _navigateToContactScreen(tabIndex);
          },
        );
      },
    );
  }

  List<Widget> _buildTabBarViews(List<List<Contact>> tabs, context) {
    double height = MediaQuery.of(context).size.height;
    String contactNum = "";

    return tabs.asMap().entries.map((entry) {
      final tabIndex = entry.key;
      final tabItems = entry.value;
      final List<Contact> selectedContacts = widget.selectedContacts.toList();

      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: selectedContacts.length,
              itemBuilder: (context, index) {
                final contact = selectedContacts[index];

                return Container(
                  margin: EdgeInsets.only(bottom: height * 0.01),
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(
                      contact.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(contact.contacts),
                    trailing: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                      radius: 20,
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  // addToWatchlistTab(tabIndex);
                  // _handleAddToWatchlist();
                },
                icon: const Icon(Icons.add),
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}

class _AddTabBottomSheet extends StatefulWidget {
  final VoidCallback onTabAdded;

  const _AddTabBottomSheet({required this.onTabAdded});

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
                BlocProvider.of<WatchlistBloc>(context)
                    .add(AddTabEvent(tabName));
                widget.onTabAdded();
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
