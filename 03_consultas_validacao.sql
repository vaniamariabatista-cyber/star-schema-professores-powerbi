USE star_schema_professores;

-- 1. Conferir contagem de registros nas tabelas.
SELECT 'dim_professor' AS tabela, COUNT(*) AS total FROM dim_professor
UNION ALL SELECT 'dim_departamento', COUNT(*) FROM dim_departamento
UNION ALL SELECT 'dim_curso', COUNT(*) FROM dim_curso
UNION ALL SELECT 'dim_disciplina', COUNT(*) FROM dim_disciplina
UNION ALL SELECT 'dim_data', COUNT(*) FROM dim_data
UNION ALL SELECT 'fato_ministracao', COUNT(*) FROM fato_ministracao;

-- 2. Análise por professor, curso, departamento e data.
SELECT p.nome_professor,
       dep.nome_departamento,
       c.nome_curso,
       di.nome_disciplina,
       dt.data_completa,
       f.quantidade_ofertas,
       f.carga_horaria
FROM fato_ministracao f
JOIN dim_professor p ON p.professor_key = f.professor_key
JOIN dim_departamento dep ON dep.departamento_key = f.departamento_key
JOIN dim_curso c ON c.curso_key = f.curso_key
JOIN dim_disciplina di ON di.disciplina_key = f.disciplina_key
JOIN dim_data dt ON dt.data_key = f.data_key
ORDER BY dt.data_completa, p.nome_professor;

-- 3. Total de ofertas e carga horária por professor.
SELECT p.professor_id_origem,
       p.nome_professor,
       SUM(f.quantidade_ofertas) AS total_ofertas,
       SUM(COALESCE(f.carga_horaria, 0)) AS total_carga_horaria
FROM fato_ministracao f
JOIN dim_professor p ON p.professor_key = f.professor_key
GROUP BY p.professor_id_origem, p.nome_professor
ORDER BY total_ofertas DESC, p.nome_professor;

-- 4. Análise temporal por ano e mês.
SELECT dt.ano, dt.mes, dt.nome_mes,
       SUM(f.quantidade_ofertas) AS total_ofertas,
       SUM(COALESCE(f.carga_horaria, 0)) AS total_carga_horaria
FROM fato_ministracao f
JOIN dim_data dt ON dt.data_key = f.data_key
GROUP BY dt.ano, dt.mes, dt.nome_mes
ORDER BY dt.ano, dt.mes;
