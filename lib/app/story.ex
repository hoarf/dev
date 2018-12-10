defmodule Marvel.Story do
  defstruct [:description, :characters]

  def from_raw(raw_story),
    do: %__MODULE__{
      description: Map.get(raw_story, "description"),
      characters: Enum.map(get_in(raw_story, ["characters", "items"]), & &1["resourceURI"])
    }
end
