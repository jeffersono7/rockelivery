defmodule Rockelivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias Rockelivery.ViaCep.Client

  describe "get_cep_info/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid cep, returns the cep info", %{bypass: bypass} do
      cep = "01001000"

      body = ~s|{
          "bairro": "Sé",
          "cep": "01001-000",
          "complemento": "lado ímpar",
          "ddd": "11",
          "gia": "1004",
          "ibge": "3550308",
          "localidade": "São Paulo",
          "logradouro": "Praça da Sé",
          "siafi": "7107",
          "uf": "SP"
      }|

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{cep}/json", fn conn ->
        conn
        |> Plug.Conn.resp(200, body)
        |> Plug.Conn.put_resp_header("content-type", "application/json")
      end)

      response = Client.get_cep_info(url, cep)

      expected_response =
        {:ok,
         %{
           "bairro" => "Sé",
           "cep" => "01001-000",
           "complemento" => "lado ímpar",
           "ddd" => "11",
           "gia" => "1004",
           "ibge" => "3550308",
           "localidade" => "São Paulo",
           "logradouro" => "Praça da Sé",
           "siafi" => "7107",
           "uf" => "SP"
         }}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
