import 'package:akillisletme/feature/home/home_view.dart';
import 'package:flutter/material.dart';

abstract class HomeViewMode extends State<HomeView> {
  late final ScrollController scrollController;
  late final TextEditingController textController;

  // Switch
  bool switchValue = false;

  // Checkbox
  bool checkboxValue = false;

  // Radio
  int radioValue = 0;

  // Slider
  double sliderValue = 0.5;

  // Filter chips
  Set<int> selectedFilters = {0};

  // Choice chip
  int choiceIndex = 0;

  // SegmentedButton
  Set<String> segmentSelection = {'day'};

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    super.dispose();
  }
}
