defmodule SignalWire do
  @moduledoc """
  Interacts with the SignalWire API to send SMS messages.
  """
  require Logger

  @spec send_message(recipients :: String.t() | list(String.t()), message :: String.t()) ::
          {:ok, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
          | {:error, HTTPoison.Error.t()}
  def send_message(recipients, message) when is_list(recipients) do
    results = Enum.map(recipients, &send_message(&1, message))
    failures = Enum.filter(results, &parse_result/1)

    case length(failures) do
      0 -> Logger.info("Successfully sent to #{length(results)} recipients")
      count -> Logger.info("Failed to send to #{count} recipients: #{inspect(failures)}")
    end
  end

  def send_message(recipient, message) do
    recipient = "+1" <> String.replace(recipient, ~r/[^\d]/, "")
    url = "#{base_url()}/api/laml/2010-04-01/Accounts/#{account_sid()}/Messages.json"
    auth = Base.encode64("#{account_sid()}:#{account_token()}")
    headers = [{"Authorization", "Basic #{auth}"}, {"Content-Type", "application/json"}]

    body = %{
      "From" => default_phone_number(),
      "To" => recipient,
      "Body" => message
    }

    encoded_body = Jason.encode!(body)

    if enabled() |> IO.inspect() == true do
      HTTPoison.post(url, encoded_body, headers)
    else
      log_message(recipient, message)
      {:ok, message}
    end
  end

  defp log_message(recipient, message) do
    Logger.info("Sending to #{recipient}: #{message}")
  end

  defp parse_result({:ok, %HTTPoison.Response{status_code: 201}}), do: false
  defp parse_result(error), do: error

  defp account_sid, do: Application.get_env(:camp_with_dennis_2019, :signal_wire_project_key)
  defp account_token, do: Application.get_env(:camp_with_dennis_2019, :signal_wire_token)
  defp base_url, do: Application.get_env(:camp_with_dennis_2019, :signal_wire_base_url)

  defp default_phone_number,
    do: Application.get_env(:camp_with_dennis_2019, :default_phone_number)

  defp enabled, do: Application.get_env(:camp_with_dennis_2019, :sms_enabled)
end
