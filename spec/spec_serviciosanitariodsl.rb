require 'rspec'
require 'spec_helper'
require 'ServicioSanitario/ServicioSalud'
require 'ServicioSanitario/Hospital'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario/Medico'
require 'ServicioSanitario/ServicioSanitarioDSL'
require 'ServicioSanitario'

describe ServicioSanitario::ServicioSanitarioDSL do
  before(:each) do
    @sistema = ServicioSanitario::ServicioSanitarioDSL.new do

      servicio :hospital, 
        codigo: 'CIF012345678', 
        descripcion: 'Hospital LPP', 
        horario_apertura: ServicioSanitario::Hora.new(hora: 5, minuto: 0, segundo: 0), 
        horario_cierre: ServicioSanitario::Hora.new(hora: 22, minuto: 0, segundo: 0), 
        dias_festivos: [ServicioSanitario::Fecha.new(dia: 1, mes: 12, anio: 2024)], 
        medicos: ['Dr.Poo', 'Dr.Fup'], 
        camas: {1 => 'ocupado', 2 => nil}, 
        numero_plantas: 5

      servicio :servicio, 
        codigo: 'CIF876543210', 
        descripcion: 'Urgencias LPP', 
        horario_apertura: ServicioSanitario::Hora.new(hora: 0, minuto: 0, segundo: 0), 
        horario_cierre: ServicioSanitario::Hora.new(hora: 24, minuto: 0, segundo: 0), 
        dias_festivos: [], 
        medicos: ['Dr.Struct', 'Dr.Single'], 
        camas: {1 => 'ocupado'}
    end
  end

  it 'debería inicializar correctamente el sistema' do
    expect(@sistema.instance_variable_get(:@servicios)).not_to be_empty
    expect(@sistema.instance_variable_get(:@usuarios)).to be_empty
  end

end