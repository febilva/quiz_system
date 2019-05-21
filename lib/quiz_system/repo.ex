defmodule QuizSystem.Repo do
  use Ecto.Repo,
    otp_app: :quiz_system,
    adapter: Ecto.Adapters.Postgres
end
