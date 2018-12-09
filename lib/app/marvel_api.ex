defmodule MarvelAPI do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://gateway.marvel.com/v1/public")
  plug(Tesla.Middleware.JSON)

  @public_key "8111b5d86eedc6cb9ea8db2f0396eb11"

  def get_story(id \\ "24459") do
    with ts when is_bitstring(ts) <- ts(),
         private_key when is_bitstring(private_key) <- private_key(),
         hash when is_bitstring(hash) <- hash(ts, private_key),
         story <- get("/stories/" <> id, query: [apikey: @public_key, ts: ts, hash: hash]) do
      {:ok, story}
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
