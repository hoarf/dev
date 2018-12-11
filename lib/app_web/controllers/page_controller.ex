defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    with {:ok, marvel_data} <- Marvel.get_story() do
      render(conn, "index.html", marvel_data)
    else
      err ->
        conn
        |> put_status(:not_found)
        |> html(inspect(err))
    end
  end
end
