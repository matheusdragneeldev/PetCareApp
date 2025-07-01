create database projeto_pet_care;
use projeto_pet_care;

create table login (
	id_login int auto_increment,
    email varchar(256) not null UNIQUE,
    tipo_user enum('Tutor', 'Clinica', 'ADM') not null,
    primary key (id_login)
);

create table adm (
	id_adm int auto_increment,
    foto longblob,
    nome varchar(80) not null,
    fk_id_login int not null,
    foreign key (fk_id_login) references login (id_login) ON DELETE CASCADE,
    primary key (id_adm)
);

create table tutor (
	id_tutor int auto_increment,
    foto longblob,
    nome varchar(80) not null,
    descricao text,
    telefone varchar(15),
    dt_nascimento date,
    fk_id_login int not null,
    foreign key (fk_id_login) references login (id_login) ON DELETE CASCADE,
    primary key (id_tutor)
);

create table clinica (
	id_clinica int auto_increment,
    foto longblob,
    nome varchar(80) not null,
    descricao text,
    cfmv_crmv varchar(15) not null UNIQUE,
    telefone varchar(15),
    funcionamento text,
    fk_id_login int not null,
    foreign key (fk_id_login) references login (id_login) ON DELETE CASCADE,
    primary key (id_clinica)
);

create table endereco (
	id_endereco int auto_increment,
    logradouro varchar(60) not null,
    numero varchar(10),
    complemento text,
    bairro varchar(60) not null,
    cidade varchar(60) not null,
    cep varchar(8),
    estado varchar(20) not null,
    fk_id_login int not null,
    foreign key (fk_id_login) references login (id_login)  ON DELETE CASCADE,
    primary key (id_endereco)
);

create table pet (
	id_pet int auto_increment,
    nome varchar(40) not null,
    foto LONGBLOB,
    descricao text,
    especie varchar(25) not null,
    raca varchar(25),
    cor varchar(20),
    sexo enum('Macho', 'Fêmea'),
    porte enum('Pequeno', 'Médio', 'Grande'),
    peso decimal(8,2),
    dt_nascimento date,
    fk_id_tutor int not null,
    foreign key (fk_id_tutor) references tutor (id_tutor) ON DELETE CASCADE,
    primary key (id_pet)
);

create table cartao_vacinacao (
	id_cartao_vacinacao int auto_increment,
    nome_vacina varchar(40) not null,
    dt_vacinacao date not null,
    lote_vacina varchar(40),
    medico_vet varchar(80),
    clinica_vet varchar(60),
    fk_id_pet int not null,
    foreign key (fk_id_pet) references pet (id_pet) ON DELETE CASCADE,
    primary key (id_cartao_vacinacao)
);

create table alerta_campanhas (
	id_alerta_campanha int auto_increment,
    nome_campanha varchar(80) not null,
	desc_campanha text not null,
    inicio_campanha date not null,
    fim_campanha date not null,
    fonte_web varchar(254),
    fk_id_login int not null,
    foreign key (fk_id_login) references login (id_login) ON DELETE CASCADE,
    primary key (id_alerta_campanha)
);

create table endereco_campanha (
	id_endereco_campanha int auto_increment,
    logradouro varchar(60) not null,
    numero varchar(10),
    complemento varchar(60),
    bairro varchar(60) not null,
    cidade varchar(60) not null,
    cep varchar(8),
    estado varchar(20) not null,
    fk_id_alerta_campanhas int not null,
    foreign key (fk_id_alerta_campanhas) references alerta_campanhas (id_alerta_campanha) ON DELETE CASCADE,
    primary key (id_endereco_campanha)
);

create table cadastro_doenca (
	id_cadastro_doenca int auto_increment,
    especie varchar(40) not null,
    nome_doenca varchar(60) not null,
    detalhes_doenca text not null,
    primary key (id_cadastro_doenca)
);

create table mensagens
  (
  id_mensagem int auto_increment,
  id_remetente int not null,
  id_destinatario int not null,
  mensagem text not null,
  dt_hr_mensagem datetime not null,
  primary key (id_mensagem),
  foreign key (id_remetente) references login (id_login) ON DELETE CASCADE,
  foreign key (id_destinatario) references login (id_login) ON DELETE CASCADE
  );
  
  create table feedback
  (
  id_feedback int auto_increment,
  id_remetente_feedback int not null,
  feedback_mensagem text not null,
  dt_hr_feedback datetime not null,
  status_feedback ENUM("Nao lido", "Lido", "Respondido"),
  primary key (id_feedback),
  foreign key (id_remetente_feedback) references login (id_login) ON DELETE CASCADE
  );


