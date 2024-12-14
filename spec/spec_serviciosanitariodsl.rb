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

      usuario :medico, 
        numero_identificacion: 2005001, 
        nombre: 'Dr.', 
        apellido: 'Poo', 
        sexo: 'mujer', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 1990), 
        especialidad: 'geriatría'

      usuario :paciente, 
        numero_identificacion: 2024001, 
        nombre: 'Paciente', 
        apellido: 'Tos', 
        sexo: 'hombre', 
        fecha_nacimiento: ServicioSanitario::Fecha.new(dia: 2, mes: 12, anio: 1935), 
        prioridad: ServicioSanitario::ROJO
    end
  end

  it "Se espera que se inicialice correctamente el sistema" do
    expect(@sistema.instance_variable_get(:@servicios)).not_to be_empty
    expect(@sistema.instance_variable_get(:@usuarios)).not_to be_empty
  end

  it "Se espera que se registren los servicios correctamente" do
    servicios = @sistema.instance_variable_get(:@servicios)

    expect(servicios.size).to eq(2)
    expect(servicios[0].codigo).to eq('CIF012345678')
    expect(servicios[0].descripcion).to eq('Hospital LPP')
    expect(servicios[1].codigo).to eq('CIF876543210')
    expect(servicios[1].descripcion).to eq('Urgencias LPP')
  end

  it "Se espera que se pueda registrar usuarios correctamente" do
    usuarios = @sistema.instance_variable_get(:@usuarios)
    expect(usuarios.size).to eq(2)
    expect(usuarios[0].nombre_completo).to eq('Dr. Poo')
    expect(usuarios[1].nombre_completo).to eq('Paciente Tos')
  end

  it 'Se espera poder formatear correctamente el estado del sistema' do
    estado = @sistema.to_s
    expect(estado).to include('Servicios:')
    expect(estado).to include('Usuarios:')
    expect(estado).to include('Hospital LPP')
    expect(estado).to include('Dr. Poo')
    expect(estado).to include('Paciente Tos')
  end


end