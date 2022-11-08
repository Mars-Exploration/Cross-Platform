import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit/business_logic/cubit/right_drawer/left_drawer_cubit.dart';
import 'package:reddit/data/model/left_drawer/left_drawer_model.dart';

import '../../../data/repository/left_drawer/left_drawer_repository.dart';
import '../../../data/web_services/left_drawer/left_drawer_web_services.dart';

class LeftDrawer extends StatefulWidget {
  late bool _isLoggedIn;

  LeftDrawer(this._isLoggedIn, {Key? key}) : super(key: key);

  @override
  State<LeftDrawer> createState() => _LeftDrawerState(_isLoggedIn);
}

class _LeftDrawerState extends State<LeftDrawer> {
  late bool _isLoggedIn;
  late LeftDrawerRepository leftDrawerRepository =
      LeftDrawerRepository(LeftDrawerWebServices());

  List<LeftDrawerModel>? _moderating;
  List<LeftDrawerModel>? _yourCommunities;
  List<LeftDrawerModel>? _following;
  List<LeftDrawerModel>? _favorites;
  _LeftDrawerState(this._isLoggedIn);
  @override
  void initState() {
    super.initState();
    if (_isLoggedIn) {
      BlocProvider.of<LeftDrawerCubit>(context).getLeftDrawerData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      width: 300,
      child: widget._isLoggedIn
          ? _buildLoggedInEndDrawer(context)
          : _buildLoggedOutEndDrawer(context),
    );
  }

  Widget _buildLoggedInEndDrawer(context) {
    return SafeArea(
      child: Column(
        children: [
          _buildScrollViewButtons(),
        ],
      ),
    );
  }

  Widget _buildLoggedOutEndDrawer(context) {
    return SafeArea(
        child: Column(
      children: [
        ListTile(
          leading: const Icon(Icons.stacked_bar_chart),
          title: const Text("All"),
          onTap: () {
            // TODO: open a page with random posts
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Login to add your communities"),
          onTap: () {
            // TODO: open login dropdown
          },
        )
      ],
    ));
  }

  Widget _buildScrollViewButtons() {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<LeftDrawerCubit, LeftDrawerState>(
            builder: (context, state) {
              if (state is LeftDrawerDataLoaded) {
                _moderating = state.moderating;
                _yourCommunities = state.yourCommunities;
                _following = state.following;
                _favorites = state.favorites;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _favorites!.isNotEmpty
                        ? ExpansionTile(
                            initiallyExpanded: true,
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            maintainState: true,
                            title: const Text("Favorites"),
                            // Children are the subreddits that you are currently moderating
                            children: [
                              ..._favorites!.map(
                                (e) {
                                  return ListTile(
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      radius: 15.0,
                                      backgroundImage: NetworkImage(e.image!),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    title: Text("r/${e.name}"),
                                    trailing: IconButton(
                                        onPressed: () {
                                          _removeFromFavorites(e);
                                        },
                                        icon: const Icon(Icons.star)),
                                  );
                                },
                              ).toList(),
                            ],
                          )
                        : const SizedBox(),
                    ExpansionTile(
                      initiallyExpanded: true,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      maintainState: true,
                      title: const Text("Moderation"),
                      // Children are the subreddits that you are currently moderating
                      children: [
                        ..._moderating!.map(
                          (e) {
                            return ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 15.0,
                                backgroundImage: NetworkImage(e.image!),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text("r/${e.name}"),
                              trailing: e.favorite!
                                  ? IconButton(
                                      onPressed: () {
                                        _removeFromFavorites(e);
                                      },
                                      icon: const Icon(Icons.star))
                                  : IconButton(
                                      onPressed: () {
                                        _addToFavorites(e);
                                      },
                                      icon: const Icon(Icons.star_border)),
                            );
                          },
                        ).toList(),
                      ],
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      maintainState: true,
                      title: const Text("Your Communities"),
                      // Children are the subreddits that you are currently moderating
                      children: [
                        ListTile(
                          leading: const FaIcon(FontAwesomeIcons.plus),
                          title: const Text("Create a community"),
                          onTap: () {
                            // TODO: got to create community page
                          },
                        ),
                        ..._yourCommunities!.map(
                          (e) {
                            return ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 15.0,
                                backgroundImage: NetworkImage(e.image!),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text("r/${e.name}"),
                              trailing: e.favorite!
                                  ? IconButton(
                                      onPressed: () {
                                        _removeFromFavorites(e);
                                      },
                                      icon: const Icon(Icons.star))
                                  : IconButton(
                                      onPressed: () {
                                        _addToFavorites(e);
                                      },
                                      icon: const Icon(Icons.star_border)),
                            );
                          },
                        ).toList(),
                      ],
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      maintainState: true,
                      title: const Text("Following"),
                      // Children are the subreddits that you are currently moderating
                      children: [
                        ..._following!.map(
                          (e) {
                            return ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                radius: 15.0,
                                backgroundImage: NetworkImage(e.image!),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text("r/${e.name}"),
                              trailing: e.favorite!
                                  ? IconButton(
                                      onPressed: () {
                                        _removeFromFavorites(e);
                                      },
                                      icon: const Icon(Icons.star))
                                  : IconButton(
                                      onPressed: () {
                                        _addToFavorites(e);
                                      },
                                      icon: const Icon(Icons.star_border)),
                            );
                          },
                        ).toList(),
                      ],
                    ),

                    // All button
                    ListTile(
                      leading: const Icon(Icons.stacked_bar_chart),
                      title: const Text("All"),
                      onTap: () {
                        // TODO: open a page where the user sees posts from all the communities
                        // joint, moderating, and following accounts
                      },
                    )
                  ],
                );
              } else
                return Container();
            },
          ),
        ),
      ),
    );
  }

  // TODO: complete these functions
  void _addToFavorites(LeftDrawerModel leftDrawerModel) {
    BlocProvider.of<LeftDrawerCubit>(context).addToFavorites(leftDrawerModel);
  }

  void _removeFromFavorites(LeftDrawerModel leftDrawerModel) {
    BlocProvider.of<LeftDrawerCubit>(context)
        .removeFromFavorites(leftDrawerModel);
  }
}
