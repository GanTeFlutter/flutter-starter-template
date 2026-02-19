import 'package:akillisletme/feature/home/home_view.dart';
import 'package:flutter/material.dart';

abstract class HomeViewMode extends State<HomeView> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
