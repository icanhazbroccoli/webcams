defmodule Whitebox.WebcamTest do
  use Whitebox.ModelCase

  alias Whitebox.Webcam

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Webcam.changeset(%Webcam{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Webcam.changeset(%Webcam{}, @invalid_attrs)
    refute changeset.valid?
  end
end
