defmodule Marvel.Character do
  defstruct [:name, :image]

  def from_raw(raw_character) do
    with name <- Map.get(raw_character, "name"),
         thumbnail <- Map.get(raw_character, "thumbnail"),
         {path, ext} <- {thumbnail["path"], thumbnail["extension"]} do
      %__MODULE__{name: name, image: "#{path}/portrait_uncanny.#{ext}"}
    end
  end
end
