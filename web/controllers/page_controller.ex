defmodule Whitebox.PageController do
  use Whitebox.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
