defmodule QuizSystemWeb.OptionController do
  use QuizSystemWeb, :controller

  alias QuizSystem.Quiz
  alias QuizSystem.Quiz.Option

  def index(conn, _params) do
    options = Quiz.list_options()
    render(conn, "index.html", options: options)
  end

  def new(conn, _params) do
    changeset = Quiz.change_option(%Option{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"option" => option_params}) do
    case Quiz.create_option(option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option created successfully.")
        |> redirect(to: Routes.option_path(conn, :show, option))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    option = Quiz.get_option!(id)
    render(conn, "show.html", option: option)
  end

  def edit(conn, %{"id" => id}) do
    option = Quiz.get_option!(id)
    changeset = Quiz.change_option(option)
    render(conn, "edit.html", option: option, changeset: changeset)
  end

  def update(conn, %{"id" => id, "option" => option_params}) do
    option = Quiz.get_option!(id)

    case Quiz.update_option(option, option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option updated successfully.")
        |> redirect(to: Routes.option_path(conn, :show, option))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", option: option, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option = Quiz.get_option!(id)
    {:ok, _option} = Quiz.delete_option(option)

    conn
    |> put_flash(:info, "Option deleted successfully.")
    |> redirect(to: Routes.option_path(conn, :index))
  end
end
