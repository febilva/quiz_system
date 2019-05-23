defmodule QuizSystem.QuizServer do
  use GenServer
  alias QuizSystem.Quiz

  # Client

  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, get_all_questions(), name: __MODULE__)
  end

  def get_all_questions() do
    Quiz.question_and_answer_ids() |> Enum.into(%{})
  end

  def check_answer(key) do
    GenServer.call(__MODULE__, {:key, key})
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
  def handle_call({:key, key}, _from, state) do
    answer = Map.get(state, key)
    {:reply, answer, state}
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
