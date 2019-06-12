local inspect = require "inspect"

require("kong.globalpatches")({
  cli = true,
})

local conf_loader = require "kong.conf_loader"
local DB = require "kong.db"

local conf = assert(conf_loader(TEST_CONF_PATH))
conf.database = "postgres"

local db = assert(DB.new(conf))
assert(db:init_connector())

local ok, err

consumer, err = db.consumers:insert({
  username = "c1",
})

print("res = ", inspect(consumer))
print("err = ", inspect(err))

ok, err = db.consumers:select({
  id = consumer.id,
})

print("res = ", inspect(ok))
print("err = ", inspect(err))

ok, err = db.consumers:delete({
  id = consumer.id,
})

print("res = ", inspect(ok))
print("err = ", inspect(err))


