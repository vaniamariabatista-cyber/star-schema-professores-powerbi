-- ATENÇÃO: os registros abaixo são dados fictícios, criados exclusivamente para demonstrar o modelo.
-- Não representam dados reais da instituição. Substitua por dados autorizados quando disponíveis.
USE star_schema_professores;

INSERT INTO dim_professor (professor_id_origem, nome_professor, titulo) VALUES
(101, 'Professor Demonstracao A', 'Mestre'),
(102, 'Professor Demonstracao B', 'Doutora');

INSERT INTO dim_departamento (departamento_id_origem, nome_departamento, campus, professor_coordenador_id_origem) VALUES
(10, 'Departamento Demonstracao de Tecnologia', 'Campus Central', 101),
(20, 'Departamento Demonstracao de Gestao', 'Campus Norte', 102);

INSERT INTO dim_curso (curso_id_origem, nome_curso, nivel) VALUES
(1001, 'Curso Demonstracao de Dados', 'Graduacao'),
(1002, 'Curso Demonstracao de Gestao', 'Graduacao');

INSERT INTO dim_disciplina (disciplina_id_origem, nome_disciplina) VALUES
(5001, 'Fundamentos de Dados'),
(5002, 'Analise de Processos');

INSERT INTO dim_data (data_completa, dia, mes, nome_mes, trimestre, ano) VALUES
('2026-01-15', 15, 1, 'Janeiro', 1, 2026),
('2026-02-15', 15, 2, 'Fevereiro', 1, 2026),
('2026-03-15', 15, 3, 'Marco', 1, 2026);

INSERT INTO fato_ministracao
(professor_key, departamento_key, curso_key, disciplina_key, data_key, quantidade_ofertas, carga_horaria)
SELECT p.professor_key, dep.departamento_key, c.curso_key, di.disciplina_key, dt.data_key, 1, 40.00
FROM dim_professor p
JOIN dim_departamento dep ON dep.departamento_id_origem = 10
JOIN dim_curso c ON c.curso_id_origem = 1001
JOIN dim_disciplina di ON di.disciplina_id_origem = 5001
JOIN dim_data dt ON dt.data_completa = '2026-01-15'
WHERE p.professor_id_origem = 101;

INSERT INTO fato_ministracao
(professor_key, departamento_key, curso_key, disciplina_key, data_key, quantidade_ofertas, carga_horaria)
SELECT p.professor_key, dep.departamento_key, c.curso_key, di.disciplina_key, dt.data_key, 1, 30.00
FROM dim_professor p
JOIN dim_departamento dep ON dep.departamento_id_origem = 20
JOIN dim_curso c ON c.curso_id_origem = 1002
JOIN dim_disciplina di ON di.disciplina_id_origem = 5002
JOIN dim_data dt ON dt.data_completa = '2026-02-15'
WHERE p.professor_id_origem = 102;
