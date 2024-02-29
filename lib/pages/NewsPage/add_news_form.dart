import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_voyage/services/firestore_service.dart';
import 'package:space_voyage/widgets/elevated_button.dart';
import 'package:space_voyage/widgets/text_field.dart';

class AddNewsForm extends StatefulWidget {
  const AddNewsForm({Key? key}) : super(key: key);

  @override
  State<AddNewsForm> createState() => _AddNewsFormState();
}

class _AddNewsFormState extends State<AddNewsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String explanation = _explanationController.text;
      DateTime now = DateTime.now();
      String date = '${now.year}-${now.month}-${now.day}';

      FireStoreService().addNewsToFirestore({
        "title": title,
        "explanation": explanation,
        "date": date,
      }).then((data) {
        if (data!["success"]) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 28, 28, 28),
              content: Text(
                "News added.",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 28, 28, 28),
              content: Text(
                data["error"],
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Add News",
            style: GoogleFonts.exo(
                textStyle: const TextStyle(color: Colors.white)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  controller: _titleController,
                  labelText: "Title",
                  icon: Icons.title,
                  autoFocus: true,
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: _explanationController,
                  labelText: "Explanation",
                  icon: Icons.description,
                  keyboardType: TextInputType.multiline,
                  maxLine: 5,
                ),
                const SizedBox(height: 16.0),
                CustomElevatedButton(
                  backgroundColor: Colors.blue,
                  onPressed: _submitForm,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
