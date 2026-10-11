-- Star Schema para análise de professores, cursos, departamentos e datas.
-- Baseado no conteúdo do enunciado anexado à atividade DIO.
-- O enunciado não fornece uma granularidade exata nem dados de oferta; a granularidade proposta
-- é uma linha por atribuição/oferta de uma disciplina a um professor num curso/departamento/data.

CREATE DATABASE IF NOT EXISTS star_schema_professores
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE star_schema_professores;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS fato_ministracao;
DROP TABLE IF EXISTS dim_data;
DROP TABLE IF EXISTS dim_disciplina;
DROP TABLE IF EXISTS dim_curso;
DROP TABLE IF EXISTS dim_departamento;
DROP TABLE IF EXISTS dim_professor;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE dim_professor (
    professor_key INT AUTO_INCREMENT PRIMARY KEY,
    professor_id_origem INT NOT NULL UNIQUE,
    nome_professor VARCHAR(150) NULL,
    titulo VARCHAR(100) NULL
) ENGINE=InnoDB;

CREATE TABLE dim_departamento (
    departamento_key INT AUTO_INCREMENT PRIMARY KEY,
    departamento_id_origem INT NOT NULL UNIQUE,
    nome_departamento VARCHAR(150) NOT NULL,
    campus VARCHAR(100) NULL,
    professor_coordenador_id_origem INT NULL
) ENGINE=InnoDB;

CREATE TABLE dim_curso (
    curso_key INT AUTO_INCREMENT PRIMARY KEY,
    curso_id_origem INT NOT NULL UNIQUE,
    nome_curso VARCHAR(150) NULL,
    nivel VARCHAR(80) NULL
) ENGINE=InnoDB;

CREATE TABLE dim_disciplina (
    disciplina_key INT AUTO_INCREMENT PRIMARY KEY,
    disciplina_id_origem INT NOT NULL UNIQUE,
    nome_disciplina VARCHAR(150) NULL
) ENGINE=InnoDB;

CREATE TABLE dim_data (
    data_key INT AUTO_INCREMENT PRIMARY KEY,
    data_completa DATE NOT NULL UNIQUE,
    dia TINYINT NOT NULL,
    mes TINYINT NOT NULL,
    nome_mes VARCHAR(15) NOT NULL,
    trimestre TINYINT NOT NULL,
    ano SMALLINT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE fato_ministracao (
    fato_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    professor_key INT NOT NULL,
    departamento_key INT NOT NULL,
    curso_key INT NOT NULL,
    disciplina_key INT NOT NULL,
    data_key INT NOT NULL,
    quantidade_ofertas INT NOT NULL DEFAULT 1,
    carga_horaria DECIMAL(8,2) NULL,
    CONSTRAINT fk_fato_professor FOREIGN KEY (professor_key) REFERENCES dim_professor(professor_key),
    CONSTRAINT fk_fato_departamento FOREIGN KEY (departamento_key) REFERENCES dim_departamento(departamento_key),
    CONSTRAINT fk_fato_curso FOREIGN KEY (curso_key) REFERENCES dim_curso(curso_key),
    CONSTRAINT fk_fato_disciplina FOREIGN KEY (disciplina_key) REFERENCES dim_disciplina(disciplina_key),
    CONSTRAINT fk_fato_data FOREIGN KEY (data_key) REFERENCES dim_data(data_key),
    CONSTRAINT chk_quantidade_ofertas CHECK (quantidade_ofertas >= 0),
    CONSTRAINT chk_carga_horaria CHECK (carga_horaria IS NULL OR carga_horaria >= 0)
) ENGINE=InnoDB;
