defmodule QuizSystem.Quiz.Option do
  use Ecto.Schema
  import Ecto.Changeset

  schema "options" do
    field :is_asnwer, :boolean, default: false
    field :option, :string
    # field :questions_id, :id
    belongs_to :question, QuizSystem.Quiz.Question

    timestamps()
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:option, :is_asnwer])
    |> validate_required([:option, :is_asnwer])
  end
end
