defmodule Marvel do
  def get_story(id \\ 24459) do
    with {:ok, raw_story} <-
           MarvelAPI.fetch("https://gateway.marvel.com/v1/public/stories/#{id}"),
         story <- Marvel.Story.from_raw(raw_story),
         {:ok, characters} <- fetch_characters(story.characters) do
      {:ok, %{story: story, characters: characters}}
    end
  end

  defp fetch_characters(story_characters) do
    with raw_characters_results <- Enum.map(story_characters, &MarvelAPI.fetch/1),
         {:ok, characters} <- all_fecthed?(raw_characters_results) do
      {:ok, characters}
    end
  end

  defp all_fecthed?(raw_characters_results) do
    with true <- Enum.all?(raw_characters_results, &(elem(&1, 0) == :ok)),
         raw_characters <- Enum.map(raw_characters_results, &elem(&1, 1)),
         characters <- Enum.map(raw_characters, &Marvel.Character.from_raw/1) do
      {:ok, characters}
    else
      _ ->
        {:error, :character_fetching_error}
    end
  end
end
