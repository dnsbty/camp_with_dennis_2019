defmodule CampWithDennis2019.SmsVerification do
  @moduledoc """
  Handles the backend logic for SMS verification of phone numbers.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @table_name :sms_verification
  @code_length 6
  @message_base "Thanks for signing up for Americamping! Your verification code is "

  @spec start :: atom()
  def start do
    <<i1::unsigned-integer-32, i2::unsigned-integer-32, i3::unsigned-integer-32>> =
      :crypto.strong_rand_bytes(12)

    :rand.seed(:exsplus, {i1, i2, i3})
    :ets.new(@table_name, [:named_table, :set, :public, read_concurrency: true])
  end

  @spec send(phone_number :: String.t()) ::
          {:ok, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
          | {:error, HTTPoison.Error.t()}
  def send(phone_number) do
    code = generate_code()
    store_code(phone_number, code)
    message = @message_base <> code
    SignalWire.send_message(phone_number, message)
  end

  @spec verify(map()) :: :ok | :error
  def verify(params) do
    params
    |> verification_changeset()
    |> apply_action(:update)
  end

  def verification_changeset(attrs \\ %{}) do
    types = %{phone_number: :string, verification_code: :string}

    {%{}, types}
    |> cast(attrs, [:phone_number, :verification_code])
    |> validate_required([:phone_number, :verification_code])
    |> validate_verification()
  end

  # private
  @spec validate_verification(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_verification(changeset) do
    phone_number = get_field(changeset, :phone_number)

    validate_change(changeset, :verification_code, fn _, code ->
      if code == get_code(phone_number) do
        delete_code(phone_number)
        []
      else
        [verification_code: "doesn't match the one sent"]
      end
    end)
  end

  @spec delete_code(phone_number :: String.t()) :: String.t()
  defp delete_code(phone_number) do
    :ets.delete(@table_name, phone_number)
  end

  @spec get_code(phone_number :: String.t()) :: String.t()
  defp get_code(phone_number) do
    case :ets.lookup(@table_name, phone_number) do
      [{_, code} | _] -> code
      _ -> nil
    end
  end

  @spec store_code(phone_number :: String.t(), code :: String.t()) :: :ok
  defp store_code(phone_number, code) do
    :ets.insert(@table_name, {phone_number, code})
  end

  @spec generate_code :: String.t()
  defp generate_code do
    max_code()
    |> :rand.uniform()
    |> Integer.to_string()
    |> pad_string()
  end

  @spec pad_string(String.t()) :: String.t()
  defp pad_string(str) when byte_size(str) >= @code_length, do: str
  defp pad_string(str), do: pad_string("0" <> str)

  @spec max_code :: integer()
  defp max_code, do: round(:math.pow(10, @code_length) - 1)
end
