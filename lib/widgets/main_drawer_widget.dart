import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 250,
        child: Column(
          children: [
            buildDrawerHeader(context),
            Expanded(child: buildDrawerBody(context))
          ],
        ));
  }

  buildDrawerHeader(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: Colors.blue[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.black54),
              ),
              IconButton(
                  onPressed: () {},
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.donut_large_outlined)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 2, 0, 0),
            child: Text(
              'Name',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'email123@gmail.com',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize),
            ),
          )
        ],
      ),
    );
  }

  buildDrawerBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            dense: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
            ),
          ),
          ListTile(
            onTap: () {},
            dense: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            leading: const Icon(Icons.account_circle),
            title: Text(
              'Profile',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
            ),
          ),
          ListTile(
            onTap: () {},
            dense: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            leading: const Icon(
              Icons.edit_note_sharp,
            ),
            title: Text(
              'Manage',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
            ),
          ),
          ListTile(
            onTap: () {},
            dense: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            leading: const Icon(Icons.bookmark_outlined),
            title: Text(
              'Saved',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.black,
          ),
          ListTile(
            onTap: () {},
            dense: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            leading: const Icon(Icons.help),
            title: Text(
              'Help',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
            ),
          ),
          ListTile(
            onTap: () {},
            dense: true,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            leading: const Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
