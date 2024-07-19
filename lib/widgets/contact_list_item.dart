import 'package:flutter/material.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/screens/contact_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:contacts_app/providers/contact_provider.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  ContactListItem({required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      trailing: IconButton(
        icon: Icon(contact.isFavorite ? Icons.star : Icons.star_border),
        onPressed: () {
          Provider.of<ContactProvider>(context, listen: false)
              .toggleFavoriteStatus(contact);
        },
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ContactProfileScreen(contact: contact),
        ));
      },
    );
  }
}
