defmodule QuizSystem.Quiz.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    has_many :options, QuizSystem.Quiz.Option

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question])
    |> validate_required([:question])
  end
end
