defmodule RocketpayWeb.ErrorView do
  use RocketpayWeb, :view

  # Imports functions of a module to another module
  import Ecto.Changeset, only: [traverse_errors: 2]

  # Shorten Ecto.Changeset to Changeset
  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("400.json", %{result: %Changeset{} = changeset}) do
    %{message: translate_changeset_errors(changeset)}
  end

  def render("400.json", %{result: message}) do
    %{message: message}
  end

  defp translate_changeset_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
