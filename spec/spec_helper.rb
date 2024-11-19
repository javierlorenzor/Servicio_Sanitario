# frozen_string_literal: true

require "ServicioSanitario"
require_relative 'spec_nivelset'
require_relative 'spec_fecha'
require_relative 'spec_horas'
require_relative 'spec_medico'
require_relative 'spec_persona'
#require_relative 'spec_paciente'
#require_relative 'spec_titular'


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
