defmodule ShodanTest do
  use ExUnit.Case
  doctest Shodan

  test "Generate URL without API Key" do
    assert_raise(RuntimeError, "Please setup api_key on your configuration file.", fn ->
      Shodan.get_url("/shodan/host/1.2.3.4")
    end)
  end

  test "Generate URL" do
    Application.put_env(:shodan, :api_key, "1234567890abcdef")

    assert Shodan.get_url("/shodan/host/1.2.3.4") ==
             "https://api.shodan.io/shodan/host/1.2.3.4?key=1234567890abcdef"

    Application.delete_env(:shodan, :api_key)
  end

  test "Generate URL with query parameters" do
    Application.put_env(:shodan, :api_key, "1234567890abcdef")

    assert Shodan.get_url("/shodan/host/1.2.3.4", query: "xpto", page: 3, order: :desc) ==
             "https://api.shodan.io/shodan/host/1.2.3.4?key=1234567890abcdef&query=xpto&page=3&order=desc"

    Application.delete_env(:shodan, :api_key)
  end
end
