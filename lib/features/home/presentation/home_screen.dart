import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_warranty_tracker/core/presentation/res/utils/system_ui_overlay_style.dart';
import 'package:flutter_warranty_tracker/features/article/presentation/add_product_screen.dart';
import 'package:flutter_warranty_tracker/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';

import '../../login/business_logic/auth_bloc.dart';
import '../../login/presentation/login_screen.dart';
import 'widgets/custom_app_bar_with_search_bar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: getSystemUiOverlayStyle(Theme.of(context), true),
        title: CustomAppBarWithSearchBar(
          user: user,
          title: 'home',
        ),
        scrolledUnderElevation: 0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            context.go(LoginScreen.routeName);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '36 Products',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  DropdownButton(
                    underline: Container(),
                    value: 'Recently Added',
                    style: Theme.of(context).textTheme.bodyMedium,
                    borderRadius: BorderRadius.circular(12.0),
                    elevation: 1,
                    items: const [
                      DropdownMenuItem(
                        value: 'Recently Added',
                        child: Text('Recently Added'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('Recently Added'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('Recently Added'),
                      ),
                      DropdownMenuItem(
                        value: '4',
                        child: Text('Recently Added'),
                      ),
                      DropdownMenuItem(
                        value: '5',
                        child: Text('Recently Added'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go("$routeName/${AddProductScreen.routeName}"),
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

// Text(
//   'Email: \n ${user.email}',
//   style: const TextStyle(fontSize: 24),
//   textAlign: TextAlign.center,
// ),
// user.photoURL != null
//     ? Image.network("${user.photoURL}")
//     : Container(),
// user.displayName != null
//     ? Text("${user.displayName}")
//     : Container(),
// const SizedBox(height: 16),
// ElevatedButton(
//   child: const Text('Sign Out'),
//   onPressed: () {
//     // Signing out the user
//     context.read<AuthBloc>().add(SignOutRequested());
//   },
// ),

// Text(
//   'Email: \n ${user.email}',
//   style: const TextStyle(fontSize: 24),
//   textAlign: TextAlign.center,
// ),
// user.photoURL != null
//     ? Image.network("${user.photoURL}")
//     : Container(),
// user.displayName != null
//     ? Text("${user.displayName}")
//     : Container(),
// const SizedBox(height: 16),
// TODO add sign out
// ElevatedButton(
//   child: const Text('Sign Out'),
//   onPressed: () {
//     // Signing out the user
//     context.read<AuthBloc>().add(SignOutRequested());
//   },
