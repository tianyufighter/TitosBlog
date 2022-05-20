/*
* 通过消息总线发送该消息
* */
class RefreshTodoEvent {
  int todoType;
  RefreshTodoEvent(this.todoType);
}