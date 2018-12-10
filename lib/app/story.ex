defmodule Marvel.Story do
  defstruct [:description, :characters, :id]

  def from_raw(raw_story),
    do: %__MODULE__{
      id: Map.get(raw_story, "id"),
      description: Map.get(raw_story, "description"),
      characters: Enum.map(get_in(raw_story, ["characters", "items"]), & &1["resourceURI"])
    }
end
