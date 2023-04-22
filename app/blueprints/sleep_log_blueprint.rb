class SleepLogBlueprint < Blueprinter::Base
  identifier :id

  fields :clock_in, :clock_out, :duration, :user_id
end