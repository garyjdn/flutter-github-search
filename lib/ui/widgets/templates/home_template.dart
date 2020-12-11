import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_search/bloc/bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../widgets.dart';
import '../../../bloc/bloc.dart';

class HomeTemplate extends StatefulWidget {

  @override
  _HomeTemplateState createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  TextEditingController _searchController;
  PageController _pageController;

  @override initState() {
    super.initState();
    _searchController = TextEditingController();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: HomeSliverAppBarOrganism(
                  pageController: _pageController,
                  searchController: _searchController,
                ),
              ),
            ];
          },
          body: PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              context.read<HomePageBloc>().add(ChangePage(index));
            },
            children: [
              IssueTabOrganism(searchController: _searchController,),
              RepoTabOrganism(searchController: _searchController,),
              UserTabOrganism(searchController: _searchController,),
            ],
          ),
        ),
      ),
    );
  }
}