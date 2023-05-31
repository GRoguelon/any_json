import Config

config :any_json, :jason_opts, encode_opts: [pretty: true], decode_opts: [keys: :atoms]
config :any_json, :poison_opts, encode_opts: [pretty: true], decode_opts: [keys: :atoms]
