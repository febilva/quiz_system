defmodule QuizSystemWeb.Router do
  use QuizSystemWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuizSystemWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/quiz/:id", QuestionController, :quiz
    post "/verify_option", QuestionController, :verify_option_from_genserver_state
    # post "/verify_option", QuestionController, :verify_option_from_database

    resources "/questions", QuestionController do
      resources "/options", OptionController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuizSystemWeb do
  #   pipe_through :api
  # end
end
