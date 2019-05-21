defmodule QuizSystemWeb.OptionController do
  use QuizSystemWeb, :controller

  alias QuizSystem.Quiz
  alias QuizSystem.Quiz.Option

  def index(conn, %{"question_id" => question_id}) do
    options = Quiz.list_options(question_id)
    render(conn, "index.html", options: options, question_id: question_id)
  end

  require IEx

  def new(conn, %{"question_id" => id}) do
    changeset = Quiz.change_option(%Option{})
    render(conn, "new.html", changeset: changeset, question_id: id)
  end

  def create(conn, %{"option" => option_params, "question_id" => question_id}) do
    #
    # question_id = conn.params[:question_id]

    case Quiz.create_option(option_params, question_id) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option created successfully.")
        |> redirect(to: Routes.question_option_path(conn, :show, question_id, option))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "question_id" => question_id}) do
    option = Quiz.get_option!(id)
    render(conn, "show.html", option: option, question_id: question_id)
  end

  def edit(conn, %{"id" => id, "question_id" => question_id}) do
    option = Quiz.get_option!(id)
    changeset = Quiz.change_option(option)
    render(conn, "edit.html", option: option, changeset: changeset, question_id: question_id)
  end

  def update(conn, %{"id" => id, "question_id" => question_id, "option" => option_params}) do
    option = Quiz.get_option!(id)

    case Quiz.update_option(option, option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option updated successfully.")
        |> redirect(to: Routes.question_option_path(conn, :show, question_id, option))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", option: option, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "question_id" => question_id}) do
    option = Quiz.get_option!(id)
    {:ok, _option} = Quiz.delete_option(option)

    conn
    |> put_flash(:info, "Option deleted successfully.")
    |> redirect(to: Routes.question_option_path(conn, :index, question_id))
  end
end
