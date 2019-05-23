defmodule QuizSystem.QuizServer do
  use GenServer
  alias QuizSystem.Quiz

  # Client
  # initilizing all questions with right option id from the database to genserver state
  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, get_questions_with_right_option(), name: __MODULE__)
  end

  def get_questions_with_right_option() do
    Quiz.question_and_answer_ids() |> Enum.into(%{})
  end

  def get_right_option(question_id) do
    GenServer.call(__MODULE__, {:question, question_id})
  end

  # def push(item) do
  #   GenServer.cast(__MODULE__, {:push, item})
  # end

  # def pop(pid) do
  #   GenServer.call(pid, :pop)
  # end

  # Server (callbacks)

  @impl true
  def init(answers) do
    {:ok, answers}
  end

  @impl true
  def handle_call({:question, id}, _from, state) do
    right_option = Map.get(state, id)
    {:reply, right_option, state}
  end

  # @impl true
  # def handle_call(:pop, _from, [head | tail]) do
  #   {:reply, head, tail}
  # end

  # @impl true
  # def handle_cast({:push, item}, state) do
  #   {:noreply, [item | state]}
  # end
end
