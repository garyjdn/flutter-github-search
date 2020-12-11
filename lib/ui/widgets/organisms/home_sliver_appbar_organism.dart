import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../bloc/bloc.dart';
import '../../ui.dart';

class HomeSliverAppBarOrganism extends StatefulWidget {
  final PageController pageController;
  final TextEditingController  searchController;
  // final TabController tabController;

  HomeSliverAppBarOrganism({
    this.pageController,
    this.searchController,
  });
  // HomeSliverAppBarOrganism({this.tabController});

  @override
  _HomeSliverAppBarOrganismState createState() => _HomeSliverAppBarOrganismState();
}

class _HomeSliverAppBarOrganismState extends State<HomeSliverAppBarOrganism> {
  int _selectedIndex;
  // TextEditingController _searchCtrl;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    // _searchCtrl = widget.searchController;
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      floating: true,
      snap: false,
      // collapsedHeight: 0,
      expandedHeight: 200,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: NeumorphicBackground(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Github Search',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  child: Neumorphic(
                    child: BlocBuilder<HomePageBloc, int>(
                      builder: (ctx, state) {
                        return TextFormField(
                          controller: widget.searchController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                          onFieldSubmitted: (String text) {
                            switch(state) {
                              case 0: {
                                context.read<IssueBloc>().add(ResetIssueSearch());
                                context.read<IssueBloc>().add(FetchIssue(query: text, page: 0));
                              }
                              break;

                              case 1: {
                                context.read<RepoBloc>().add(ResetRepoSearch());
                                context.read<RepoBloc>().add(FetchRepo(query: text, page: 0));
                              }
                              break;

                              case 2: {
                                context.read<UserBloc>().add(ResetUserSearch());
                                context.read<UserBloc>().add(FetchUser(query: text, page: 0));
                              }
                              break;
                            } 
                          },
                        );
                      }
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size(deviceSize.width, 60),
        child: BlocListener<HomePageBloc, int>(
          listener: (context, state) {
            setState(() => _selectedIndex = state);
          },
          child: NeumorphicBackground(
            backendColor: Colors.transparent,
            // padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: NeumorphicToggle(
              selectedIndex: _selectedIndex,
              thumb: Neumorphic(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(12))),
                ),
              ),
              children: [
                ToggleElement(
                  background: Center(child: Text("Issues", style: TextStyle(fontWeight: FontWeight.w500),)),
                  foreground: Center(child: Text("Issues", style: TextStyle(fontWeight: FontWeight.w700),)),
                ),
                ToggleElement(
                  background: Center(child: Text("Repository", style: TextStyle(fontWeight: FontWeight.w500),)),
                  foreground: Center(child: Text("Repository", style: TextStyle(fontWeight: FontWeight.w700),)),
                ),
                ToggleElement(
                  background: Center(child: Text("User", style: TextStyle(fontWeight: FontWeight.w500),)),
                  foreground: Center(child: Text("User", style: TextStyle(fontWeight: FontWeight.w700),)),
                )
              ],
              onChanged: (index) {
                widget.pageController.animateToPage(
                  index, 
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,);

                setState(() => _selectedIndex = index);
              },
            ),
          ),
        )
      )
    );
  }
}