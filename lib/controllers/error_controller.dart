import '../helper/dialog_helper.dart';
import '../services/app_exeptions.dart';

class ErrorController {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
          description: 'Oops! It took longer to respond.');
    } else {
      DialogHelper.showErrorDialog(
          description: 'Oops! Incorrect adress.');
    }
  }
}