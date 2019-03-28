local MetaSchema = require "kong.db.schema.metaschema"

local s1 = {
  name = "schema",
  primary_key = {},
  fields = {
    {
      f1 = {
      type = "string",
      len_min = 1,
    }}
  },
}

local ok, err_t = MetaSchema:validate(s1)
print(require"inspect"(ok))
print(require"inspect"(err_t))

local Entity = require "kong.db.schema.entity"
local S1 = Entity.new(s1)

local ok, err = S1:validate({f1 = ""})
print(require"inspect"(ok))
print(require"inspect"(err))
