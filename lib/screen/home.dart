

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/appbar.dart';
import 'package:flutter_application_1/constants/user_img_firestore.dart';
import 'package:flutter_application_1/screen/checkout.dart';
import 'package:flutter_application_1/screen/details_screen.dart';
import 'package:flutter_application_1/model/item.dart';
import 'package:flutter_application_1/provider/cart.dart';
import 'package:flutter_application_1/screen/profile_page.dart';
import 'package:flutter_application_1/screen/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userr = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[100],
        drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    UserAccountsDrawerHeader(
                        decoration:const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/beach.jpg'),
                                fit: BoxFit.cover)),
                        accountName: Text(
                          userr.displayName.toString(),
                          style:const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        accountEmail: Text(
                          userr.email!,
                          style:const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        currentAccountPictureSize:const Size.square(90),
                        currentAccountPicture:const ImgUser()),
                    ListTile(
                      leading:const Icon(Icons.home),
                      title:const Text('Home'),
                      onTap: () {
                      context.toView(const Home());
                      },
                    ),
                    ListTile(
                      leading:const Icon(Icons.add_shopping_cart),
                      title:const Text('My Products'),
                      onTap: () {
                      context.toView(const CheckOut());
                      },
                    ),
                    ListTile(
                      leading:const Icon(Icons.help_center),
                      title:const Text('About'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading:const Icon(Icons.person),
                      title:const Text('Profile Page'),
                      onTap: () {
                    context.toView(const ProfilePage());
                      },
                    ),
                    ListTile(
                      leading:const Icon(Icons.exit_to_app),
                      title:const Text('Logout'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        context.toView(const Signin());
                      },
                    ),
                  ],
                ),
                Container(
                  margin:const EdgeInsets.only(bottom: 25),
                  child:const Text(
                    'Developed by mostafa dawoud @ 2022',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ]),
        ),
        appBar: AppBar(
            backgroundColor:const Color.fromARGB(255, 76, 141, 95),
            title: Text(
              'Home',
              style: GoogleFonts.kaushanScript(
                textStyle:const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.5),
              ),
            ),
            centerTitle: true,
            actions: const [
              SoppingAndPrice(),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: GridView.builder(
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 35),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
          context.toView(Details(product: items[index]));
                  },
                  child: GridTile(
                      footer: GridTileBar(
                          leading:const Text(
                            '\$ 12.99',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 142, 240, 145),
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Consumer<Cart>(
                            builder: (context, cart, child) {
                              return IconButton(
                                iconSize: 27,
                                color:const Color.fromARGB(255, 142, 240, 145),
                                icon:const Icon(Icons.add),
                                onPressed: () {
                                  cart.add(items[index]);
                                },
                              );
                            },
                          ),
                          title: const Text('')),
                      child: Stack(children: [
                        Positioned(
                          top: -4,
                          bottom: -9,
                          right: 0,
                          left: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: Image.asset(
                              items[index].imgPath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ])),
                );
              }),
        ),
      ),
    );
  }
}

extension NavigatorExtention on BuildContext {
  toView(Widget view) {
    Navigator.push(this, MaterialPageRoute(builder: (context) {
      return view;
    }));
  }
}
