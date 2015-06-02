defmodule Repcountdown.RepCache do
  use GenServer
  
  def get_user_rep(name) when is_binary do
    GenServer.call(__MODULE__, {:get, name})
  end
  
  def put_user_rep(name, rep) do
    
    GenServer.cast(__MODULE__,{:put, name, rep})
  end
  
  def handle_call({:get, name}, _from, hd) do
    {:reply, hd.get(name), hd}
  end

  def handle_cast({:put, name, rep, repHigh, repLow}, hd) do
    {:noreply, hd.put(name,{rep,repHigh, repLow)}
  end

end