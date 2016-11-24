defmodule VkBots.PageView do
  use VkBots.Web, :view

  def added_link_style(user, gid) do
    if Enum.member?(user.active_groups, Integer.to_string(gid)) do
      "hidden"
    end
  end

  def removed_link_style(user, gid) do
    unless Enum.member?(user.active_groups, Integer.to_string(gid)) do
      "hidden"
    end
  end
end
