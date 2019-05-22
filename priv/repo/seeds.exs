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

{:ok, question1} =
  Quiz.create_question(%{"question" => "When did Alexander the great visited India?"})

Quiz.create_option(%{"is_asnwer" => "true", "option" => "326 BC"}, question1.id)
Quiz.create_option(%{"is_asnwer" => "false", "option" => "327 BC"}, question1.id)

{:ok, question2} =
  Quiz.create_question(%{"question" => "Who designed the Indian parliament Building ?"})

Quiz.create_option(%{"is_asnwer" => "true", "option" => "Herbert Bekar"}, question2.id)

Quiz.create_option(
  %{"is_asnwer" => "false", "option" => "Rashtrakuta king Krishna"},
  question2.id
)
