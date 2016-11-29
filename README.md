# VK Broadcaster

Information about ruby and rails versions.

- PostgreSQL 9.5.4
`brew install postgres`
- Elixir 1.3.4
`kiex install elixir-1.3.4`
- Phoenix 1.2.1

Quick start:
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `npm install`
* Start Phoenix endpoint with `mix phoenix.server`

ENV variables:
  ```bash
  VK_CLIENT_ID=vkontakte_client_id
  VK_CLIENT_SECRET=vkontakte_client_secret
  TELEGRAM_KEY=telegram_key
  TELEGRAM_BOT=telegram_bot_name
  ```
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
