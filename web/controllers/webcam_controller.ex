defmodule Whitebox.WebcamController do
  use Whitebox.Web, :controller

  alias Whitebox.Webcam

  def index(conn, _params) do
    webcams = Repo.all(Webcam)
    render(conn, "index.html", webcams: webcams)
  end

  def new(conn, _params) do
    changeset = Webcam.changeset(%Webcam{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"webcam" => webcam_params}) do
    changeset = Webcam.changeset(%Webcam{}, webcam_params)

    case Repo.insert(changeset) do
      {:ok, _webcam} ->
        conn
        |> put_flash(:info, "Webcam created successfully.")
        |> redirect(to: webcam_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    webcam = Repo.get!(Webcam, id)
    render(conn, "show.html", webcam: webcam)
  end

  def edit(conn, %{"id" => id}) do
    webcam = Repo.get!(Webcam, id)
    changeset = Webcam.changeset(webcam)
    render(conn, "edit.html", webcam: webcam, changeset: changeset)
  end

  def update(conn, %{"id" => id, "webcam" => webcam_params}) do
    webcam = Repo.get!(Webcam, id)
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

  def delete(conn, %{"id" => id}) do
    webcam = Repo.get!(Webcam, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(webcam)

    conn
    |> put_flash(:info, "Webcam deleted successfully.")
    |> redirect(to: webcam_path(conn, :index))
  end
end
