create database idk6;
use idk6;
CREATE TABLE Empleado (
  id_empleado INT PRIMARY KEY,
  nombres VARCHAR(30),
  apellidos VARCHAR(30),
  cedula varchar(10) unique,
  dirrecion_empleado varchar(50),
  email VARCHAR(30),
  telefono VARCHAR(15)
);

CREATE TABLE Horario (
  id_horario INT PRIMARY KEY,
  tipo_horario varchar(20),
  hora_salida TIME,
  hora_entrada TIME,
  hora_almuerzo_inicio TIME,
  hora_almuerzo_fin time
);

CREATE TABLE Vacacion (
  id_vacacion INT PRIMARY KEY,
  fecha_inicio DATE,
  fecha_fin DATE,
  descripcion varchar(50)
);

CREATE TABLE Contrato (
  id_contrato INT PRIMARY KEY,
  id_empleado int not null,
  id_horario int not null,
  id_vacacion int,
  fecha_contrato DATE,
  fecha_expiracion DATE,
  seguro VARCHAR(255),
  sueldo DECIMAL(10, 2),
  FOREIGN KEY (id_horario) REFERENCES Horario(id_horario),
  FOREIGN KEY (id_vacacion) REFERENCES Vacacion(id_vacacion),
  FOREIGN KEY (id_empleado) REFERENCES Empleado(id_Empleado)
);

CREATE TABLE Departamento (
  id_departamento INT PRIMARY KEY,
  nombre_departamento VARCHAR(255),
  ubicacion_departamento VARCHAR(110),
  descripcion VARCHAR(50)
);

CREATE TABLE Administrar (
  id_departamento INT ,
  id_contrato Int ,
  fecha_inicio_administrar DATE,
  fecha_fin_administrar DATE,
  cargo VARCHAR(25),
  telefono VARCHAR(20),
  direccion VARCHAR(255),
  primary key(id_departamento,id_contrato),
  foreign key(id_departamento) references Departamento(id_departamento),
  foreign key(id_contrato) references Contrato(id_contrato)
);

CREATE TABLE Evento(
  id_evento INT PRIMARY KEY,
  tipo_evento VARCHAR(30),
  descripcion_evento VARCHAR(50),
  observacion varchar(50)
  );

CREATE TABLE Tiene (	
  causa_evento varchar(30),
  id_evento INT ,
  id_contrato int ,
  fecha_evento date,
  primary key(id_evento, id_contrato),
  foreign key(id_evento) references Evento(id_evento),
  foreign key(id_contrato) references Contrato(id_contrato)
);


-- datos insertar tabla empleado
INSERT INTO Empleado (id_empleado, nombres, cedula, apellidos, email, telefono)
VALUES
  (1, 'Stefano', '1350509525', 'Aguilar', 'ste.aguilar@example.com', '987654321'),
  (2, 'María', '1302389129', 'López', 'maria.lopez@example.com', '123456789'),
  (3, 'Pedro', '0705920321', 'Gómez', 'pedro.gomez@example.com', '654321987');
  -- datos insertar tabla horario
  INSERT INTO Horario (id_horario, hora_salida, hora_entrada, hora_almuerzo_inicio, hora_almuerzo_fin)
VALUES
  (1, '08:00:00', '17:00:00', '12:00:00', '13:00:00'),
  (2, '09:00:00', '18:00:00', '12:30:00', '13:30:00'),
  (3, '07:30:00', '16:30:00', '12:15:00', '13:15:00');

  -- datos insertar tabla vacacion
INSERT INTO Vacacion (id_vacacion, fecha_inicio, fecha_fin, descripcion)
VALUES
  (1, '2023-01-01', '2023-01-15', 'Vacaciones de invierno'),
  (2, '2023-07-01', '2023-07-10', 'Descanso anual'),
  (3, '2023-03-15', '2023-03-20', 'Días personales');
  
  -- datos insertar tabla contrato
INSERT INTO Contrato (id_contrato, id_empleado, id_horario, id_vacacion,fecha_contrato,fecha_expiracion,seguro, sueldo)
VALUES
  -- (4, 2,1,2,'Seguro de salud', 2500.00),
  (4,3,1,null,'2023-03-01','2026-03-01','Seguro de vida',98000.00);
    -- datos insertar tabla departamento
INSERT INTO Departamento (id_departamento, nombre_departamento, ubicacion_departamento, descripcion)
VALUES
  (1, 'Departamento de Ventas', 'Piso 5', 'Encargado de las ventas y atención al cliente'),
  (2, 'Departamento de Recursos Humanos', 'Piso 2', 'Encargado de la gestión del personal'),
  (3, 'Departamento de Finanzas', 'Piso 3', 'Encargado de las finanzas y contabilidad');
    -- datos insertar tabla Administrar
INSERT INTO Administrar (id_departamento, id_contrato, fecha_inicio_administrar, fecha_fin_administrar, cargo, telefono, direccion)
VALUES
  (1, 1, '2023-01-01', '2023-12-31', 'Gerente Ventas', '1234567890', 'Dirección 1'),
  (2, 2, '2023-01-01', '2023-12-31', 'Gerente Recursos Humanos', '9876543210', 'Dirección 2'),
  (3, 3, '2023-01-01', '2023-12-31', 'Gerente Finanzas', '4567890123', 'Dirección 3');
    -- datos insertar tabla Evento
  INSERT INTO Evento (id_evento, tipo_evento, descripcion_evento)
VALUES
  (1, 'Reunión de Equipo', 'Reunión semanal '),
  (2, 'Capacitación en Ventas', 'Taller de técnicas '),
  (3, 'Celebración de Aniversario', 'Fiesta anual ');
      -- datos insertar tabla tiene
  INSERT INTO Tiene (id_evento, id_contrato, fecha_evento)
VALUES
  (1, 1, '2023-02-01'),
  (2, 2, '2023-03-15'),
  (5, 0, '2023-06-30');
  

SELECT Empleado.id_empleado, Empleado.nombres, Empleado.apellidos, Empleado.email,
Contrato.id_contrato, Contrato.fecha_contrato, Contrato.fecha_expiracion, Contrato.seguro, Contrato.sueldo
FROM Empleado
RIGHT JOIN Contrato ON Empleado.id_empleado = Contrato.id_empleado;

SELECT Vacacion.id_vacacion, Vacacion.fecha_inicio, Vacacion.fecha_fin, Vacacion.descripcion,
       Contrato.id_contrato, Contrato.fecha_contrato, Contrato.fecha_expiracion, Contrato.seguro, Contrato.sueldo
FROM Contrato
LEFT JOIN Vacacion ON Contrato.id_vacacion = Vacacion.id_vacacion;