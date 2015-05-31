defmodule Repcountdown.RepRepo do

  def get_user_rep(id) when is_integer(id) do
    Task.async(fn->
      %{body: resp, status_code: 200} =
        HTTPoison.get! "http://api.stackexchange.com/2.2//2.2/users/{#id}?order=desc&sort=reputation&site=stackoverflow"
      resp
    end)  
  end

  def get_user_rep(name) when is_binary(name) do
    Task.async(fn->
      %{body: resp, status_code: 200} = 
        HTTPoison.get! "http://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname={#name}&site=stackoverflow"
      resp
    end)  
  end
  
end