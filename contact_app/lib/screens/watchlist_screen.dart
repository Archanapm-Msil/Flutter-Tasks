import 'package:contact_app/bloc/WatchlistBloc/watchlist_bloc.dart';
import 'package:contact_app/bloc/WatchlistBloc/watchlist_event.dart';
import 'package:contact_app/bloc/WatchlistBloc/watchlist_state.dart';
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
  List<Contact>? contactsToSort;


 @override
   void initState() {
    super.initState();

    // Initialize state.users with the selectedContacts
    final selectedContacts = widget.selectedContacts.toList();
    context.read<WatchlistBloc>().add(AddToWatchlistEvent(selectedContacts, 0));
  }
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
    final selectedContacts = widget.selectedContacts.toList();

    context.read<WatchlistBloc>().add(AddToWatchlistEvent(selectedContacts, tabIndex));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                contactsToSort = state.users.isNotEmpty ? state.users[tabIndex] : [];

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
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: widget.selectedContacts.length,
                                  itemBuilder: (context, index) {
                                    print(state);
                                    final contact = state is FilteredState ? state.filteredUsers[tabIndex][index]: widget.selectedContacts.elementAt(index);
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
                              ElevatedButton(
                                onPressed: () => _navigateToContactScreen(tabIndex),
                                child: const Text('Add Contacts'),
                              ),
                              const SizedBox(height: 20),
                              _sortContacts(tabIndex),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddTabBottomSheetDialog(context, state.tabs.length),
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
            Navigator.pop(context);
            _navigateToContactScreen(tabIndex);
          },
        );
      },
    );
  }

  IconButton _sortContacts(int tabIndex) {
  String? isSelected;

  return IconButton(
    onPressed: () {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocConsumer<WatchlistBloc, WatchlistState>(
            listener: (context, state) {
              if (state is FilteredState) {
                isSelected = state.selectedSort;
              }
            },
            builder: (context, state) {
              return SizedBox(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Sort By',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Text(
                                'Done',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          const Text('User ID'),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Sort in ascending order
                              print("USER====================${state.users}");
                              context.read<WatchlistBloc>().add(OnSortEvent(
                                filteredusers: state.users.map((list) {
                                  if (list.isEmpty || list != state.users[tabIndex]) {
                                    return list;
                                  }
                                  final sortedList = List.of(list)
                                    ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                                    print("Sorted list ======${sortedList}");
                                  return sortedList;
                                }).toList(),
                                currentTabIndex: tabIndex,
                                selectedSort: 'asc',
                              ));
                              
                            },
                            child: Text(
                              '0 \u{2193} 9',
                              style: TextStyle(
                                color: isSelected == null
                                    ? Colors.black
                                    : isSelected == 'asc'
                                        ? Colors.blue
                                        : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Sort in descending order
                              context.read<WatchlistBloc>().add(OnSortEvent(
                                filteredusers: state.users.map((list) {
                                  if (list.isEmpty || list != state.users[tabIndex]) {
                                    return list;
                                  }
                                  final sortedList = List.of(list)
                                    ..sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
                                  return sortedList;
                                }).toList(),
                                currentTabIndex: tabIndex,
                                selectedSort: 'dsc',
                              ));
                            },
                            child: Text(
                              '9 \u{2191} 0',
                              style: TextStyle(
                                color: isSelected == null
                                    ? Colors.black
                                    : isSelected == 'dsc'
                                        ? Colors.blue
                                        : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
    icon: const Icon(Icons.sort),
    color: Colors.black,
  );
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
