class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  view :with_newsfeed do
    field :newsfeed do |record, _|
      JSON.parse(
        self.render(record.following, view: :with_sleep_logs),
        symbolize_names: true
      )
    end
  end

  view :with_sleep_logs do
    association :sleep_logs, blueprint: SleepLogBlueprint
  end
end