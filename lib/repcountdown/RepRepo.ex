defmodule Repcountdown.RepRepo do

  def get_user_rep(id) when is_integer(id) do
    Task.async(fn->
      resp = HTTPoison.get! "http://api.stackexchange.com/2.2/users/#{id}?order=desc&sort=reputation&site=stackoverflow"
      case(resp) do
        %{body: content, status_code: 200, headers: %{ "Content-Encoding" => "gzip" }} -> 
          :zlib.gunzip(content)
        %{body: content, status_code: 200, headers: %{ "Content-Encoding" => _ }} -> 
          content
      end
    end)  
  end

  def get_user_rep(name) when is_binary(name) do
    Task.async(fn->
      resp = HTTPoison.get! "http://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname=#{name}&site=stackoverflow" 
      case(resp) do
        %{body: content, status_code: 200, headers: %{ "Content-Encoding" => "gzip" }} -> 
          :zlib.gunzip(content)
        %{body: content, status_code: 200, headers: %{ "Content-Encoding" => _ }} -> 
          content
      end
    end)  
  end
  
end