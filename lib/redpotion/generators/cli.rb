require "thor"
require "active_support/core_ext/string/inflections"
require_relative "cdq_model"
require_relative "cdq_table_screen"
require_relative "scaffold"

module RedPotion
  module Generators
    class CLI < Thor
      register CDQModel, "cdq_model", "cdq_model", "Generate a CDQ Model and migration"
      register CDQTableScreen, "cdq_table_screen", "cdq_table_screen", "Generate a CDQ Table Screen"
      register Scaffold, "scaffold", "scaffold", "Generate scaffolding"
    end
  end
end
