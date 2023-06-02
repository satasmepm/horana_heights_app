import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horana_heights/screens/customers/search_home_by_floorid_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../controller/house_controller.dart';
import '../../model/objects.dart';
import '../../provider/customer_provider.dart';
import '../../utils/util_functions.dart';

class SeachFloorByTowerScreen extends StatefulWidget {
  final String selectedIndex;
  const SeachFloorByTowerScreen({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<SeachFloorByTowerScreen> createState() =>
      _SeachFloorByTowerScreenState();
}

class _SeachFloorByTowerScreenState extends State<SeachFloorByTowerScreen> {
  List<FloorModel> _allFloors = [];
  List<FloorModel> _foundFloors = [];
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
          await HouseController.getAllFloors(
              customerService.getCustomer!.cus_nic, widget.selectedIndex);

      final List<FloorModel> users = usersData.map((userData) {
        return FloorModel.fromJson(userData);
      }).toList();

      setState(() {
        _isLoading = false;
        _allFloors = users;
        _foundFloors = _allFloors;
      });
    } catch (e) {
      print('Failed to fetch users: $e');
      // Handle error case
    }
  }

  void _runFilterValue(String enterKeyword) {
    List<FloorModel> results = [];

    if (enterKeyword.isEmpty) {
      results = _allFloors;
    } else {
      results = _allFloors.where((user) {
        final String name = user.floor_number.toLowerCase();
        final String age = user.created_at.toString().toLowerCase();
        final String keyword = enterKeyword.toLowerCase();

        return name.contains(keyword) || age.contains(keyword);
      }).toList();
    }

    setState(() {
      _foundFloors = results;
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
                itemCount: _foundFloors.length + 1,
                itemBuilder: (context, index) {
                  if (index == _foundFloors.length) {
                    // Display a loading indicator at the end of the list
                    if (_isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(); // Return an empty container if not loading
                    }
                  }

                  final floor = _foundFloors[index];
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
                              "floor Name",
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  floor.floor_number,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  floor.created_at,
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
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: SeachHomeByFloorScreen(
                                          selectedIndex: floor.id.toString()),
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
