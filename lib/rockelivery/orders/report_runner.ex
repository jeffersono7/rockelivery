defmodule Rockelivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Rockelivery.Orders.Report

  @time 1000 * 60

  def start_link(_initial_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # Server

  @impl true
  def init(state) do
    schedule_report_generation()

    {:ok, state}
  end

  # Recebe qualquer tipo de mensagem
  @impl true
  def handle_info(:generate, state) do
    Logger.info("Generating report...")

    Report.create()

    schedule_report_generation()

    {:noreply, state}
  end

  def schedule_report_generation do
    Process.send_after(self(), :generate, @time)
  end
end
