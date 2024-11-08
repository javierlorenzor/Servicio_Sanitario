require 'spec_helper'
require 'ServicioSanitario/NivelSet'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::NivelSet
RSpec.describe ServicioSanitario::NivelSet do
  # Se ejecuta antes de cada prueba para crear una instancia de NivelSet
  before(:each) do
    # Crear la instancia de NivelSet con nivel, categoría y tiempo de atención
    @nivel1 = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
    @nivel2 = ServicioSanitario::NivelSet.new(:II, 'Emergencia', '7 min')
    @nivel3 = ServicioSanitario::NivelSet.new(:III, 'Urgente', '30 min')
    @nivel4 = ServicioSanitario::NivelSet.new(:IV, 'Menos Urgente', '45 min')
    @nivel5 = ServicioSanitario::NivelSet.new(:V, 'No Urgente', '60 min')
  end

  it "Se espera que la instancia pertenezca a a la clase determinada" do
    # Comprobamos que el método to_s devuelva el formato correcto
    expect(@nivel1).to be_a(ServicioSanitario::NivelSet)
    expect(@nivel4).to be_a(ServicioSanitario::NivelSet)
    expect(@nivel2.instance_of?(ServicioSanitario::NivelSet)).to be true
    expect(@nivel2.instance_of?(ServicioSanitario::Fecha)).to be false
    expect(ServicioSanitario::NivelSet.superclass).to eq(Object)
  end

  # Verifica que se puede crear una instancia de NivelSet
  it "Se espera poder crear una instancia de NivelSet" do
    expect(@nivel1).not_to be_nil
    expect(@nivel2).not_to be_nil
    expect(@nivel3).not_to be_nil
    expect(@nivel4).not_to be_nil
    expect(@nivel5).not_to be_nil
  end

  # Verifica que se puede obtener el valor correcto de nivel, categoría y tiempo de atención
  it "Se espera que se pueda obtener el valor correcto de nivel" do
    @nivel1 = ServicioSanitario::NivelSet.new(:I, 'Reanimacion', 'Inmediato')
    expect(@nivel1.nivel).to eq(:I)
    expect(@nivel1.categoria).to eq('Reanimacion')
    expect(@nivel1.tiempo_atencion).to eq('Inmediato')
    expect(@nivel2.nivel).to eq(:II)
    expect(@nivel2.categoria).to eq('Emergencia')
    expect(@nivel2.tiempo_atencion).to eq('7 min')
    expect(@nivel5.nivel).to eq(:V)
    expect(@nivel5.categoria).to eq('No Urgente')
    expect(@nivel5.tiempo_atencion).to eq('60 min')
  end

  # Verifica que se pueda obtener la representación en cadena correctamente
  it "Se espera poder devolver la representación en cadena de manera correcta" do
    expect(@nivel1.to_s).to eq("Nivel: I, Categoría: Reanimacion, Tiempo de atención: Inmediato")
    expect(@nivel4.to_s).to be_a(String)
    expect(@nivel3.to_s).to eq("Nivel: III, Categoría: Urgente, Tiempo de atención: 30 min")
    expect(@nivel5).not_to be_a(String)
  end

  # Verifica que las constantes estén correctamente definidas
  it "Se espera que las constantes esten correctamente definidas" do
    expect(ServicioSanitario::AZUL).to be_a(Hash)
    expect(ServicioSanitario::AZUL).to eq({ nivel: :I, categoria: :Reanimacion, tiempo_atencion: :Inmediato })
    expect(ServicioSanitario::ROJO).to be_a(Hash)
    expect(ServicioSanitario::ROJO).to eq({ nivel: :II, categoria: :Emergencia, tiempo_atencion: '7 minutos' })
    expect(ServicioSanitario::NARANJA).to be_a(Hash)
    expect(ServicioSanitario::NARANJA).to eq({ nivel: :III, categoria: :Urgente, tiempo_atencion: '30 minutos' })
    expect(ServicioSanitario::VERDE).to be_a(Hash)
    expect(ServicioSanitario::VERDE).to eq({ nivel: :IV, categoria: :Menos_urgente, tiempo_atencion: '45 minutos' })
    expect(ServicioSanitario::NEGRO).to be_a(Hash)
    expect(ServicioSanitario::NEGRO).to eq({ nivel: :V, categoria: :No_urgente, tiempo_atencion: '60 minutos' })
  end
end
