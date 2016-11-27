defmodule VkBots.PageView do
  use VkBots.Web, :view

  def checked?(user, group) do
    if Enum.member?(user.active_groups, Integer.to_string(group["gid"])) do
      "checked"
    end
  end
end
