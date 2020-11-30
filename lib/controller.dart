import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class FormController = _FormControllerBase with _$FormController;

abstract class _FormControllerBase with Store {
  @observable
  String mensagem = '';

  @observable
  String telefone = '';
}
