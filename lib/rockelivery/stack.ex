defmodule Rockelivery.Stack do
  use GenServer

  # Client

  def start_link(initial_stack) when is_list(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def push(pid, element), do: GenServer.cast(pid, {:push, element})

  def pop(pid), do: GenServer.call(pid, :pop)

  # Server (callbacks)

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  # Sync
  @impl true
  def handle_call({:push, element}, _from, stack) do
    new_stack = [element | stack]

    {:reply, new_stack, new_stack}
  end

  @impl true
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  # Async
  @impl true
  def handle_cast({:push, element}, stack) do
    new_stack = [element | stack]

    {:noreply, new_stack}
  end
end
