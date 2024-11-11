require 'spec_helper'
require 'ServicioSanitario/Titular'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario/Persona'
require 'ServicioSanitario/Paciente'
require 'ServicioSanitario/Titular'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::titular
RSpec.describe ServicioSanitario::Titular do
  before(:each) do
    # Creación de fechas
    @fecha1 = ServicioSanitario::Fecha.new(dia: 10, mes: 5, anio: 1980)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 20, mes: 6, anio: 1990)
  
    # Creación de médicos y pacientes
    @titular1 = ServicioSanitario::Titular.new("12345", "Alba", "Perez", "F", @fecha1, "Pediatría", 5)
    @titular2 = ServicioSanitario::Titular.new("56789", "Miguel", "Tadeo", "M", @fecha2, "Geriatría", 3)
  
    @paciente1 = ServicioSanitario::Paciente.new("54321", "Maria", "Gomez", "F", @fecha1, "Rojo")
    @paciente2 = ServicioSanitario::Paciente.new("67890", "Carlos", "Ruiz", "M", @fecha2, "Azul")
  end

  it "Se espera que se pueda inicializar persona correctamente con valores válidos" do
    expect(@titular1).not_to be_nil
    expect(@titular2).not_to be_nil
  end

  it "Se espera que la instancia pertenezca a la clase determinada" do
    expect(@titular1).to be_a(ServicioSanitario::Titular)
    expect(@titular2).to be_a(ServicioSanitario::Titular)
    expect(@titular1.instance_of?(ServicioSanitario::Titular)).to be true
    expect(ServicioSanitario::Titular.superclass).to eq(ServicioSanitario::Medico)
    expect(ServicioSanitario::Medico.superclass).to eq(ServicioSanitario::Persona)
    expect(ServicioSanitario::Persona.superclass).to eq(Object)
    expect(Object.superclass).to eq(BasicObject)
  end

  it "Se espera que devuelva el valor esperado" do
    expect(@titular1.numero_identificacion).to eq("12345")
    expect(@titular1.nombre).to eq("Alba")
    expect(@titular1.apellido).to eq("Perez")
    expect(@titular1.sexo).to eq("F")
    expect(@titular1.fecha_nacimiento).to eq(@fecha1)
    expect(@titular1.especialidad).to eq("Pediatría")
    expect(@titular1.maximo_pacientes).to eq(5)
  end

  it 'Se espera retornar false cuando el número de pacientes es menor que el máximo' do
    @titular1.pacientes << @paciente1
    @titular1.pacientes << @paciente2
    expect(@titular1.carga_maxima_alcanzada?).to be false 
  end

  it 'Se espera retornar true cuando el número de pacientes es igual o mayor que el máximo' do
    @titular2.pacientes << @paciente1
    @titular2.pacientes << @paciente2
    expect(@titular2.carga_maxima_alcanzada?).to be true 
  end




end 
