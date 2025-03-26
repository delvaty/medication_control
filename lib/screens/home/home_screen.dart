// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medication_control/models/users.dart';
import 'package:medication_control/users/add_user_screen.dart';
import 'package:medication_control/users/register_user.dart';
import '../../controllers/home_controller.dart';

import '../../services/user_service.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/expandable_fab.dart';
import '../../widgets/user_list.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _controller = HomeController();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _controller.initAnimations(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showMedicationModal(BuildContext context) {
    showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.amber,
      context: context,
      builder: (context) => Container(
        width: 400,
        height: 250,
        alignment: Alignment.center,
        child: const Text('Breathe in... Breathe out...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (_controller.isExpanded) {
          setState(() {
            _controller.toggleMenu();
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFE5E5EA),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://picsum.photos/200"),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "robertdd",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: const AppDrawer(),
        body: _buildPageContent(context),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              _controller.onItemTapped(index);
            });
          },
          backgroundColor: Colors.white,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(LineIcons.home, size: 30, ),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(LineIcons.medicalBriefcase, size: 30, ),
              label: 'Medications',
            ),
            NavigationDestination(
              icon: Icon(LineIcons.bars, size: 30, ),
              label: 'More',
            ),
          ],
          selectedIndex: _controller.selectedIndex,
          indicatorColor: Colors.blueAccent,
        ),
        floatingActionButton: ExpandableFAB(
          controller: _controller,
          onAddMedicinePressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegistroPerfilScreen()),
            );
          },
          onAddDosePressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddUserScreen()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    if (_controller.selectedIndex == 0) {
      return StreamBuilder<List<Person>>(
        stream: _userService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No hay usuarios"),
            );
          }
          
          final users = snapshot.data!;
          return UserList(
            users: users,
            onDeleteUser: (userId) {
              _userService.deleteUser(userId);
            },
          );
        },
      );
    } else if (_controller.selectedIndex == 1) {
      return Center(
        child: ElevatedButton(
            onPressed: () => _showMedicationModal(context),
            child: const Text("Show the BottomSheet")),
      );
    } else {
      return Stack(
        children: [
          Container(
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Elemento 1'),
                const Text('Elemento 2'),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text('Elemento expandido'),
                    ),
                  ),
                ),
                const Text('Elemento 3'),
                const Text('Elemento 4'),
              ],
            ),
          ),
        ],
      );
    }
  }
}