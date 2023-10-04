import 'package:zapp_task/module/todo/model/add_todo_model.dart';

final fetchTodoQuery = {
  'query': '''
      query {
  todos(options: { paginate: { page: 1, limit: 10 } }) {
    data {
      id
      title
      completed
    }
  }
}
      '''
};

Map<String, dynamic> createTodoQuery(AddTodoModel addTodoModel) {
  final query = {
    'query': '''
     mutation {
  createTodo(input :{
    title: "${addTodoModel.title}",
    completed : ${addTodoModel.completed},
  }){
    id
    title
    completed
  }
}
      '''
  };
  return query;
}

Map<String, dynamic> deleteQuery(String id){
  final query = {
    'query': '''
     mutation {
  deleteTodo(id: "$id")
}
      '''
  };
  return query;
}

Map<String, dynamic> completeQuery(String id, bool complete){
  final query = {
    'query': '''
     mutation {
  updateTodo(id: "$id",input : {
    completed : $complete
  }){
    id
    title
    completed
  }
}
      '''
  };
  return query;
}