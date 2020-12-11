import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../../bloc/bloc.dart';

class UserTabOrganism extends StatelessWidget {
  final TextEditingController searchController;

  UserTabOrganism({this.searchController});

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Container(
        // padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {

            if(state is UserInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.exclamationCircle),
                  SizedBox(height: 15),
                  Text('No data available'),
                ],
              );
            } else if(state is UserLoadSuccess) {
              return UserTabListTile(
                state: state,
                searchController: searchController,
              );
            } else if(state is UserLoadInProgress) {
              return UserTabListTile(
                state: state,
                searchController: searchController,
                loading: true,
              );
            } else if(state is UserLoadFailure) {
              return UserTabListTile(
                state: state,
                searchController: searchController,
                loading: false,
              );
            } else {
              return Container();
            }
          }
        ),
      ),
    );
  }
}

class UserTabListTile extends StatefulWidget {
  final state;
  final TextEditingController searchController;
  final loading;
  final error;

  UserTabListTile({
    this.state,
    this.searchController,
    this.loading = false,
    this.error = false,
  });

  @override
  _UserTabListTileState createState() => _UserTabListTileState();
}

class _UserTabListTileState extends State<UserTabListTile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LazyLoadScrollView(
        scrollOffset: 50,
        onEndOfPage: () {
          context.read<UserBloc>().add(FetchUser(query: widget.searchController.text));
        },
        child: CustomScrollView(
          key: PageStorageKey<String>('user_page_key'),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if(widget.loading && index == widget.state.users.length) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child: NeumorphicProgressIndeterminate()
                    );
                  }
                  if(widget.error && index == widget.state.users.length) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child: Center(child: Text('Oops, something went wrong.'))
                    );
                  }
                  return Neumorphic(
                    style: NeumorphicStyle(
                      depth: 6,
                    ),
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(widget.state.users[index].avatar),
                      ),
                      title: Text(widget.state.users[index].username),
                    )
                  );
                },
                childCount: !widget.loading && !widget.error
                  ? widget.state.users.length
                  : widget.state.users.length + 1,
              )
            )
          ],
        ),
      ),
    );
  }
}