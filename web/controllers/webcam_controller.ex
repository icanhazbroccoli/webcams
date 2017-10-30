defmodule Whitebox.WebcamController do
  use Whitebox.Web, :controller

  alias Whitebox.Webcam

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, user) do
    webcams = Repo.all(user_webcams(user))
    render(conn, "index.html", webcams: webcams)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:webcams)
      |> Webcam.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"webcam" => webcam_params}, user) do
    changeset =
      user
      |> build_assoc(:webcams)
      |> Webcam.changeset(webcam_params)

    case Repo.insert(changeset) do
      {:ok, _webcam} ->
        conn
        |> put_flash(:info, "Webcam created successfully.")
        |> redirect(to: webcam_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    webcam = Repo.get!(user_webcams(user), id)
    render(conn, "show.html", webcam: webcam)
  end

  def edit(conn, %{"id" => id}, user) do
    webcam = Repo.get!(user_webcams(user), id)
    changeset = Webcam.changeset(webcam)
    render(conn, "edit.html", webcam: webcam, changeset: changeset)
  end

  def update(conn, %{"id" => id, "webcam" => webcam_params}, user) do
    webcam = Repo.get!(user_webcams(user), id)
    changeset = Webcam.changeset(webcam, webcam_params)

    case Repo.update(changeset) do
      {:ok, webcam} ->
        conn
        |> put_flash(:info, "Webcam updated successfully.")
        |> redirect(to: webcam_path(conn, :show, webcam))
      {:error, changeset} ->
        render(conn, "edit.html", webcam: webcam, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    webcam = Repo.get!(user_webcams(user), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(webcam)

    conn
    |> put_flash(:info, "Webcam deleted successfully.")
    |> redirect(to: webcam_path(conn, :index))
  end

  defp user_webcams(user) do
    assoc(user, :webcams)
  end
end
