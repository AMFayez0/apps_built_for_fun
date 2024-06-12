import 'package:app_built_for_fun/ChatApp/chat.dart';
import 'package:app_built_for_fun/LeagueOfLeagands/lol.dart';
import 'package:app_built_for_fun/WeatherApp/weather.dart';
import 'package:app_built_for_fun/navigation/bottom_nav_controller.dart';
import 'package:app_built_for_fun/pokomon/pages/pokemon_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bottomNavBarData = ref.watch(navProvider);
    return Scaffold(
      body: Center(
        child: pages[bottomNavBarData.index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItem,
        currentIndex: bottomNavBarData.index,
        onTap: (value) {
          ref.read(navProvider.notifier).setIndex(value);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 10,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        selectedIconTheme: const IconThemeData(
          size: 30,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 25,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.school),
      label: 'School',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
      const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  static final List<Widget> pages = <Widget>[
    const PokemonHomePage(),
    const Lol(),
    const Chat(),
    const Weather(),
    const Weather(),
  ];
}
