defmodule CampWithDennis2019.SmsVerification do
  @moduledoc """
  Handles the backend logic for SMS verification of phone numbers.
  """

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

  @spec verify(phone_number :: String.t(), code :: String.t()) :: :ok | :error
  def verify(phone_number, code) do
    case get_code(phone_number) do
      ^code ->
        delete_code(phone_number)
        :ok

      _ ->
        :error
    end
  end

  # private
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
