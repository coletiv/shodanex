defmodule Shodan.Search.Host do
  @moduledoc """
  Host and related information
  """

  alias Shodan

  alias Shodan.Search.HostResult

  @doc """
  Host Information

  Returns all services that have been found on the given host IP.
  """
  def by_ip(ip) do
    Shodan.get_url("/shodan/host/#{ip}")
    |> HTTPoison.get!()
    |> Shodan.extract(HostResult)
  end

  @host_count_url "/shodan/host/count"
  def count(query, facets \\ nil)

  def count(query, nil) do
    @host_count_url
    |> Shodan.get_url(query: query)
    |> HTTPoison.get!()
  end

  def count(query, facets) do
    @host_count_url
    |> Shodan.get_url(query: query, facets: facets)
    |> HTTPoison.get!()
  end

  def search(query) do
    "/shodan/host/search"
    |> Shodan.get_url(query: query)
    |> HTTPoison.get!()
  end

  def search_tokens() do
    "/shodan/host/search/tokens"
    |> Shodan.get_url()
    |> HTTPoison.get!()
  end
end