-- TRIGGERS

DELIMITER $$
DROP TRIGGER IF EXISTS inserir_ao_criar_login;
CREATE TRIGGER inserir_ao_criar_login
AFTER INSERT ON login
FOR EACH ROW
BEGIN
    
    -- Verificar o tipo_user
    IF NEW.tipo_user = 'Tutor' THEN
        INSERT INTO tutor (id_tutor, foto, nome, descricao, telefone, dt_nascimento, fk_id_login)
        VALUES (NEW.id_login, NULL, '', NULL, NULL, NULL, NEW.id_login); 
    ELSEIF NEW.tipo_user = 'Clinica' THEN
        INSERT INTO clinica (id_clinica, foto, nome, descricao, cfmv_crmv, telefone, funcionamento, fk_id_login)
        VALUES (NEW.id_login, NULL, '', NULL, NEW.id_login, NULL, NULL, NEW.id_login);
	ELSEIF NEW.tipo_user = 'ADM' THEN
        INSERT INTO adm (id_adm, nome, fk_id_login)
        VALUES (NEW.id_login, '', NEW.id_login);
    END IF;
    
    -- Inserir na tabela 'endereco', garantindo que o 'id_endereco' seja igual ao 'id_login'
    INSERT INTO endereco (id_endereco, logradouro, numero, complemento, bairro, cidade, cep, estado, fk_id_login)
    VALUES (NEW.id_login, '', '', NULL, '', '', '', '', NEW.id_login);
END $$
DELIMITER ;


-- Insert ADM

INSERT INTO login (email, tipo_user)
VALUES ('admin@admin.com', 'ADM');

-- Insert USER
INSERT INTO login (email, tipo_user)
VALUES ('elisa@tutor.com', 'Tutor'),
		('elisa@clinica.com', 'Clinica'),
        ('matheus@tutor.com', 'Tutor'),
        ('matheus@clinica.com', 'Clinica'),
        ('luiz@tutor.com', 'Tutor'),
		('luiz@clinica.com', 'Clinica'),
        ('eliezer@clinica.com', 'Clinica'),
        ('eliezer@tutor.com', 'Tutor'),
        ('esmailton@clinica.com', 'Clinica'),
        ('esmailton@tutor.com', 'Tutor'),
        ('emilly@clinica.com', 'Clinica'),
        ('emilly@tutor.com', 'Tutor');


-- VIEWS

DROP VIEW IF EXISTS info_clinica;
CREATE VIEW info_clinica AS
SELECT
cl.id_clinica,
cl.foto,
cl.nome,
cl.descricao,
cl.cfmv_crmv,
cl.telefone,
cl.funcionamento,
en.logradouro,
en.numero,
en.complemento,
en.bairro,
en.cidade,
en.cep,
en.estado
FROM clinica cl
INNER JOIN endereco en ON cl.id_clinica = en.id_endereco;


DROP VIEW IF EXISTS info_tutor;
CREATE VIEW info_tutor AS
SELECT
t.id_tutor,
t.foto,
t.nome,
t.descricao,
t.telefone,
t.dt_nascimento,
en.logradouro,
en.numero,
en.complemento,
en.bairro,
en.cidade,
en.cep,
en.estado
FROM tutor t
INNER JOIN endereco en ON t.id_tutor = en.id_endereco;


DROP VIEW IF EXISTS buscar_clinicas;
CREATE VIEW buscar_clinicas AS
SELECT l.id_login, cl.nome FROM login AS l
INNER JOIN clinica cl ON l.id_login = cl.id_clinica
WHERE l.tipo_user = 'Clinica'
ORDER BY cl.nome ASC;


