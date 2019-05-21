defmodule QuizSystemWeb.PageController do
  use QuizSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
