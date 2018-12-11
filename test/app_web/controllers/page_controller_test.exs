defmodule AppWeb.PageControllerTest do
  use AppWeb.ConnCase

  import Tesla.Mock

  describe "when marvel api is up" do
    setup do
      mock(fn
        %{method: :get, url: "https://gateway.marvel.com/v1/public/stories/24459"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "data" => %{
                "count" => 1,
                "results" => [
                  %{
                    "id" => 24559,
                    "description" => "dummy",
                    "characters" => %{"items" => [%{"resourceURI" => "dummy_char_uri"}]}
                  }
                ]
              }
            }
          }

        %{method: :get, url: "dummy_char_uri"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "data" => %{
                "count" => 1,
                "results" => [%{"name" => "Spoder-Man"}]
              }
            }
          }
      end)

      :ok
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Peter Parker"
    end
  end

  describe "when marvel api is down" do
    setup do
      mock(fn
        _ ->
          %Tesla.Env{
            status: 404,
            body: %{
              "data" => nil
            }
          }
      end)

      :ok
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 404) =~ "{:error, :invalid_response_from_marvel}"
    end
  end

  describe "when character fetching fails " do
    setup do
      mock(fn
        %{method: :get, url: "https://gateway.marvel.com/v1/public/stories/24459"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "data" => %{
                "count" => 1,
                "results" => [
                  %{
                    "id" => 24559,
                    "description" => "dummy",
                    "characters" => %{"items" => [%{"resourceURI" => "dummy_char_uri"}]}
                  }
                ]
              }
            }
          }

        %{method: :get, url: "dummy_char_uri"} ->
          %Tesla.Env{
            status: 404,
            body: %{
              "data" => nil
            }
          }
      end)

      :ok
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 404) =~ "{:error, :character_fetching_error}"
    end
  end
end
