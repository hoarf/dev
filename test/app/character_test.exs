defmodule Marvel.CharacterTest do
  use ExUnit.Case

  test "parses raw into character" do
    raw = %{
      "name" => "Spoder",
      "thumbnail" => %{"path" => "http://dccomics.com", "extension" => "png"}
    }

    assert Marvel.Character.from_raw(raw) == %Marvel.Character{
             name: "Spoder",
             image: "http://dccomics.com/portrait_uncanny.png"
           }
  end
end
