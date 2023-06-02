import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';
import '../../model/objects.dart';
import '../../provider/customer_provider.dart';
import '../../utils/util_functions.dart';
import 'customer_by_id_screen.dart';

class SeachCustomersScreen extends StatefulWidget {
  const SeachCustomersScreen({Key? key}) : super(key: key);

  @override
  State<SeachCustomersScreen> createState() => _SeachCustomersScreenState();
}

class _SeachCustomersScreenState extends State<SeachCustomersScreen> {
  List<CustomerModel> _allUsers = [];
  List<CustomerModel> _foundUsers = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    final customerService =
        Provider.of<CustomerProvider>(context, listen: false);
    try {
      final List<Map<String, dynamic>> usersData =
          await AuthController.fetchUsers(customerService.getCustomer!.cus_nic);

      final List<CustomerModel> users = usersData.map((userData) {
        return CustomerModel.fromJson(userData);
      }).toList();

      setState(() {
        _isLoading = false;
        _allUsers = users;
        _foundUsers = _allUsers;
      });
    } catch (e) {
      print('Failed to fetch users: $e');
      // Handle error case
    }
  }

  void _runFilterValue(String enterKeyword) {
    List<CustomerModel> results = [];

    if (enterKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers.where((user) {
        final String name = user.cus_name.toLowerCase();
        final String age = user.cus_nic.toString().toLowerCase();
        final String keyword = enterKeyword.toLowerCase();

        return name.contains(keyword) || age.contains(keyword);
      }).toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search by email nic number...',
            hintStyle: const TextStyle(fontSize: 14, color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (value) => _runFilterValue(value.trim()),
        ),
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.purple,
          ),
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                padding: const EdgeInsets.all(3),
                icon: const Icon(
                  CupertinoIcons.chevron_left,
                  size: 18,
                ),
                color: Colors.white,
                onPressed: () {
                  UtilFuntions.goBack(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.search,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 10),
                itemCount: _foundUsers.length + 1,
                itemBuilder: (context, index) {
                  if (index == _foundUsers.length) {
                    // Display a loading indicator at the end of the list
                    if (_isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(); // Return an empty container if not loading
                    }
                  }

                  final user = _foundUsers[index];
                  return Column(
                    children: [
                      Consumer<CustomerProvider>(
                        builder: (context, value, child) {
                          return ListTile(
                            visualDensity: const VisualDensity(vertical: -3),
                            // style: ,
                            dense: true,
                            leading: user.cus_image != "null"
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://satasmeappdev.shop/uploads/customers/" +
                                            user.cus_image),
                                  )
                                : const CircleAvatar(
                                    // radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/avatar.jpg'),
                                  ),
                            title: Text(
                              user.cus_name,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.cus_email,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  user.cus_nic,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),

                            trailing: IconButton(
                              padding: const EdgeInsets.all(3),
                              icon: const Icon(
                                CupertinoIcons.chevron_right,
                                size: 18,
                              ),
                              color: Colors.grey,
                              onPressed: () {
                                value.setSeletedCustomer(context, user);
                                value.isAvailableCustomer(
                                    context,
                                    value.getCustomer!.cus_nic,
                                    user.id.toString());
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: CustomerByIdScreen(),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              tooltip: MaterialLocalizations.of(context)
                                  .openAppDrawerTooltip,
                            ),
                          );
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
