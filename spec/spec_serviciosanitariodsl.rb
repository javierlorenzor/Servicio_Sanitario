require 'rspec'
require_relative '../lib/ServicioSanitario'
require_relative '../lib/ServicioSanitario/Medico'
require_relative '../lib/ServicioSanitario/Paciente'
require_relative '../lib/ServicioSanitario/Hospital'
require_relative '../lib/ServicioSanitario/ServicioSalud'
require_relative '../lib/ServicioSanitario/ServicioSanitarioDSL'

describe ServicioSanitario::ServicioSanitarioDSL do
  before(:each) do
    ServicioSanitario::ServicioSanitarioDSL.iniciar_sistema

    # Registrar Servicios
    ServicioSanitario::ServicioSanitarioDSL.registrar_servicio(tipo: :hospital, codigo: 'CIF012345678', descripcion: 'Hospital LPP', 
                                                               horario_apertura: '05:00:00', horario_cierre: '22:00:00',
                                                               dias_festivos: ['1/12/2024'], medicos: [], camas: {1 => nil, 2 => nil}, 
                                                               numero_plantas: 5)

    ServicioSanitario::ServicioSanitarioDSL.registrar_servicio(tipo: :servicio, codigo: 'CIF876543210', descripcion: 'Urgencias LPP', 
                                                               horario_apertura: '00:00:00', horario_cierre: '24:00:00',
                                                               dias_festivos: [], medicos: [], camas: {1 => nil})

    # Registrar Usuarios
    ServicioSanitario::ServicioSanitarioDSL.registrar_usuario(tipo: :medico, numero_identificacion: 2005001, nombre: 'Dr.', apellido: 'Poo', 
                                                              sexo: 'mujer', fecha_nacimiento: '01/01/1990', especialidad: 'geriatría')
    ServicioSanitario::ServicioSanitarioDSL.registrar_usuario(tipo: :medico, numero_identificacion: 2005002, nombre: 'Dr.', apellido: 'Fup', 
                                                              sexo: 'hombre', fecha_nacimiento: '01/01/1995', especialidad: 'general')
    ServicioSanitario::ServicioSanitarioDSL.registrar_usuario(tipo: :paciente, numero_identificacion: 2024001, nombre: 'Paciente', 
                                                              apellido: 'Tos', sexo: 'hombre', fecha_nacimiento: '2/12/1935', 
                                                              prioridad: {nivel: :II, categoria: :leve, tiempo_atencion: '15 minutos'})
    ServicioSanitario::ServicioSanitarioDSL.registrar_usuario(tipo: :paciente, numero_identificacion: 2024002, nombre: 'Paciente', 
                                                              apellido: 'Caida', sexo: 'mujer', fecha_nacimiento: '1/11/2020', 
                                                              prioridad: {nivel: :II, categoria: :leve, tiempo_atencion: '15 minutos'})
  end

  it 'debería registrar servicios correctamente' do
    expect(ServicioSanitario::ServicioSanitarioDSL.estado_sistema).to include('Hospital LPP')
    expect(ServicioSanitario::ServicioSanitarioDSL.estado_sistema).to include('Urgencias LPP')
  end

  it 'debería registrar usuarios correctamente' do
    expect(ServicioSanitario::ServicioSanitarioDSL.estado_sistema).to include('Dr. Poo')
    expect(ServicioSanitario::ServicioSanitarioDSL.estado_sistema).to include('Paciente Tos')
  end

  it 'debería asignar médico a paciente correctamente' do
    resultado = ServicioSanitario::ServicioSanitarioDSL.asignar_medico_a_paciente(2005001, 2024001)
    expect(resultado).to include('Dr. Poo asignado al paciente Paciente Tos')
  end

  it 'debería solicitar servicio correctamente' do
    resultado = ServicioSanitario::ServicioSanitarioDSL.solicitar_servicio('CIF012345678', 2024001)
    expect(resultado).to include('Paciente Paciente Tos asignado a la cama')
  end

  it 'debería mostrar el estado del sistema formateado' do
    estado = ServicioSanitario::ServicioSanitarioDSL.estado_sistema
    expect(estado).to include('Servicios:')
    expect(estado).to include('Usuarios:')
  end
end