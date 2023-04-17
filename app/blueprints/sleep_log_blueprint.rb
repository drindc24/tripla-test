class SleepLogBlueprint < Blueprinter::Base
  identifier :id

  fields :clock_in

  association :user, blueprint: UserBlueprint
end