defmodule Urlshorter do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  def url(pid, url_shorted) do
    GenServer.call(pid, {:url, url_shorted})
  end

  def shortem(pid, url) do
    GenServer.call(pid, {:shortem, url})
  end

  @impl true
  def handle_call({:shortem, url}, _from, state) do
    # id_entre_aspas = :os.system_time(:millisecond)
    url_shorted = :erlang.phash2(url)
    state = Map.put_new(state, url_shorted, url)
    {:reply, {:ok, url_shorted}, state}
  end

  @impl true
  def handle_call({:url, url_shorted}, _from, state) do
    url = Map.fetch!(state, url_shorted)

    {:reply, {:ok, url}, state}
  end

  def handle_info() do
  end
end
