validateInput(inputValue, validateArray, errorArray) {
  var returnErrorMsg = '';
  bool errorMsg = false;
  validateArray.forEach((arrayKey, arrayValue) {
    if (!errorMsg) {
      switch (arrayKey) {
        case 'required':
          if (inputValue == '') {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'minlength':
          if (inputValue.length < arrayValue) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'length':
          if (inputValue.length != arrayValue) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'firstletter':
          if (validateArray['firstletter'] != null &&
              validateArray['firstletter'].indexOf(inputValue.toString()[0]) ==
                  -1) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'pattern':
          Pattern pattern = arrayValue;
          RegExp regex = RegExp(pattern.toString());
          if (!regex.hasMatch(inputValue)) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'pattern_not':
          Pattern pattern = arrayValue;
          RegExp regex = RegExp(pattern.toString());
          if (regex.hasMatch(inputValue)) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'special_char_check':
          Pattern pattern = r'^[a-zA-Z0-9]{4,10}$';
          RegExp regex = RegExp(pattern.toString());
          if (!regex.hasMatch(inputValue)) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'special_char_check_except_space':
          Pattern pattern = r'^[a-zA-Z0-9 ]{4,10}$';
          RegExp regex = RegExp(pattern.toString());
          if (!regex.hasMatch(inputValue)) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
        case 'matchwith':
          if (inputValue != arrayValue) {
            returnErrorMsg = errorArray[arrayKey];
            errorMsg = true;
          }
          break;
      }
    }
  });
  if (returnErrorMsg != '')
    return returnErrorMsg;
  else
    return null;
}
