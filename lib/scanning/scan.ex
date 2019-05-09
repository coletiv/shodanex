defmodule Shodan.Scan do
  alias Shodan.ScanResponse

  def protocols() do
  end

  @doc """
  Request Shodan to crawl an IP/ netblock
  Use this method to request Shodan to crawl a network.

  Requirements
  This method uses API scan credits: 1 IP consumes 1 scan credit. You must have a paid API plan (either one-time payment or subscription) in order to use this method.
  """
  def scan(ips) when is_list(ips) do
    body = %{
      ips: Enum.join(ips, ",")
    }

    "/shodan/scan/"
    |> Shodan.get_url()
    |> HTTPoison.post!(body)
    |> Shodan.extract(ScanResponse)
  end

  def internet(port, protocol) when is_number(port) do
    body = %{
      port: port,
      protocol: protocol
    }

    "/shodan/scan/internet"
    |> Shodan.get_url()
    |> HTTPoison.post!(body)
    |> Shodan.extract()
  end

  def get_scan_by_id(id) do
    "/shodan/scan/#{id}"
    |> Shodan.get_url()
    |> HTTPoison.get!()
    |> Shodan.extract()
  end
end
