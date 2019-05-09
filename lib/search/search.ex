defmodule Shodan.Search do
  @moduledoc """
  Shodan Search Methods
  """

  alias Shodan

  @doc """
  List all ports that Shodan is crawling on the Internet.

  This method returns a list of port numbers that the crawlers are looking for.
  """
  def ports() do
    "shodan/ports"
    |> Shodan.get_url()
    |> HTTPoison.get!()
    |> Shodan.extract()
  end
end
