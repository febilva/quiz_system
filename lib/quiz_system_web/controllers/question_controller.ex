defmodule QuizSystemWeb.QuestionController do
  use QuizSystemWeb, :controller

  alias QuizSystem.Quiz
  alias QuizSystem.Quiz.Question
  alias QuizSystem.Quiz.Option

  def index(conn, _params) do
    questions = Quiz.list_questions()
    render(conn, "index.html", questions: questions)
  end

  def new(conn, _params) do
    changeset = Quiz.change_question(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"question" => question_params}) do
    case Quiz.create_question(question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def quiz()
  def quiz(conn, %{"id" => id}) do
    question = Quiz.get_question!(id)
    select_options = Quiz.select_options(id)
    changeset = Quiz.change_question(%Question{})

    render(conn, "quiz.html",
      question: question,
      changeset: changeset,
      select_options: select_options
    )
  end

  def check_answer(conn, %{
        "question" => %{"question_id" => question_id, "option_id" => option_id}
      }) do
    opt_id = option_id |> String.to_integer()

    case Quiz.get_currect_answer(question_id) do
      %QuizSystem.Quiz.Option{id: ^opt_id} ->
        conn
        |> put_flash(:info, "your answer is correct")
        |> redirect(to: Routes.question_path(conn, :quiz, question_id))

      _ ->
        conn
        |> put_flash(:info, "answer is incorrect")
        |> redirect(to: Routes.question_path(conn, :quiz, question_id))
    end
  end

  def show(conn, %{"id" => id}) do
    question = Quiz.get_question!(id)
    render(conn, "show.html", question: question)
  end

  def edit(conn, %{"id" => id}) do
    question = Quiz.get_question!(id)
    changeset = Quiz.change_question(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Quiz.get_question!(id)

    case Quiz.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Quiz.get_question!(id)
    {:ok, _question} = Quiz.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: Routes.question_path(conn, :index))
  end
end
