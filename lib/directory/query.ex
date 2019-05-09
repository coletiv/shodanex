defmodule Shodan.Query do
  @moduledoc """
  """

  alias Shodan

  @doc """
  List the saved search queries
  Use this method to obtain a list of search queries that users have saved in Shodan.

  # Parameters
  - page (optional): [Integer] Page number to iterate over results; each page contains 10 items
  - sort (optional): [String] Sort the list based on a property. Possible values are: votes, timestamp
  - order (optional): [String] Whether to sort the list in ascending or descending order. Possible values are: asc, desc
  """
  def list(options \\ []) do
    page = Keyword.get(options, :page, 1)
    sort = Keyword.get(options, :page, :timestamp)
    order = Keyword.get(options, :page, :desc)

    if Enum.member?([:votes, :timestamp], sort) do
      if Enum.member?([:asc, :desc], order) do
        "/shodan/query/"
        |> Shodan.get_url(page: page, sort: sort, order: order)
        |> HTTPoison.get!()
        |> Shodan.extract()
      else
        {:error, :invalid_order_value}
      end
    else
      {:error, :invalid_sort_value}
    end
  end

  @doc """
  """
  def search(query, options \\ []) do
    page = Keyword.get(options, :page, 1)

    "/shodan/query/search"
    |> Shodan.get_url(query: query, page: page)
    |> HTTPoison.get!()
    |> Shodan.extract()
  end

  @doc """
  List the most popular tags
  Use this method to obtain a list of popular tags for the saved search queries in Shodan.
  """
  def tags(size \\ 10) do
    "/shodan/query/tags"
    |> Shodan.get_url(size: size)
    |> HTTPoison.get!()
    |> Shodan.extract()
  end
end
