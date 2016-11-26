defmodule Mix.Tasks.SendMessages do
  use Mix.Task

  @shortdoc "Send messages to all users"

  def run(_args) do
    Mix.shell.info "Hello, World!"
  end
end
