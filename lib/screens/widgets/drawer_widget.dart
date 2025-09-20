import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/blackLogo.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'News Snap',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      'Discover headlines at a glance in this very simple card-swipe news app — swipe through clean, easy-to-read article cards, save favorites, and stay informed with a fast, minimal experience.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ),

                  //content of the drawer
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Connect with me',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                SocialMediaCArd(
                  name: 'LinkedIn',
                  icon: Brand(Brands.linkedin),
                  url: 'https://www.linkedin.com/in/baraa-mabrok-6b15b1356/',
                  backgroundColor: Colors.lightBlueAccent.shade400,
                ),
                SizedBox(height: 20),

                SocialMediaCArd(
                  name: 'GitHub',
                  icon: Icon(BoxIcons.bxl_github, size: 35),
                  url: 'https://github.com/baraa404',
                  backgroundColor: Colors.black,
                ),
                SizedBox(height: 20),

                SocialMediaCArd(
                  name: 'WhatsApp',
                  icon: Brand(Brands.whatsapp),
                  url: 'https://api.whatsapp.com/send?phone=201064925971',
                  backgroundColor: Colors.green.shade400,
                ),
                SizedBox(height: 20),
                SocialMediaCArd(
                  name: 'Email',
                  icon: Brand(Brands.gmail),
                  url: 'mailto:baraa404@gmail.com',
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMediaCArd extends StatelessWidget {
  const SocialMediaCArd({
    super.key,
    required this.name,
    required this.icon,
    required this.url,
    required this.backgroundColor,
  });
  final String name;
  final String url;
  final Widget icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //launch the url
        launchUrl(Uri.parse(url));
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.values[8],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
