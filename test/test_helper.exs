# Mox configuration
Application.ensure_all_started(:mox)
Mox.defmock(AnyJsonMock, for: AnyJson.Codec)
Application.put_env(:any_json, :json_adapter, AnyJsonMock)

ExUnit.start()
