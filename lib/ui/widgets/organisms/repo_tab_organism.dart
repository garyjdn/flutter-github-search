import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../../bloc/bloc.dart';

class RepoTabOrganism extends StatelessWidget {
  final TextEditingController searchController;

  RepoTabOrganism({this.searchController});

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Container(
        // padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: BlocBuilder<RepoBloc, RepoState>(
          builder: (context, state) {

            if(state is RepoInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.exclamationCircle),
                  SizedBox(height: 15),
                  Text('No data available'),
                ],
              );
            } else if(state is RepoLoadSuccess) {
              return RepoTabListTile(
                state: state,
                searchController: searchController,
              );
            } else if(state is RepoLoadInProgress) {
              return RepoTabListTile(
                state: state,
                searchController: searchController,
                loading: true,
              );
            } else if(state is RepoLoadFailure) {
              return RepoTabListTile(
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

class RepoTabListTile extends StatefulWidget {
  final state;
  final TextEditingController searchController;
  final loading;
  final error;

  RepoTabListTile({
    this.state,
    this.searchController,
    this.loading = false,
    this.error = false,
  });

  @override
  _RepoTabListTileState createState() => _RepoTabListTileState();
}

class _RepoTabListTileState extends State<RepoTabListTile> {

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
          context.read<RepoBloc>().add(FetchRepo(query: widget.searchController.text));
        },
        child: CustomScrollView(
          key: PageStorageKey<String>('repo_page_key'),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if(widget.loading && index == widget.state.repos.length) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      child: NeumorphicProgressIndeterminate()
                    );
                  }
                  if(widget.error && index == widget.state.repos.length) {
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
                        backgroundImage: NetworkImage(widget.state.repos[index].user.avatar),
                      ),
                      title: Text(widget.state.repos[index].name),
                      subtitle: Text(
                        DateFormat('dd MMMM yyyy').format(widget.state.repos[index].createdAt)
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.eye, size: 14,),
                              SizedBox(width: 5),
                              Text(
                                NumberFormat.compact().format(widget.state.repos[index].watchers),
                                style: TextStyle(
                                  fontSize: 12,
                                )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.star, size: 14,),
                              SizedBox(width: 5),
                              Text(
                                NumberFormat.compact().format(widget.state.repos[index].stars),
                                style: TextStyle(
                                  fontSize: 12,
                                )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.gitAlt, size: 14,),
                              SizedBox(width: 5),
                              Text(
                                NumberFormat.compact().format(widget.state.repos[index].forks),
                                style: TextStyle(
                                  fontSize: 12,
                                )
                              ),
                            ],
                          )
                        ],
                      )
                    )
                  );
                },
                childCount: !widget.loading && !widget.error
                  ? widget.state.repos.length
                  : widget.state.repos.length + 1,
              )
            )
          ],
        ),
      ),
    );
  }
}