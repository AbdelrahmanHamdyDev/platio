import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:platio/Service/firebase.dart';
import 'package:platio/Controller/stateManagement.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:platio/View/Widget/customAppBar.dart';
import 'package:platio/View/Widget/cart_item.dart';
import 'package:platio/View/Widget/customBottomBar.dart';
import 'package:platio/View/Widget/menu_item.dart';
import 'package:platio/main.dart';

class listScreen extends ConsumerWidget {
  const listScreen({super.key, required this.type});

  final Listtype type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fireStore = FireStore();
    final cart = ref.watch(cartProvider);
    final totalPrice = cart.entries.fold(
      0.0,
      (sum, entry) => sum + (entry.key.price * entry.value),
    );

    return Scaffold(
      bottomNavigationBar:
          (type == Listtype.cart && cart.entries.isNotEmpty)
              ? customBottomBar(totalPrice: totalPrice)
              : null,
      body: SafeArea(
        child:
            (type == Listtype.menu)
                ? _buildMenuList(context, fireStore)
                : _buildCartList(context, cart, ref),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context, FireStore fireStore) {
    return FutureBuilder<List<menuItem_Model>>(
      future: fireStore.getMenuItems(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset('assets/Logo_Animation.json'),
            ),
          );
        }
        final menuItems = snapshot.data!;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 10,
              flexibleSpace: FlexibleSpaceBar(background: customAppBar()),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: menuItem_Widget(item: menuItems[index]),
                );
              }, childCount: menuItems.length),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCartList(
    BuildContext context,
    Map<menuItem_Model, int> cart,
    WidgetRef ref,
  ) {
    final cartEntries = cart.entries.toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height / 10,
          flexibleSpace: FlexibleSpaceBar(
            background: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).clearCart();
                  },
                  icon: const Icon(Icons.clear_all),
                ),
              ],
            ),
          ),
        ),

        if (cartEntries.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                "No items in cart",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final entry = cartEntries[index];
              final item = entry.key;
              final qty = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: cartItem_Widget(item: item, quantity: qty),
              );
            }, childCount: cartEntries.length),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
      ],
    );
  }
}
