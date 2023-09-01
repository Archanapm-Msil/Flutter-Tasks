import 'package:contact_app/APIServiceManager/contact_api_service.dart';
import 'package:contact_app/bloc/ContactBloc/contact_bloc.dart';
import 'package:contact_app/bloc/ContactBloc/contact_event.dart';
import 'package:contact_app/bloc/ContactBloc/contact_state.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  final VoidCallback onBackButtonPressed;

  const ContactScreen({
    Key? key,
    required this.onBackButtonPressed,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  List<List<Contact>> allList = [];
  late TabController _tabController;
  late ContactBloc _contactBloc;

  String? isSelected;

  @override
  void dispose() {
    _tabController.dispose();
    _contactBloc.close();
    super.dispose();
  }

  // void initState() {
  //   super.initState();
  //   final ContactAPI contactApi = ContactAPI();
  //   _contactBloc = ContactBloc(contactApi);
  //   _contactBloc.add(FetchContacts());
  //  _tabController = TabController(
  //     length: 1,
  //     vsync: this,
  //   );  // Initialize with a default length
  // }

  @override
  void initState() {
    super.initState();
    _contactBloc =
        BlocProvider.of<ContactBloc>(context); // Initialize ContactBloc
    _contactBloc.add(FetchContacts()); // Trigger the FetchContacts event
    _tabController = TabController(
      length: 1,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ContactBloc, ContactState>(
          // Use BlocBuilder to rebuild the UI based on ContactBloc state.
          builder: (context, state) {
            print(state);
            // if (state is ContactsLoaded) {
            //   allList = state.users;
            //   _tabController =
            //       TabController(length: state.users.length, vsync: this);
            // }

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
    print("tabs...!!");
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
    print("tabViews...!!");
    double height = MediaQuery.of(context).size.height;
    String contactNum = "";
    return tabs.asMap().entries.map((entry) {
      final tabIndex = entry.key; //  the current tab index
      final tabItems = entry.value; //  list of contacts for the current tab
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: tabItems.length,
              itemBuilder: (context, index) {
                final contact =
                    tabItems[index]; // Get the current contact for this index
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
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocConsumer<ContactBloc, ContactState>(
                        listener: (context, state) {
                          // if (state is ContactsLoaded) {
                          //   isSelected = state.selectedSort!;
                          // }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 16.0, 16.0, 0),
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
                                                color: Colors.blue),
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
                                          context
                                              .read<ContactBloc>()
                                              .add(OnSortEvent(
                                                filteredusers: allList,
                                                currentTabIndex:
                                                    _tabController.index,
                                                selectedSort: 'asc',
                                              ));
                                        },
                                        child: Text(
                                          '0 \u{2193} 9',
                                          style: TextStyle(
                                              color: isSelected == null
                                                  ? Colors.black
                                                  : isSelected! == 'asc'
                                                      ? Colors.blue
                                                      : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<ContactBloc>()
                                              .add(OnSortEvent(
                                                filteredusers: allList,
                                                currentTabIndex:
                                                    _tabController.index,
                                                selectedSort: 'dsc',
                                              ));
                                        },
                                        child: Text(
                                          '9 \u{2191} 0',
                                          style: TextStyle(
                                              color: isSelected == null
                                                  ? Colors.black
                                                  : isSelected! == 'dsc'
                                                      ? Colors.blue
                                                      : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle User ID sorting action
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      const Text('Add to Watchlist'),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          // Assuming tabItems[index] is the selected contact
                                          final int selectedTabIndex = tabIndex;
                                          final Contact selectedContact =
                                              tabItems[selectedTabIndex];

                                          Navigator.pushNamed(
                                            context,
                                            '/watchlist',
                                            arguments: {
                                              'contact': selectedContact,
                                              'tabIndex': tabIndex,
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.add_circle_outline),
                                        color: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle adding to watchlist
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
                icon: const Icon(Icons.sort_sharp),
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
