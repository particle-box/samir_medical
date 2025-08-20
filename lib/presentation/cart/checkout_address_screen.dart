import 'package:flutter/material.dart';

class CheckoutAddressScreen extends StatefulWidget {
  final void Function(String name, String address, String phone) onNext;
  const CheckoutAddressScreen({super.key, required this.onNext});

  @override
  State<CheckoutAddressScreen> createState() => _CheckoutAddressScreenState();
}

class _CheckoutAddressScreenState extends State<CheckoutAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final addressC = TextEditingController();
  final phoneC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    addressC.dispose();
    phoneC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Shipping Address', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 18),
          TextFormField(
            controller: nameC,
            decoration: const InputDecoration(labelText: "Name"),
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: addressC,
            decoration: const InputDecoration(labelText: "Address"),
            minLines: 2,
            maxLines: 3,
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: phoneC,
            decoration: const InputDecoration(labelText: "Phone number"),
            keyboardType: TextInputType.phone,
            validator: (v) => v == null || v.length < 10 ? 'Enter valid number' : null,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                widget.onNext(nameC.text.trim(), addressC.text.trim(), phoneC.text.trim());
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
