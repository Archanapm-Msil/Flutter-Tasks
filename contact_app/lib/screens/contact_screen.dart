import 'package:contact_app/APIServiceManager/contact_api_service.dart';
import 'package:contact_app/bloc/ContactBloc/contact_bloc.dart';
import 'package:contact_app/bloc/ContactBloc/contact_event.dart';
import 'package:contact_app/bloc/ContactBloc/contact_state.dart';
import 'package:contact_app/bloc/WatchlistBloc/watchlist_bloc.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  final VoidCallback onBackButtonPressed;
   final int tabIndex;
  
  const ContactScreen({
    Key? key,
    required this.onBackButtonPressed,
    required this.tabIndex, 
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  List<List<Contact>> allList = [];
  late TabController _tabController;
  late ContactBloc _contactBloc;
  Set<Contact> selectedContacts = Set();
  int _previouslySelectedTabIndex = 0;
  int _currentTabIndex = 0;
  String? isSelected;
  List<Set<Contact>> selectedContactsByTab = [];


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _contactBloc = BlocProvider.of<ContactBloc>(context);
    _contactBloc.add(FetchContacts());
    _tabController = TabController(
      length: 1,
      vsync: this,
    );
  }

   void _handleAddToWatchlist() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WatchlistScreen(
        selectedContacts: selectedContacts,
      ),
    ),
  );
}


  void toggleContactSelection(Contact contact) {
    setState(() {
      if (selectedContacts.contains(contact)) {
        selectedContacts.remove(contact);
      } else {
        selectedContacts.add(contact);
      }
    });
  }

  void addToWatchlistTab(int tabIndex) {
    _currentTabIndex = tabIndex;
    context.read<ContactBloc>().add(
      ContactAddToWatchlistEvent(selectedContacts.toList(), tabIndex),
    );
    selectedContacts.clear();
    print("added..!!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ContactsLoaded) {
              allList = state.users;
              _tabController = TabController(
                length: state.users.length,
                vsync: this,
              );
            }

            if (state is ContactsLoaded) {
              final tabs = state.users;
              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_2,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Contacts List',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TabBar(
                          onTap: (tabIndex) {
                            isSelected = '';
                            context.read<ContactBloc>().add(OnSortEvent(
                                filteredusers: allList,
                                currentTabIndex: tabIndex,
                                selectedSort: 'asc'));
                          },
                          controller: _tabController,
                          isScrollable: true,
                          tabs: _buildTabBarTabs(tabs),
                          indicatorColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: _buildTabBarViews(tabs, context),
                    ),
                  ),
                ],
              );
            }

            if (state is ContactsError) {
              return const Center(
                child: Text('Something Went Wrong!'),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  List<Widget> _buildTabBarTabs(List<List<Contact>> tabs) {
    return tabs.map((tabItems) {
      return Tab(
        child: Text(
          'Contact Group ${tabs.indexOf(tabItems) + 1}',
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
    }).toList();
  }

  List<Widget> _buildTabBarViews(List<List<Contact>> tabs, context) {
    double height = MediaQuery.of(context).size.height;
    String contactNum = "";
    return tabs.asMap().entries.map((entry) {
      final tabIndex = entry.key;
      final tabItems = entry.value;

      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: tabItems.length,
              itemBuilder: (context, index) {
                final contact = tabItems[index];
                final isSelected = selectedContacts.contains(contact);

                return GestureDetector(
                  onTap: () {
                    toggleContactSelection(contact);
                  },
                  child: Container(
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
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            )
                          : const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://via.placeholder.com/150',
                              ),
                              radius: 20,
                            ),
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
                  _handleAddToWatchlist();
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
