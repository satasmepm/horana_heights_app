import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/house_controller.dart';
import '../../model/objects.dart';
import '../../provider/customer_provider.dart';
import '../../utils/util_functions.dart';

class SeachHomeByFloorScreen extends StatefulWidget {
  final String selectedIndex;
  const SeachHomeByFloorScreen({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<SeachHomeByFloorScreen> createState() => _SeachHomeByFloorScreenState();
}

class _SeachHomeByFloorScreenState extends State<SeachHomeByFloorScreen> {
  HouseController _houseService = HouseController();

  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();
  List<HomeModel> _allHomes = [];
  List<HomeModel> _foundHomes = [];

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
          await HouseController.getAllHomes(
              customerService.getCustomer!.cus_nic, widget.selectedIndex);

      final List<HomeModel> users = usersData.map((userData) {
        return HomeModel.fromJson(userData);
      }).toList();

      setState(() {
        _isLoading = false;
        _allHomes = users;
        _foundHomes = _allHomes;
      });
    } catch (e) {
      print('Failed to fetch users: $e');
      // Handle error case
    }
  }

  void _runFilterValue(String enterKeyword) {
    List<HomeModel> results = [];

    if (enterKeyword.isEmpty) {
      results = _allHomes;
    } else {
      results = _allHomes.where((user) {
        final String name = user.home_number.toLowerCase();
        final String age = user.created_at.toString().toLowerCase();
        final String keyword = enterKeyword.toLowerCase();

        return name.contains(keyword) || age.contains(keyword);
      }).toList();
    }

    setState(() {
      _foundHomes = results;
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
            hintText: 'Search by floor number...',
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
                itemCount: _foundHomes.length + 1,
                itemBuilder: (context, index) {
                  if (index == _foundHomes.length) {
                    // Display a loading indicator at the end of the list
                    if (_isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(); // Return an empty container if not loading
                    }
                  }

                  final home = _foundHomes[index];
                  return Column(
                    children: [
                      Consumer<CustomerProvider>(
                        builder: (context, value, child) {
                          return ListTile(
                            visualDensity: const VisualDensity(vertical: -3),
                            // style: ,
                            dense: true,
                            leading: const Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: Colors.lightGreen,
                            ),
                            title: const Text(
                              "Home Number",
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  home.home_number,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  home.created_at,
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
                                value.showLoadingDialog(context);

                                value.isAvailableAsignedHome(
                                    context,
                                    value.getCustomer!.cus_nic,
                                    home.id.toString());
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

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20.0),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
