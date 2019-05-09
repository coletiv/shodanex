defmodule Shodan do
  @doc """
  Extract information from HTTPoison

  Note: All API methods are rate-limited to 1 request/ second.
  """
  def extract(response, struct \\ nil)

  def extract(%HTTPoison.Response{body: body, status_code: status_code}, struct) do
    case status_code do
      200 ->
        case Jason.decode(body) do
          {:ok, response} ->
            if is_nil(struct) do
              {:ok, Shodan.Util.convert_map_to_key_atom(response)}
            else
              {:ok, struct(struct, Shodan.Util.convert_map_to_key_atom(response))}
            end

          _ ->
            {:error, :unexpected}
        end

      400 ->
        case Jason.decode(body) do
          {:ok, response} ->
            {:error, response}

          _ ->
            {:error, :unexpected}
        end

      401 ->
        {:error, :unauthorized}

      _ ->
        {:error, :unexpected}
    end
  end

  def extract(_, _) do
    {:error, :unexpected}
  end

  @doc """
  Create the final URL path, with the API key
  """
  def get_url(path, query_params \\ []) when is_list(query_params) do
    api_key = Application.get_env(:shodan, :api_key)
    api_url = Application.get_env(:shodan, :url, "https://api.shodan.io")

    if is_nil(api_key) do
      raise "Please setup api_key on your configuration file."
    end

    query_params_string =
      Enum.reduce(query_params, "", fn {key, value}, acc ->
        "#{acc}&#{key}=#{value}"
      end)

    "#{api_url}/#{path}?key=#{api_key}#{query_params_string}"
  end
end
