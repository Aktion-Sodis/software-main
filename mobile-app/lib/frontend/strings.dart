///hier die String jeweils in englisch hinterlegen und in allen anderen  angelegten Sprachen zumindest anlegen
///bei neuen strings am ende übersetzung anfordern
///

//todo: in klasse machen

String currentLanguage = "en";

Map<String, dynamic> stringMap = {
  "en": {
    "emailorphonenumber": "E-Mail/Phone number",
    "email": "E-Mail",
    "phonenumber": "Phone number",
    "password": "Password",
    "malformedemailmessage": "Please provide a valid e-mail address",
    "malformedphonenumber":
        "Please provide a phone number according to the format +123456879",
    "noaccountmessage":
        "Unfortunatley, no account exists for the provided information. If it is correct, please contact your account manager.",
    "enterpassword": "Enter password",
    "login": "Login",
    "or": "Or",
    "google_sign_in": "Sign in with Google",
    "invalid_password":
        "Please enter a valid password (minimum 6 patterns; at least one upper and lower case pattern; at least one number)",
    "not_same_password": "The provided passwords do not match.",
    "save_password": "Save",
    "change_password_text":
        "For security reasons, please set your own password!",
    "new_password": "New password",
    "new_password_validation": "New password (validation)"
  }
};

String get new_password => stringMap[currentLanguage]["new_password"];

String get new_password_validation =>
    stringMap[currentLanguage]["new_password_validation"];

String get emailorphonenumber =>
    stringMap[currentLanguage]["emailorphonenumber"];

String get invalid_password => stringMap[currentLanguage]["invalid_password"];

String get not_same_password => stringMap[currentLanguage]["not_same_password"];

String get save_password => stringMap[currentLanguage]["save_password"];

String get change_password_text =>
    stringMap[currentLanguage]["change_password_text"];

String get phonenumber => stringMap[currentLanguage]["phonenumber"];

String get email => stringMap[currentLanguage]["email"];

String get password => stringMap[currentLanguage]["password"];

String get malformedemailmessage =>
    stringMap[currentLanguage]["malformedemailmessage"];

String get malformedphonenumber =>
    stringMap[currentLanguage]["malformedphonenumber"];

String get noaccountmessage => stringMap[currentLanguage]["noaccountmessage"];

String get enterpassword => stringMap[currentLanguage]["enterpassword"];

String get login => stringMap[currentLanguage]["login"];

String get or => stringMap[currentLanguage]["or"];

String get google_sign_in => stringMap[currentLanguage]["google_sign_in"];
