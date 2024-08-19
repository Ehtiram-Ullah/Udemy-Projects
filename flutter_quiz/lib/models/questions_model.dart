class QuizQuestion {
  //Storing the question
  final String question;
  //Storing the List of answers
  final List<String> answers;

  //This two will be required while created 'QuizQuestion' object
  const QuizQuestion(this.question, this.answers);

  //Shuffling the answer
  List<String> getShuffledAnswers() {
    //'List.of' will make a copy of the list and returns it
    final shuffeledList = List.of(answers);

    //It gonna suffle the values in place, that means it will return nothing
    shuffeledList.shuffle();

    //Returning the suffled list
    return shuffeledList;
  }
}
