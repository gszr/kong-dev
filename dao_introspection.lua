require"luarocks.loader"

require("kong.core.globalpatches")({
  cli = true,
})

local conf_loader = require "kong.conf_loader"
local DAOFactory = require "kong.dao.factory"
local DB = require "kong.db"

local conf = assert(conf_loader(TEST_CONF_PATH))
conf.database = "cassandra"

local db = assert(DB.new(conf))
local dao = assert(DAOFactory.new(conf, db))

print("Coordinator set? " .. tostring(dao.db:first_coordinator()))
local coordinator, err = dao.db:get_coordinator()

local ok, err = coordinator:change_keyspace("kong")
if not ok then
  return nil, err
end

local q_routes    = "SELECT * FROM routes"

for rows, err in coordinator:iterate(q_routes) do
  if err then
    print (err)
  end
  print("First " .. #rows .. " rows")
end

