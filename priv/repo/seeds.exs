# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     QuizSystem.Repo.insert!(%QuizSystem.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias QuizSystem.Quiz

{:ok, question} =
  Quiz.create_question(%{"question" => "When did Alexander the great visited India?"})

Quiz.create_option(%{"is_asnwer" => "true", "option" => "326 BC"}, question.id)
Quiz.create_option(%{"is_asnwer" => "false", "option" => "327 BC"}, question.id)
