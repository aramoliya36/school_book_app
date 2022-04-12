import 'package:skoolmonk/screens/resetpasswordscreen/reset_password_screen.dart';

class Utility {
  static String privacyPolicyLink = "";
  static String termsConditionsLink = "";
  static String refundPolicyLink = "";
  static String faqLink = "";
  static String helpLink = "";
  static int perPageSize = 15;
  static String isMultiFilter = "yes";

  static String emailAddressValidationPattern = r"([a-zA-Z0-9_@.])";
  static String password = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String emailText = "email";
  static String addressText = "address";
  static String passwordText = "password";
  static String nameEmptyValidation = "Name is required";
  static String lastNameEmptyValidation = "Last Name is required";
  static String emailEmptyValidation = "Email is required";
  static String stateEmptyValidation = "state is required";
  static String pincodeEmptyValidation = "Pincode is required";
  static String cityEmptyValidation = "city is required";
  static String addressEmptyValidation = "Address is required";
  static String kUserNameEmptyValidation = 'Please Enter Valid Email';
  static String kPasswordEmptyValidation = 'Please Enter Password';
  static String kPasswordLengthValidation = 'Must be more than 6 Characters';
  static String kPasswordInValidValidation = 'Password Invalid';
  static String mobileNumberInValidValidation = "Mobile Number is required";
  static String alphabetValidationPattern = r"[a-zA-Z]";
  static String alphabetSpaceValidationPattern = r"[a-zA-Z ]";
  static String alphabetDigitsValidationPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpaceValidationPattern = r"[a-zA-Z0-9 ]";

  static String alphabetDigitsSpacePlusValidationPattern = r"[a-zA-Z0-9+ ]";

  static String alphabetDigitsSpecialValidationPattern = r"[a-zA-Z0-9#&$%_@. ]";

  static String alphabetDigitsDashValidationPattern = r"[a-zA-Z0-9- ]";
  static String addressValidationPattern = r"[a-zA-Z0-9-@#&*, ]";
  static String digitsValidationPattern = r"[0-9]";
  static String allSportPattern = r'^\[:\.\]$';

  static String passwordNotMatch =
      "Password and Conform password does not match!";
  static String termsConditions = "Terms & Conditions";
  static String termsConditionsMessage = "Please check Term Condition!";
  static String uploadingTitle = "Uploading Message";
  static String downloadingTitle = "Download Message";
  static String loginError = "Login Error";
  static String invalidPasswordMessage =
      "The password is invalid or the user does not have a password.";
  static String userNotExist = "User Not Exist!";
  static String notificationText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  static String aboutUs =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n  \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ";
  static int kPasswordLength = 6;

  static String validateUserName(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool regex = new RegExp(pattern).hasMatch(value);
    if (value.isEmpty) {
      return kUserNameEmptyValidation;
    } else if (regex == false) {
      return kUserNameEmptyValidation;
    }
    return null;
  }

  static String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return kPasswordEmptyValidation;
    } else if (value.length < kPasswordLength) {
      return kPasswordLengthValidation;
    }
    return null;
  }

  static String confirmPassword(String value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Password';
    } else if (value.trim().length < 6) {
      return 'Must be more than 8 Characters';
    } else if (value != passwordTextEditingController.text) {
      return "Password and Confirm password does not match";
    } else {
      return null;
    }
  }
}
