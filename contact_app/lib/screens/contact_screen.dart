import 'package:contact_app/ContactBloc/contact_bloc.dart';
import 'package:contact_app/ContactBloc/contact_event.dart';
import 'package:contact_app/ContactBloc/contact_state.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key, Key? key1});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  List<List<Contact>> allList = [];
  late TabController _tabController;

  String? isSelected;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ContactBloc, ContactState>(
          listener: (context, state) {
            if (state is ContactsLoaded) {
              allList = state.users;
              _tabController =
                  TabController(length: state.users.length, vsync: this);
            }
          },
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FilterdState) {
              final tabs = state.filteredusers;
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
                                  color: Colors.white
                                ),
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
    return tabs.map((tabItems) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: tabItems.length,
              itemBuilder: (context, index) {
                final item = tabItems[index];
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
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(item.contacts),
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
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset in x and y direction
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
                          if (state is FilterdState) {
                            isSelected = state.selectedSort!;
                          }
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
