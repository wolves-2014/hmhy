require 'json'

json_msg = <<-STRING
{"mandrill_events":[
  {
    "event": "inbound",
    "ts": 1344498257
  }
]
}
STRING

JSON.parse(json_msg)
