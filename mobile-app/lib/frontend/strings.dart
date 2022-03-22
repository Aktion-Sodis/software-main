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
    "organization_view_taks": "Tasks",
    "organization_view_surveys": "Surveys",
    "organization_view_applied_interventions": "Interventions",
    "organization_view_info": "Information",
    "organization_view_history": "History",
    "organization_view_dialog_add_entity": "Add Entity",
    "organization_view_dialog_edit_entity": "Edit Entity",
    "organization_view_entity_name": "Name",
    "organization_view_entity_description": "Description",
    "organization_view_entity_save_entity": "Save Entity",
    "organization_view_entity_save_changes": "Save Changes",
    "organization_view_info_button": "Info",
    "organization_view_entity_enter_name": "Please enter a name",
    "organization_view_entity_enter_description": "Please enter a description",
  }
};

String get organization_view_entity_enter_name =>
    stringMap[currentLanguage]["organization_view_entity_enter_name"];

String get organization_view_entity_enter_description =>
    stringMap[currentLanguage]["organization_view_entity_enter_description"];

String get organization_view_info_button =>
    stringMap[currentLanguage]["organization_view_info_button"];

String get organization_view_history =>
    stringMap[currentLanguage]["organization_view_history"];

String get organization_view_taks =>
    stringMap[currentLanguage]["organization_view_taks"];

String get organization_view_surveys =>
    stringMap[currentLanguage]["organization_view_surveys"];

String get organization_view_applied_interventions =>
    stringMap[currentLanguage]["organization_view_applied_interventions"];

String get organization_view_info =>
    stringMap[currentLanguage]["organization_view_info"];

String get organization_view_dialog_add_entity =>
    stringMap[currentLanguage]["organization_view_dialog_add_entity"];

String get organization_view_dialog_edit_entity =>
    stringMap[currentLanguage]["organization_view_dialog_edit_entity"];

String get organization_view_entity_name =>
    stringMap[currentLanguage]["organization_view_entity_name"];

String get organization_view_entity_description =>
    stringMap[currentLanguage]["organization_view_entity_description"];

String get organization_view_entity_save_entity =>
    stringMap[currentLanguage]["organization_view_entity_save_entity"];

String get organization_view_entity_save_changes =>
    stringMap[currentLanguage]["organization_view_entity_save_changes"];

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
