import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../../bloc/bloc.dart';

class IssueTabOrganism extends StatelessWidget {
  final TextEditingController searchController;

  IssueTabOrganism({this.searchController});

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Container(
        // padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: BlocBuilder<IssueBloc, IssueState>(
          builder: (context, state) {

            if(state is IssueInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.exclamationCircle),
                  SizedBox(height: 15),
                  Text('No data available'),
                ],
              );
            } else if(state is IssueLoadSuccess) {
              return IssueTabListTile(
                state: state,
                searchController: searchController,
              );
            } else if(state is IssueLoadInProgress) {
              return IssueTabListTile(
                state: state,
                searchController: searchController,
                loading: true,
              );
            } else if(state is IssueLoadFailure) {
              return IssueTabListTile(
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

class IssueTabListTile extends StatefulWidget {
  final state;
  final TextEditingController searchController;
  final loading;
  final error;

  IssueTabListTile({
    this.state,
    this.searchController,
    this.loading = false,
    this.error = false,
  });

  @override
  _IssueTabListTileState createState() => _IssueTabListTileState();
}

class _IssueTabListTileState extends State<IssueTabListTile> {

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
          context.read<IssueBloc>().add(FetchIssue(query: widget.searchController.text));
        },
        child: CustomScrollView(
          key: PageStorageKey<String>('issue_page_key'),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if(widget.loading && index == widget.state.issues.length) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child: NeumorphicProgressIndeterminate()
                    );
                  }
                  if(widget.error && index == widget.state.issues.length) {
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
                        backgroundImage: NetworkImage(widget.state.issues[index].user.avatar),
                      ),
                      title: Text(widget.state.issues[index].title),
                      subtitle: Text(
                        DateFormat('dd MMMM yyyy').format(widget.state.issues[index].lastUpdate)
                      ),
                      trailing: Text(
                        widget.state.issues[index].state
                      ),
                    )
                  );
                },
                childCount: !widget.loading && !widget.error
                  ? widget.state.issues.length
                  : widget.state.issues.length + 1,
              )
            )
          ],
        ),
      ),
    );
  }
}