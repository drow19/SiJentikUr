
userNameValidator(String value){
  return value.isEmpty || value.length < 4
      ? "Incorrect username"
      : null;
}

emailValidator(String value){
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)
      ? null
      : "Incorrect email";
}

passwordValidator(String value){
  if (value.isEmpty) {
    return "Password must not empty";
  } else if (value.length < 4) {
    return "Password must 6 character or more";
  } else {
    return null;
  }
}