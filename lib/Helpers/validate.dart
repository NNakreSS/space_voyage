String? isEmptyFieldValitede(value) =>
    (value!.isEmpty) ? "This field cannot be empty." : null;

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  }
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}
