defmodule Tasktracker3.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> put_pass_hash()
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end


    # method to validate password from Comonin docs
  # https://hexdocs.pm/comeonin/Comeonin.Argon2.html
  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, password ->
      case valid_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  # Code for password validation from Professor Nat's Notes
  # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/17-passwords/notes.html
  def valid_password?(password) when byte_size(password) > 7 do
    {:ok, password}
  end
  def valid_password?(_), do: {:error, "The password is too short"}

  # Code to add password hash to the changeset referred from Professor Nat's Notes
  # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/17-passwords/notes.html
  def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
  def put_pass_hash(changeset), do: changeset

end

