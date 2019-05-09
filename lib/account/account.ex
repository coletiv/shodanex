defmodule Shodan.Account do
  alias Shodan
  @doc """
  Account Profile

  Returns information about the Shodan account linked to this API key.
  """
  def profile() do
    "/account/profile"
    |> Shodan.get_url()
    |> HTTPoison.get!()
  end
end
