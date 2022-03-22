///hier die String jeweils in englisch hinterlegen und in allen anderen  angelegten Sprachen zumindest anlegen
///bei neuen strings am ende übersetzung anfordern
///

//todo: in klasse machen

String currentLanguage = "en-US";

Map<String, dynamic> stringMap = {
  "en-US": {
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
    "new_password_validation": "New password (validation)",
    "test_list": "Tests",
    "user_forename": "Forename",
    "user_surname": "Surname",
    "user_please_enter_forename": "Please enter your forename",
    "user_please_enter_surename": "Please enter your surename",
    "user_create_save": "Okay",
    "user_create_info":
        "Please enter your prename and surname to finish account creation. If you want, you can take a profile pic!",
    "logout": "Log out",
    "main_menu_home": "Home",
    "main_menu_organization": "Organization",
    "main_menu_tasks": "Tasks",
    "main_menu_wiki": "Wiki",
    "question_type_descriptions":{
      "sc" : "One answer only",
      "mc" : "Multiple answers possible",
      "text_field": "Write down your answer",
    },
    "summary":"summary",
    "end_survey":"Are you sure you want to end the survey?",
    "saved_survey":"Thank you for answering the survey",
  }
};

String get main_menu_home => stringMap[currentLanguage]["main_menu_home"];

String get main_menu_organization =>
    stringMap[currentLanguage]["main_menu_organization"];

String get main_menu_tasks => stringMap[currentLanguage]["main_menu_tasks"];

String get main_menu_wiki => stringMap[currentLanguage]["main_menu_wiki"];

String get user_forename => stringMap[currentLanguage]["user_forename"];

String get user_surname => stringMap[currentLanguage]["user_surname"];

String get user_please_enter_forename =>
    stringMap[currentLanguage]["user_please_enter_forename"];

String get user_please_enter_surename =>
    stringMap[currentLanguage]["user_please_enter_surename"];

String get user_create_save => stringMap[currentLanguage]["user_create_save"];

String get user_create_info => stringMap[currentLanguage]["user_create_info"];

String get logout => stringMap[currentLanguage]["logout"];

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

String get test_list => stringMap[currentLanguage]["test_list"];

String get singleChoiceTypeDescription => stringMap[currentLanguage]["question_type_descriptions"]["sc"];
String get multipleChoiceTypeDescription => stringMap[currentLanguage]["question_type_descriptions"]["mc"];
String get textFieldTypeDescription => stringMap[currentLanguage]["question_type_descriptions"]["text_field"];
String get summary => stringMap[currentLanguage]["summary"];
String get endSurvey => stringMap[currentLanguage]["end_survey"];
String get savedSurvey => stringMap[currentLanguage]["saved_survey"];
