import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/providers/contact_provider.dart';

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact;

  AddEditContactScreen({this.contact});

  @override
  _AddEditContactScreenState createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _email;

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _name = widget.contact!.name;
      _phone = widget.contact!.phone;
      _email = widget.contact!.email;
    } else {
      _name = '';
      _phone = '';
      _email = '';
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final contact = Contact(
        id: widget.contact != null
            ? widget.contact!.id
            : DateTime.now().toString(),
        name: _name,
        phone: _phone,
        email: _email,
      );
      if (widget.contact != null) {
        Provider.of<ContactProvider>(context, listen: false)
            .updateContact(contact);
      } else {
        Provider.of<ContactProvider>(context, listen: false)
            .addContact(contact);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact != null ? 'Edit Contact' : 'Add Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
