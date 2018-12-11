defmodule Marvel.StoryTest do
  use ExUnit.Case

  test "parses raw into story" do
    raw = %{
      "id" => 1,
      "description" => "dummy",
      "characters" => %{"items" => [%{"resourceURI" => "dummyURI"}]}
    }

    assert Marvel.Story.from_raw(raw) == %Marvel.Story{
             id: 1,
             description: "dummy",
             characters: ["dummyURI"]
           }
  end
end
