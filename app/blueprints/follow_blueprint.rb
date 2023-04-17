class FollowBlueprint < Blueprinter::Base
  identifier :id

  association :follower, blueprint: UserBlueprint
  association :followed, blueprint: UserBlueprint
end