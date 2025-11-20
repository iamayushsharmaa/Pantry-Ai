import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantry_ai/core/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _selectedStatus = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pantry AI',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [const SizedBox(height: 10)],
        ),
      ),
    );
  }

  Widget _scannerCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SvgPicture.asset(
            'assets/icons/scan.svg',
            height: 30,
            width: 30,
            colorFilter: const ColorFilter.mode(
              AppColors.kBrandColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Scan Ingredients',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),

          const Text(
            'Tap to scan your pantry or \nupload a photo',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white54,
            ),
          ),

          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kBrandColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start scanning',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/icons/scan.svg',
                    height: 20,
                    width: 20,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
