-- Rerun tests only if their modification time changed.
cache = true
codes = false

ignore = {
  '212' --- Ignore unused self
}
-- Global objects defined by the C code
read_globals = {
  'vim',
  'describe',
  'it',
  'assert',
  'before_each',
}
