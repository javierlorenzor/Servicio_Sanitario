# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

# Tarea p7: Ejecuta solo las pruebas especificadas
task :p7 do
    # Ejecutar RSpec solo en los archivos que deseas para p7
    sh "rspec spec/spec_fecha.rb spec/spec_horas.rb spec/spec_nivelset.rb spec/spec_helper.rb spec/ServicioSanitario_spec.rb"
end
  
  # Tarea p8: Ejecuta solo las pruebas especificadas
task :p8 do
    # Ejecutar RSpec solo en los archivos que deseas para p8
    sh "rspec spec/spec_helper.rb spec/spec_medico.rb spec/spec_paciente.rb spec/spec_persona.rb spec/spec_titular.rb"
end



task default: :spec
