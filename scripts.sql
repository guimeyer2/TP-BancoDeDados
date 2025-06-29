-- Script SQL criação (DDL)
CREATE TABLE Instituicao (
    ID INT PRIMARY KEY,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(100)
);


CREATE TABLE Doador (
    doc_identificador VARCHAR(14) PRIMARY KEY, -- CPF (11) ou CNPJ (14)
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);


CREATE TABLE Campanha (
    id_campanha INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE,
    data_fim DATE
);


CREATE TABLE Receptor (
    CPF VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    endereco VARCHAR(255),
    id_instituicao INT NOT NULL,
    FOREIGN KEY (id_instituicao) REFERENCES Instituicao(ID)
);

CREATE TABLE Voluntario (
    CPF VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    id_instituicao INT NOT NULL,
    FOREIGN KEY (id_instituicao) REFERENCES Instituicao(ID)
);


CREATE TABLE Tipo_Item (
    id_tipo INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Doacao (
    id_doacao INT PRIMARY KEY,
    data_doacao DATE NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    doc_identificador_fk VARCHAR(14) NOT NULL,
    id_instituicao INT NOT NULL,
    id_campanha INT, 
    FOREIGN KEY (doc_identificador_fk) REFERENCES Doador(doc_identificador),
    FOREIGN KEY (id_instituicao) REFERENCES Instituicao(ID),
    FOREIGN KEY (id_campanha) REFERENCES Campanha(id_campanha)
);


CREATE TABLE Transacao_Saida (
    id_transacao INT PRIMARY KEY,
    data_saida DATE NOT NULL,
    cpf_voluntario VARCHAR(11) NOT NULL,
    cpf_receptor VARCHAR(11) NOT NULL,
    FOREIGN KEY (cpf_voluntario) REFERENCES Voluntario(CPF),
    FOREIGN KEY (cpf_receptor) REFERENCES Receptor(CPF)
);


CREATE TABLE Item (
    id_item INT PRIMARY KEY,
    descricao TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'Em Estoque',
    id_doacao INT NOT NULL,
    id_tipo INT NOT NULL,
    id_transacao INT, 
    FOREIGN KEY (id_doacao) REFERENCES Doacao(id_doacao),
    FOREIGN KEY (id_tipo) REFERENCES Tipo_Item(id_tipo),
    FOREIGN KEY (id_transacao) REFERENCES Transacao_Saida(id_transacao)
);

-- Script SQL população (DML) 
INSERT INTO Instituicao (ID, CNPJ, nome) VALUES
(1, '12345678000199', 'Inspira Sonhos - Sede Central');


INSERT INTO Tipo_Item (id_tipo, nome) VALUES
(10, 'Roupa de Frio Adulto'),
(11, 'Roupa Infantil'),
(20, 'Alimento Não Perecível'),
(30, 'Higiene Pessoal');


INSERT INTO Doador (doc_identificador, nome, email) VALUES
('11122233344', 'Carlos Pereira', 'carlos.p@email.com'),
('55566677788', 'Ana Julia Lima', 'ana.julia@email.com'),
('98765432000188', 'Supermercados Confiança', 'contato@confianca.com');


INSERT INTO Campanha (id_campanha, nome, data_inicio, data_fim) VALUES
(20241, 'Campanha do Agasalho 2024', '2024-05-01', '2024-07-30');


INSERT INTO Voluntario (CPF, nome, telefone, endereco, id_instituicao) VALUES
('10020030040', 'Mariana Costa', '31988776655', 'Rua das Flores, 10, Belo Horizonte', 1),
('50060070080', 'Ricardo Alves', '31977665544', 'Avenida Principal, 20, Contagem', 1);


INSERT INTO Receptor (CPF, nome, data_nascimento, endereco, id_instituicao) VALUES
('91092093094', 'Família Oliveira (representada por Maria)', '1980-04-15', 'Rua da Esperança, 30, Betim', 1),
('81082083084', 'José da Silva', '1955-11-20', 'Rua Solidariedade, 40, Belo Horizonte', 1);


INSERT INTO Doacao (id_doacao, data_doacao, telefone, endereco, doc_identificador_fk, id_instituicao, id_campanha) VALUES
(101, '2024-05-10', '31999998888', 'Rua dos Sabias, 50', '11122233344', 1, 20241),
(102, '2024-05-12', '3133221100', NULL, '98765432000188', 1, NULL),
(103, '2024-05-15', NULL, 'Avenida Afonso Pena, 1500', '55566677788', 1, 20241);


INSERT INTO Transacao_Saida (id_transacao, data_saida, cpf_voluntario, cpf_receptor) VALUES
(5001, '2024-05-20', '10020030040', '91092093094'),
(5002, '2024-05-22', '50060070080', '81082083084');


INSERT INTO Item (id_item, descricao, status, id_doacao, id_tipo, id_transacao) VALUES
(1001, 'Casaco de Lã Masculino G', 'Doado', 101, 10, 5002),
(1002, 'Cachecol de Lã', 'Doado', 101, 10, 5002),
(1003, 'Calça Jeans Infantil Tam 6', 'Em Estoque', 101, 11, NULL);

INSERT INTO Item (id_item, descricao, status, id_doacao, id_tipo, id_transacao) VALUES
(2001, 'Pacote de 5kg de Arroz', 'Doado', 102, 20, 5001),
(2002, 'Pacote de 1kg de Feijão', 'Doado', 102, 20, 5001),
(2003, 'Lata de 1kg de Leite em pó', 'Doado', 102, 20, 5001),
(2004, 'Kit Sabonetes (3 unidades)', 'Em Estoque', 102, 30, NULL);

INSERT INTO Item (id_item, descricao, status, id_doacao, id_tipo, id_transacao) VALUES
(3001, 'Cobertor de Casal', 'Em Estoque', 103, 10, NULL);

