defmodule MarvelAPI do
  use Tesla

  require Logger

  plug(Tesla.Middleware.JSON)

  @public_key "8111b5d86eedc6cb9ea8db2f0396eb11"

  def fetch(url) when is_bitstring(url) do
    with ts when is_bitstring(ts) <- ts(),
         private_key when is_bitstring(private_key) <- private_key(),
         hash when is_bitstring(hash) <- hash(ts, private_key),
         {:ok, response} <- get(url, query: [apikey: @public_key, ts: ts, hash: hash]),
         {:ok, result} <- assert_result_is_valid(response) do
      {:ok, result}
    end
  end

  defp assert_result_is_valid(response) do
    with 1 <- get_in(response.body, ["data", "count"]),
         [result | []] <- get_in(response.body, ["data", "results"]) do
      {:ok, result}
    else
      err ->
        Logger.debug(err)
        {:error, :invalid_response_from_marvel}
    end
  end

  defp hash(ts, private_key),
    do: :crypto.hash(:md5, ts <> private_key <> @public_key) |> Base.encode16(case: :lower)

  defp ts() do
    DateTime.utc_now()
    |> DateTime.to_unix()
    |> to_string
  end

  defp private_key() do
    :app
    |> Application.get_env(MarvelAPI)
    |> Keyword.get(:private_key, {:error, :private_key_not_set})
  end
end
