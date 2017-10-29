defmodule Whitebox.WebcamControllerTest do
  use Whitebox.ConnCase

  alias Whitebox.Webcam
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, webcam_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing webcams"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, webcam_path(conn, :new)
    assert html_response(conn, 200) =~ "New webcam"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, webcam_path(conn, :create), webcam: @valid_attrs
    assert redirected_to(conn) == webcam_path(conn, :index)
    assert Repo.get_by(Webcam, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, webcam_path(conn, :create), webcam: @invalid_attrs
    assert html_response(conn, 200) =~ "New webcam"
  end

  test "shows chosen resource", %{conn: conn} do
    webcam = Repo.insert! %Webcam{}
    conn = get conn, webcam_path(conn, :show, webcam)
    assert html_response(conn, 200) =~ "Show webcam"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, webcam_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    webcam = Repo.insert! %Webcam{}
    conn = get conn, webcam_path(conn, :edit, webcam)
    assert html_response(conn, 200) =~ "Edit webcam"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    webcam = Repo.insert! %Webcam{}
    conn = put conn, webcam_path(conn, :update, webcam), webcam: @valid_attrs
    assert redirected_to(conn) == webcam_path(conn, :show, webcam)
    assert Repo.get_by(Webcam, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    webcam = Repo.insert! %Webcam{}
    conn = put conn, webcam_path(conn, :update, webcam), webcam: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit webcam"
  end

  test "deletes chosen resource", %{conn: conn} do
    webcam = Repo.insert! %Webcam{}
    conn = delete conn, webcam_path(conn, :delete, webcam)
    assert redirected_to(conn) == webcam_path(conn, :index)
    refute Repo.get(Webcam, webcam.id)
  end
end
