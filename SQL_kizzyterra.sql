SELECT *
FROM(
       SELECT *
          FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
          WHERE ano = 2016 AND id_municipio IN ('3304557') 
            AND CONTAINS_SUBSTR(resultado, 'eleito') 
            AND NOT CONTAINS_SUBSTR(resultado, 'nao')
        ORDER BY votos DESC
      )
WHERE id_candidato_bd IN (
  SELECT id_candidato_bd
  FROM `basedosdados.br_tse_eleicoes.candidatos`
  WHERE ano = 2018
ORDER BY votos DESC
)