DROP VIEW IF EXISTS info_campanha;
CREATE VIEW info_campanha AS
SELECT
l.id_login,
l.tipo_user,
ac.id_alerta_campanha,
ac.nome_campanha,
ac.desc_campanha,
ac.inicio_campanha,
ac.fim_campanha,
ac.fonte_web,
ec.cep as cep,
ec.logradouro as logradouro,
ec.numero as numero,
ec.complemento as complemento,
ec.bairro as bairro,
ec.cidade as cidade,
ec.estado as estado
FROM alerta_campanhas ac
INNER JOIN login l ON l.id_login = ac.fk_id_login
INNER JOIN endereco_campanha ec ON ec.fk_id_alerta_campanhas = ac.id_alerta_campanha
;


DROP VIEW IF EXISTS mini_info_clinica;
CREATE VIEW mini_info_clinica AS
SELECT cl.id_clinica, cl.nome, cl.descricao, cl.telefone, cl.funcionamento, e.bairro, e.cidade, e.estado
FROM clinica cl
INNER JOIN endereco e ON cl.id_clinica = e.fk_id_login;


DROP VIEW IF EXISTS adm_info_tutor;
CREATE VIEW adm_info_tutor AS
SELECT l.id_login, l.email, t.foto, t.nome, t.descricao ,t.telefone, t.dt_nascimento
FROM login AS l
INNER JOIN tutor AS t ON l.id_login = t.id_tutor;


DROP VIEW IF EXISTS adm_info_clinica;
CREATE VIEW adm_info_clinica AS
SELECT l.id_login, l.email, c.foto, c.nome, c.descricao, c.cfmv_crmv, c.telefone, funcionamento
FROM login AS l
INNER JOIN clinica AS c ON l.id_login = c.id_clinica;


DROP VIEW IF EXISTS adm_info_adm;
CREATE VIEW adm_info_adm AS
SELECT l.id_login, l.email, a.foto, a.nome
FROM login AS l
INNER JOIN adm AS a ON l.id_login = a.id_adm;


DROP VIEW IF EXISTS adm_info_feedback;
CREATE VIEW adm_info_feedback AS
SELECT l.id_login, l.email, f.feedback_mensagem, f.dt_hr_feedback, f.id_feedback
FROM login AS l
INNER JOIN feedback AS f ON l.id_login = f.id_remetente_feedback;


DROP VIEW IF EXISTS view_mensagens;
CREATE VIEW view_mensagens AS
SELECT 
    m.id_mensagem,
    m.mensagem,
    
    -- Dados do remetente
    r_clinica.id_clinica AS remetente_id_clinica,
    r_clinica.nome AS remetente_nome_clinica,
    r_clinica.foto AS remetente_foto_clinica,
    
    r_tutor.id_tutor AS remetente_id_tutor,
    r_tutor.nome AS remetente_nome_tutor,
    r_tutor.foto AS remetente_foto_tutor,

    -- Dados do destinatário
    d_clinica.id_clinica AS destinatario_id_clinica,
    d_clinica.nome AS destinatario_nome_clinica,
    d_clinica.foto AS destinatario_foto_clinica,

    d_tutor.id_tutor AS destinatario_id_tutor,
    d_tutor.nome AS destinatario_nome_tutor,
    d_tutor.foto AS destinatario_foto_tutor

FROM mensagens m
-- Remetente pode ser clínica
LEFT JOIN clinica r_clinica ON r_clinica.id_clinica = m.id_remetente
-- Ou tutor
LEFT JOIN tutor r_tutor ON r_tutor.id_tutor = m.id_remetente

-- Destinatário pode ser clínica
LEFT JOIN clinica d_clinica ON d_clinica.id_clinica = m.id_destinatario
-- Ou tutor
LEFT JOIN tutor d_tutor ON d_tutor.id_tutor = m.id_destinatario
ORDER BY m.id_mensagem;


DROP VIEW IF EXISTS view_cartao_vacinacao;
CREATE VIEW view_cartao_vacinacao AS
SELECT 
    cv.id_cartao_vacinacao,
    cv.nome_vacina,
    cv.dt_vacinacao,
    cv.lote_vacina,
    cv.medico_vet,
    cv.clinica_vet,
    cv.fk_id_pet,
    p.nome AS nome_pet,
    p.foto,
    p.fk_id_tutor
FROM 
    cartao_vacinacao cv
JOIN 
    pet p ON cv.fk_id_pet = p.id_pet;


-- Criando o super usuário
CREATE USER 'rootPetCare'@'%' IDENTIFIED BY '123';

GRANT ALL ON *.*
TO 'rootPetCare'@'%';