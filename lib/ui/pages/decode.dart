import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Decode extends StatefulWidget {
  const Decode({Key? key}) : super(key: key);

  @override
  _DecodeState createState() => _DecodeState();
}

class _DecodeState extends State<Decode> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    validatorForm(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }

    return ListView(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.white])),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 25, 16, 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: validatorForm,
                      controller: inputController,
                      minLines:
                          10, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Enter Decode",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var decoded = base64
                                    .decode(inputController.text.toString());
                                setState(() {
                                  outputController.text = utf8.decode(decoded);
                                });
                              }
                            },
                            icon: Icon(Icons.vpn_key),
                            label: Text("Decode")),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              Clipboard.getData(Clipboard.kTextPlain)
                                  .then((value) {
                                setState(() {
                                  inputController.text =
                                      inputController.text + value!.text!;
                                });
                              });
                            },
                            icon: Icon(Icons.paste),
                            label: Text("Paste")),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text("Clear"),
                          onPressed: () {
                            setState(() {
                              inputController.text = "";
                              outputController.text = "";
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: outputController,
                      enabled: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Ouput Decode",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () async {
                              Clipboard.setData(ClipboardData(
                                  text: outputController.text.toString()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Copy Successful')),
                              );
                                  
                            },
                            icon: Icon(Icons.copy),
                            label: Text("Copy")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
