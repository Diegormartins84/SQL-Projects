use dbLojaJailson;

/*
Nova base de dados
*/

CREATE DATABASE dbLojaJailson;

/*
Loja de Sucos do Jailson

* Vende sucos (principalmente de laranja).

* Dados dos clientes:
	Nome (texto)
	nascimento (data dd/mm/aa)
	sexo (número)
	endereço
		Rua(texto)
		cidade(texto)
		estado(texto)
	Telefones(texto)

* Dados das Vendas:
	Número da venda(número)
	cliente que comprou(texto)
	preço total(número)

* Dados do produto:
	Nome(texto)
	Preço(número)
*/


/*
Truncar - Diminui o tamanho do texto/dado

nmProduto VARCHAR(3);

"coxinha" (7 letras) -> Cox
*/

-- Aula 4 - Criando Base de Dados (parte 1)

CREATE TABLE tb_Produtos(
	cdProduto INT PRIMARY KEY IDENTITY(1,1),
	nmProduto VARCHAR(50) NOT NULL , --Obrigatório
	vlProduto DECIMAL(6, 2) NOT NULL
);

CREATE TABLE tb_Clientes(
	cdCliente INT PRIMARY KEY IDENTITY(1,1),
	nmCliente VARCHAR(50) NOT NULL,
	dtNascimento DATE,
	inSexo VARCHAR(1) NOT NULL,
	nmEndereco VARCHAR(50),
	nmCidade VARCHAR(50),
	nmEstado VARCHAR(30),
	nmTelefone VARCHAR(15),
	nmTelefone2 VARCHAR(15)
)
/*
CREATE TABLE tb_Vendas(
	cdVenda INT PRIMARY KEY IDENTITY(1,1),
	cdProduto INT NOT NULL,
	vlProduto DECIMAL(6,2) NOT NULL
);*/

CREATE TABLE tb_Vendas(
	cdVenda INT PRIMARY KEY IDENTITY(1,1),
	cdCliente INT NOT NULL FOREIGN KEY REFERENCES tb_Clientes (cdCliente),
	dtVendas DATETIME NOT NULL
);

CREATE TABLE tb_ProdutoVenda(
	cdProdutoVenda INT PRIMARY KEY IDENTITY (1,1),
	cdVenda INT FOREIGN KEY REFERENCES tb_Vendas (cdVenda) NOT NULL,
	cdProduto INT FOREIGN KEY REFERENCES tb_Produtos (cdProduto) NOT NULL,
	qtProduto INT NOT NULL
)

-- FOREIGN KEY
-- CONSTRAINT

ALTER TABLE tb_Vendas
ADD CONSTRAINT FK_Produto_Vendas
FOREIGN KEY (cdProduto)
REFERENCES tb_Produtos(cdProduto)

/*
-- Inserções das tabelas
--INSERT INTO [nome da tabela] ([colunas]) VALUES()

INSERT INTO tb_Produtos VALUES ('Suco de Laranja', 4.5);
-- Ordem errada
--INSERT INTO tb_Produtos VALUES (1.5, 'Suco de Manga')
-- Com os nomes das colunas
INSERT INTO tb_Produtos (vlProduto, nmProduto) VALUES (1.5, 'Suco de Manga')

-- Testando o CONSTRAINT

INSERT INTO tb_Vendas VALUES (4, 3.2)


-- Selecionando dados das tabelas
-- SELECT [Colunas] FROM [tabela]

SELECT cdProduto, nmProduto, vlProduto FROM tb_Produtos;
SELECT nmProduto, vlProduto, cdProduto FROM tb_Produtos;
SELECT cdProduto FROM tb_Produtos;
SELECT * FROM tb_Vendas;
*/

-- Remover a tabela de vendas

-- DROP TABLE tb_Vendas

-- Inserindo novos produtos

-- SELECT * FROM tb_Produtos;
-- SELECT * FROM tb_Clientes;
-- SELECT * FROM tb_Vendas;
-- SELECT * FROM tb_ProdutoVenda;

-- INSERT INTO tb_ProdutoVenda VALUES (1, 1, 3) NAO FUNCIONA, BASES VAZIAS


-- 1 - Criar um cliente
/*
INSERT INTO tb_Clientes VALUES ('Paulo Guina', 
	'1980-05-01',
	'M',
	'Rua da Mecanica, 400',
	'Campinas',
	'São Paulo',
	'11 1234-5678',
	'11 912345678'
);
*/
-- 2 - Insert da venda
-- INSERT INTO tb_Vendas VALUES (1, GETDATE());
-- 3 - Insert da venda
-- INSERT INTO tb_ProdutoVenda VALUES (1, 1, 3);

/*
-- INNER JOIN
-- Soma dos valores dos produtos
SELECT * FROM tb_ProdutoVenda;

SELECT * FROM tb_Produtos;

-- Seleção dos dados com valores

SELECT * FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV
ON P.cdProduto = PV.cdProduto
/*
SELECT P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV
	ON P.cdProduto = PV.cdProduto
*/

SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente

SELECT C.nmCliente, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
--, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY C.nmCliente
*/
SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente

-- Soma dos valores
/*
SELECT C.nmCliente, SUM(PV.qtProduto) AS qtTotalProdutos, P.nmProduto, SUM(P.vlProduto*PV.qtProduto)
--, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY C.nmCliente, P.nmProduto
*/
SELECT C.nmCliente, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
--, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY C.nmCliente

-- Union ALL
-- Seleção dos dados com valores
/*
SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente

UNION ALL

SELECT V.cdVenda, C.nmCliente, NULL, 'Total produtos - Total vendas', SUM(PV.qtProduto) AS qtTotalProdutos, NULL, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
GROUP BY V.cdVenda, C.nmCliente
*/

SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto, TOTAL_VENDAS.qtTotalProdutos, TOTAL_VENDAS.qtValorTotalVenda
FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
INNER JOIN (
	SELECT V.cdVenda, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	GROUP BY V.cdVenda
	) AS TOTAL_VENDAS ON V.cdVenda = TOTAL_VENDAS.cdVenda
--WHERE V.cdCliente = 3
	;

/*
	-- Criando Stored Procedures
--Tem que ser a primeira função do lote
CREATE PROCEDURE sp_TotalVendasProdutosCliente(
	@cdCliente INT
)
AS 


SELECT V.cdVenda, C.nmCliente, P.cdProduto, P.nmProduto, PV.qtProduto, P.vlProduto, qtProduto * vlProduto AS qtValorTotalProduto, TOTAL_VENDAS.qtTotalProdutos, TOTAL_VENDAS.qtValorTotalVenda
FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
INNER JOIN tb_Clientes as C ON V.cdCliente = C.cdCliente
INNER JOIN (
	SELECT V.cdVenda, SUM(PV.qtProduto) AS qtTotalProdutos, SUM(P.vlProduto*PV.qtProduto) AS qtValorTotalVenda
	FROM tb_Produtos AS P INNER JOIN tb_ProdutoVenda as PV ON P.cdProduto = PV.cdProduto
	INNER JOIN tb_Vendas as V ON PV.cdVenda = V.cdVenda
	GROUP BY V.cdVenda
	) AS TOTAL_VENDAS ON V.cdVenda = TOTAL_VENDAS.cdVenda
WHERE V.cdCliente = @cdCliente

-- sp_TotalVendasProdutosCliente 1
*/

/*
INSERT INTO tb_Clientes VALUES ('José Penha', '1977-05-07', 'M', 'Rua da Mecanica, 33', 'Campinas', 'São Paulo', '11 1233-4434', '11 99283-9099')
INSERT INTO tb_Clientes VALUES ('Zequinha Muriçoca', '1988-05-07', 'M', 'Rua Jambira, 13', 'Campinas', 'São Paulo', '11 1584-2214', '')
INSERT INTO tb_Clientes VALUES ('Mariazinha de Lá', '1981-05-07', 'F', 'Rua Jambira, 13', 'Campinas', 'São Paulo', '11 1584-2214', '')
*/

SELECT * FROM tb_Clientes
SELECT * FROM tb_ClientesBackup
/*
SELECT *
INTO tb_ClientesBackup
FROM tb_Clientes
*/

CREATE TABLE tb_Enderecos (
	cdEndereco INT NOT NULL PRIMARY KEY IDENTITY (1,1)
	nmEndereco VARCHAR(50) NOT NULL,
	nmCep VARCHAR (9)
)

CREATE TABLE tb_Cidades (
	cdCidade INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	nmCidade VARCHAR(50) NOT NULL


CREATE TABLE tb_Estados (
	cdEstado INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	nmEstado VARCHAR(30) NOT NULL,
	nmSigla VARCHAR(2) NOT NULL
)


ALTER TABLE tb_Enderecos
ADD CONSTRAINT FK_Enderecos_Cidades
FOREIGN KEY (cdCidade)
REFERENCES tb_Cidades (cdCidade)

ALTER TABLE tb_Cidades
ADD CONSTRAINT FK_Cidades_Estados
FOREIGN KEY (cdEstado)
REFERENCES tb_Estados (cdEstado)


/******** Script do comando SelectTopNRolls de SSMS *******/
/*
SELECT TOP 1000 [cdCliente]
	,[nmCliente]
	,[dtNascimento]
	,[inSexo]
	,[nmEndereco]
	,[nmCidade]
	,[nmEstado]
	,[nmTelefone1]
	,[nmTelefone2]
FROM [dbLojaJailson].[dbo].[tb_ClientesBackup]
*/


-- Iniciar a transação
-- BEGIN TRAN para fazer todas as alterações necessárias, confirmar se está OK e depois dar commit
BEGIN TRAN

CREATE TABLE #tmp_Estados (
	cdEstado INT IDENTITY(1,1),
	nmEstado VARCHAR(30),
	nmSigla VARCHAR(2)
)

-- Insedir dados dos estados na tabela temporária
INSERT INTO #tmp_Estados (nmEstado)
SELECT DISTINCT nmEstado FROM tb_Clientes ORDER BY nmEstado;

-- Update na Sigla
UPDATE #tmp_Estados SET nmSigla = 'SP' WHERE nmEstado = 'São Paulo'

SET IDENTITY_INSERT tb_Estados ON; --insere na coluna de identity

-- Inserindo na tabela de Estado

INSERT INTO tb_Estados (cdEstado, nmEstado, nmSigla)
SELECT cdEstado, nmEstado, nmSigla FROM #tmp_Estados

-- SELECT * FROM #tmp_Estados
-- SELECT * FROM tb_Estados

DROP TABLE #tmp_Estados

SET IDENTITY_INSERT tb_Estados OFF;

ROLLBACK TRAN
-- COMMIT TRAN

------------------------------------------------------------------------

-- Migrar cidades para a tabela tb_Cidades

BEGIN TRAN; -- iniciar a transação

CREATE TABLE #tmp_Cidades(
	cdCidade INT IDENTITY (1,1),
	nmCidade VARCHAR(50),
	cdEstado INT
);

SET IDENTITY_INSERT #tmp_Cidades ON; --insere na coluna de identity


-- Inserir os dados das cidades na tabela temporária

INSERT INTO #tmp_Cidades (cdCidade)
SELECT DISTINCT nmCidade FROM tb_Clientes
ORDER BY nmCidade

-- Tratamento de dados

-- Update do código do estado

--Maneira mais complexo (update com join):
BEGIN TRAN;
UPDATE TC
SET TC.cdEstado = E.cdEstado
FROM #tmp_Cidades AS TC
INNER JOIN tb_Clientes AS T ON TC.nmCidade = T.nmCidade
INNER JOIN tb_Estado AS E ON T.nmEstado = E.nmEstado

SELECT * FROM tb_Estados AS E
INNER JOIN tb_Clientes AS C ON E.nmEstado = C.nmEstado

SELECT DISTINCT E.cdEstado, C.nmCidade FROM tb_Estados as E
INNER JOIN tb_Clientes as C ON E.nmEstado = C.nmEstado


SELECT * FROM #tmp_Cidades

ROLLBACK TRAN;
--COMMIT TRAN

----------------------------------------------------------------

-- Migrar cidades para a tabela tb_Cidades

BEGIN TRAN; -- iniciar a transação

CREATE TABLE #tmp_Cidades(
	cdCidade INT IDENTITY (1,1),
	nmCidade VARCHAR(50),
	nmEstado VARCHAR(30),
	cdEstado INT
);

--DROP TABLE #tmp_Cidades
--SET IDENTITY_INSERT #tmp_Cidades ON; --insere na coluna de identity

-- Inserir os dados das cidades na tabela temporária

INSERT INTO #tmp_Cidades (nmCidade, nmEstado)
SELECT DISTINCT nmCidade, nmEstado FROM tb_Clientes
ORDER BY nmCidade

-- Tratamento de dados

-- Update do código do estado

--Maneira mais simples:
UPDATE TC SET
TC.cdEstado = E.cdEstado
FROM #tmp_Cidades as TC
INNER JOIN tb_Estados AS E
ON TC.nmEstado = E.nmEstado 


SET IDENTITY_INSERT tb_Cidades ON;

-- Inserir o nome na tabela de ciades
INSERT INTO tb_Cidades (cdCidade, nmCidade, cdEstado)
SELECT cdCidade, nmCidade, cdEstado FROM #tmp_Cidades

-- SELECT * FROM tb_Cidades

--SELECT * FROM #tmp_Cidades
-- DROP TABLE #tmp_Cidades

SET IDENTITY_INSERT tb_Cidades OFF;
ROLLBACK TRAN;
--COMMIT TRAN

----------------------------------------------------------------

SELECT * FROM tb_Clientes
SELECT * FROM tb_Cidades
SELECT * FROM tb_Enderecos (NOLOCK)

BEGIN TRAN;

INSERT INTO tb_Enderecos (nmEndereco, cdCidade)
SELECT
	C.nmEndereco,
	CI.cdCidade
FROM tb_Clientes as C (NOLOCK) INNER JOIN tb_Cidades as CI
ON C.nmCidade = CI.nmCidade

ROLLBACK TRAN;
COMMIT TRAN;

----------------------------------------------------------------

USE dbLojaJailson;

SELECT * FROM tb_Clientes

BEGIN TRAN;

ALTER TABLE tb_Clientes
ADD cdEndereco INT NULL

ALTER TABLE tb_Clientes
ADD CONSTRAINT FK_ClientesEnderecos
FOREIGN KEY (cdEndereco)
REFERENCES tb_Enderecos(cdEndereco);

ROLLBACK TRAN;
-- COMMIT TRAN;

----------------------------------------------------------------


SELECT * FROM tb_Clientes
SELECT * FROM tb_Enderecos

BEGIN TRAN;

UPDATE C SET 
C.cdEndereco = E.cdEndereco
FROM tb_Enderecos AS E
INNER JOIN tb_Clientes AS C ON E.nmEndereco = C.nmEndereco

ROLLBACK TRAN;
--COMMIT TRAN;

----------------------------------------------------------------


BEGIN TRAN;

ALTER TABLE tb_Clientes
DROP COLUMN nmEndereco;
ALTER TABLE tb_Clientes
DROP COLUMN nmCidade;
ALTER TABLE tb_Clientes
DROP COLUMN nmEstado;

ROLLBACK TRAN;
--COMMIT TRAN;

----------------------------------------------------------------

/* CRIAR VIEW */

CREATE VIEW vw_EnderecoCompletoClientes
AS
SELECT
	CL.cdCliente,
	CL.nmCliente,
	CL.dtNascimento,
	CL.inSexo,
	EN.cdEndereco,
	EN.nmEndereco,
	EN.nmCep,
	CI.cdCidade,
	CI.nmCidade,
	E.cdEstado,
	E.nmEstado,
	E.nmSigla

FROM tb_Clientes AS CL INNER JOIN tb_Enderecos AS EN ON CL.cdEndereco = EN.cdEndereco
INNER JOIN tb_Cidades AS CI ON EN.cdCidade = CI.cdCidade
INNER JOIN tb_Estados AS E ON CI.cdEstado = E.cdEstado

SELECT * FROM vw_EnderecoCompletoClientes
----------------------------------------------------------------
/*
CREATE TABLE tb_Clientes_Hist(
	cdClientes_Hist INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
	cdCliente INT NOT NULL,
	nmCLiente VARCHAR(50),
	dtNascimento DATE NULL,
	inSexo VARCHAR(1) NULL,
	nmTelefone VARCHAR(9)
	)
*/
----------------------------------------------------------------

CREATE TABLE tb_TelefoneCliente(
	cdTelefone INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
	cdCliente INT NOT NULL,
	nmTelefone VARCHAR(15) NOT NULL,
	inAtivoSN VARCHAR(1) NOT NULL DEFAULT 'S'
)
ALTER TABLE tb_TelefoneCliente
ADD CONSTRAINT FK_TelefoneCliente_Cliente
FOREIGN KEY (cdCliente)
REFERENCES tb_Clientes(cdCliente)
--DROP TABLE tb_TelefoneCliente

----------------------------------------------------------------

BEGIN TRAN;
INSERT INTO tb_TelefoneCliente (cdCliente, nmTelefone)
SELECT cdCliente, nmTelefone FROM tb_Clientes;

INSERT INTO tb_TelefoneCliente (cdCliente, nmTelefone)
SELECT cdCliente, nmTelefone2 FROM tb_Clientes WHERE nmTelefone2 <> '';

ROLLBACK TRAN;
--COMMIT TRAN;

BEGIN TRAN;
ALTER TABLE tb_Clientes
DROP COLUMN nmTelefone;
ALTER TABLE tb_Clientes
DROP COLUMN nmTelefone2;
COMMIT TRAN;

----------------------------------------------------------------

CREATE TABLE tb_Clientes_Hist(
	cdClientes_Hist INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
	cdCliente INT NOT NULL,
	nmCLiente VARCHAR(50),
	dtNascimento DATE NULL,
	inSexo VARCHAR(1) NULL,
	cdEndereco INT NULL,
	dtInclusao DATETIME
);

CREATE TRIGGER tr_Backup_Clientes
ON tb_Clientes
FOR UPDATE
AS
	INSERT INTO tb_Clientes_Hist(cdCliente, nmCLiente, dtNascimento, inSexo, cdEndereco, dtInclusao)
	SELECT cdCliente, nmCLiente, dtNascimento, inSexo, cdEndereco, GETDATE() FROM deleted;

BEGIN TRAN;
UPDATE tb_Clientes SET nmCliente = 'Jailson' WHERE cdCliente = 1;
ROLLBACK TRAN;
COMMIT TRAN;

----------------------------------------------------------------

--   INTERMEDIARIO

----------------------------------------------------------------

-- Funções de tempo

-- Diferença entre DATE e DATETIME
-- GETDATE()
-- DATEDIFF()
-- DATEADD()
-- DATEPART()
-- BETWEEN
-- FORMAT

-- Funções de tempo

-- Diferença entre DATE e DATETIME
-- GETDATE()
SELECT GETDATE()
SELECT CAST(GETDATE() AS DATE)

-- DATEDIFF()
SELECT DATEDIFF (DAY, '1984-03-04', GETDATE())
SELECT DATEDIFF (MONTH, '1984-03-04', GETDATE())
SELECT DATEDIFF (YEAR, '1984-03-04', GETDATE())

-- DATEADD()
SELECT GETDATE()
SELECT DATEADD(day, -1, GETDATE())
SELECT DATEADD(MONTH, -1, DATEADD(year, -1, GETDATE()))

-- DATEPART()
SELECT DATEPART(WEEKDAY, GETDATE())
SELECT DATEPART(WEEKDAY, DATEADD(year, -1, GETDATE()))
SELECT DATEPART(WEEKDAY, '1984-03-04')
SELECT DATEPART(WEEK, '1984-03-04')

-- BETWEEN
SELECT * FROM tb_Vendas WHERE dtVendas BETWEEN DATEADD(year, -1, GETDATE()) AND GETDATE()

-- FORMAT
SELECT CAST(GETDATE() AS DATE)
SELECT FORMAT(CAST(GETDATE() AS DATE), 'dd/MM/yyyy')

SELECT * FROM tb_Vendas WHERE dtVendas >= FORMAT(GETDATE(), 'yyyy-MM-01')

----------------------------------------------------------------

-- Tabela temporária

CREATE TABLE #tmp_dados(
	nome VARCHAR(50) NULL,
	idade INT
);

INSERT INTO #tmp_dados (nome, idade) VALUES ('Jailson', 25);

SELECT * FROM #tmp_dados

SELECT * INTO #tmp_cidades FROM tb_Cidades

SELECT * FROM #tmp_cidades

UPDATE #tmp_cidades SET nmCidade = nmCidade + ' - Brasil'

DROP TABLE #tmp_cidades
DROP TABLE #tmp_dados

----------------------------------------------------------------

use dbLojaJailson;
  
  INSERT INTO dbLojaJailson.dbo.tb_Estados (nmSigla, nmEstado ) VALUES
  ('AC', 'Acre'),
  ('AL', 'Alagoas'),
  ('AP', 'Amapá'),
  ('AM', 'Amazonas'),
  ('BA', 'Bahia'),
  ('CE', 'Ceará'),
  ('DF', 'Distrito Federal'),
  ('ES', 'Espírito Santo'),
  ('GO', 'Goiás'),
  ('MA', 'Maranhão'),
  ('MT', 'Mato Grosso'),
  ('MS', 'Mato Grosso do Sul'),
  ('MG', 'Minas Gerais'),
  ('PA', 'Pará'),
  ('PE', 'Pernambuco'),
  ('PI', 'Piauí'),
  ('RJ', 'Rio de Janeiro'),
  ('RN', 'Rio Grande do Norte'),
  ('RS', 'Rio Grande do Sul'),
  ('RO', 'Rondônia'),
  ('RR', 'Roraima'),
  ('SC', 'Santa Catarina'),
  ('SP', 'São Paulo'),
  ('SE', 'Sergipe'),
  ('TO', 'Tocantins');


  INSERT INTO tb_Produtos(nmProduto, vlProduto) VALUES 
  ('Suco de Morango', 4.0), 
  ('Suco de Macho', 5.0),
  ('Suco de Tamarindo', 4.0),
  ('Coxinha', 3.5),
  ('X-Beico', 6.12),
  ('X-Gordo Safado', 11.9),
  ('Infartinho', 10),
  ('Ai, que delícia!', 9.90),
  ('X-Paulo Guina', 5.5),
  ('Porção de Peça que Você Queria', 15.0),
  ('Sorvete Sweet Dreams', 20.0),
  ('Refrigerante Lata', 4.5),
  ('Pãum de Batatah', 6.0),
  ('Refrigerante 2L', 8.0),
  ('Bala Juquinha', 0.5);


  INSERT INTO tb_Vendas (cdCliente, dtVenda) VALUES (1, GETDATE());

--------------------------------------------------------------

  SELECT * FROM tb_Estados
SELECT * FROM tb_Produtos

-- Salvar os duplicados

SELECT nmProduto, vlProduto
INTO #tmp_Backup
FROM tb_Produtos
WHERE nmProduto IN (
SELECT
	nmProduto
FROM
	tb_Produtos
GROUP BY 
	nmProduto
HAVING
	COUNT(*) >=2
)

-- Apagar os duplicados da base principal
BEGIN TRAN;
DELETE FROM tb_ProdutoVenda


DELETE FROM tb_Produtos
WHERE nmProduto IN(
SELECT
	nmProduto
FROM
	tb_Produtos
GROUP BY 
	nmProduto
HAVING
	COUNT(*) >=2
)

ROLLBACK TRAN;

-- Voltar com os dados sem a duplicidade
  
SELECT * FROM #tmp_Backup

DELETE FROM #tmp_Backup WHERE vlProduto = 25.00

INSERT INTO tb_Produtos
SELECT * FROM #tmp_Backup

----------------------------------------------------------------


SELECT AVG(vlProduto) FROM tb_Produtos

SELECT STDEV(vlProduto) FROM tb_Produtos --Desvio padrão

SELECT nmProduto, vlProduto, Calc.Media, Calc.DesvioPadrao, (vlProduto - Calc.Media) / Calc.DesvioPadrao AS Z_Score
FROM tb_Produtos, (
SELECT AVG(vlProduto) AS Media,
STDEV(vlProduto) AS DesvioPadrao
FROM tb_Produtos) AS Calc

----------------------------------------------------------------

SELECT
	nmProduto, vlProduto,
	AVG(vlProduto) OVER() AS Media,
	STDEV(vlProduto) OVER() AS DesvioPadrao,
	(vlProduto - AVG(vlProduto) OVER()) / STDEV(vlProduto) OVER() AS Z_Score
FROM
	tb_Produtos

----------------------------------------------------------------

SELECT nmProduto, vlProduto, Posicao
FROM(
	SELECT
		nmProduto, vlProduto,
		RANK() OVER(ORDER BY vlProduto DESC) AS Posicao
	FROM
		tb_Produtos
	) AS Dados
WHERE Posicao BETWEEN 5 AND 10

----------------------------------------------------------------

-- Variáveis
DECLARE @maiorPreco DECIMAL (6,2);

SELECT @maiorPreco;

SET @maiorPreco = (SELECT MAX(vlProduto) FROM tb_Produtos);

SELECT @maiorPreco;

----------------------------------------------------------------

SELECT
	cdProduto,
	nmProduto,
	vlProduto,
	CASE
		WHEN vlProduto <= 6.0 THEN vlProduto * 1.2
		WHEN vlProduto > 6.0 THEN vlProduto * 0.8 ELSE vlProduto
	END AS vlProdutoComDesconto
FROM
	tb_Produtos

----------------------------------------------------------------

DECLARE @desconto SMALLINT;
SET @desconto = 1; --1 = com desconto, 2 = sem desconto
  
IF @desconto = 1
	BEGIN
		SELECT TOP (1000) [cdProduto]
			,[nmProduto]
			,[vlProduto]
			,CASE
			WHEN vlProduto > 4 THEN vlProduto * 0.8 ELSE vlProduto
			END AS vl_ProdutoDesconto
		FROM [dbLojaJailson].[dbo].[tb_Produtos]
	END
ELSE
	SELECT TOP (1000) [cdProduto]
      ,[nmProduto]
      ,[vlProduto]
	FROM [dbLojaJailson].[dbo].[tb_Produtos]

----------------------------------------------------------------

/*
Comparadores
= igual
<> diferente
> maior
>= maior ou igual
<= menor ou igual
*/

< menor
SELECT TOP (1000) [BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2017].[HumanResources].[Employee]
  WHERE SickLeaveHours > 20 AND SickLeaveHours < 40

----------------------------------------------------------------

SELECT TOP (1000) [BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2017].[HumanResources].[Employee]
  --WHERE JobTitle = 'Design Engineer'
 -- WHERE JobTitle LIKE '%Engineer' --ter Enginner no fim
  WHERE JobTitle LIKE '%Engineer%' --ter Enginner

----------------------------------------------------------------

-- Declarando variáveis
DECLARE @x INT;
SET @x = 2
--print @x
SELECT @x

----------------------------------------------------------------

-- Outro tipo de tabela temporária (variável)
-- Não pode criar variável dentro de uma view

DECLARE @tabela TABLE(
	cdProduto INT PRIMARY KEY,
	nmProduto VARCHAR(50)
)

INSERT INTO @tabela VALUES (1, 'Churros')

SELECT * FROM @tabela

----------------------------------------------------------------

-- Operadores lógicos
SELECT TOP (1000) [BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
	  ,DATEDIFF(YEAR, BirthDate, GETDATE()) AS Idade
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2017].[HumanResources].[Employee]
--WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > 40
WHERE NOT (DATEDIFF(YEAR, BirthDate, GETDATE())) > 40
--AND Gender = 'M'
-- DATEDIFF(YEAR, HireDate, GETDATE()) > 2
OR Gender = 'F'

--Operadores:
-- AND
-- OR
-- NOT

----------------------------------------------------------------

--use AdventureWorks2017;
-- Bases utilizadas:
--[AdventureWorks2017].[HumanResources].[Employee]
--[AdventureWorks2017].[Person].[Person]

-- Criando função de valor escalar
--'CREATE FUNCTION' deve ser a primeira instrução em um lote de consultas

CREATE FUNCTION UDF_NomeCompletoIdade(@BusinessEntityID INT)
RETURNS VARCHAR(250)
AS
BEGIN

	RETURN (SELECT DISTINCT
		P.FirstName + ' ' + P.MiddleName + '. ' + P.LastName + ', ' + CAST(DATEDIFF(YEAR, E.BirthDate, GETDATE()) AS VARCHAR(4)) + ' anos'
	FROM Person.Person AS P INNER JOIN HumanResources.Employee AS E
	ON P.BusinessEntityID = E.BusinessEntityID
	WHERE P.BusinessEntityID = @BusinessEntityID
	)
END

SELECT AdventureWorks2017.dbo.UDF_NomeCompletoIdade(40)

SELECT TOP (1000) [BusinessEntityID]
	,AdventureWorks2017.dbo.UDF_NomeCompletoIdade(BusinessEntityID) AS NomeCompleto
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2017].[HumanResources].[Employee]

  --sp_helptext UDF_NomeCompletoIdade

----------------------------------------------------------------

/*
	Caso você tenha uma pasta para salvar seus scripts
	Autor: Zurubabel
	Data: 2024-10-04 01:41h
	Base: AdventureWorks2017
	Pasta:

	Função que retorna os dados completos do funcionário.

--sp_helptext UDF_DadosCompletosFuncionarios
*/


CREATE FUNCTION UDF_DadosCompletosFuncionarios()
RETURNS @Retorno TABLE(
	NomeCompleto VARCHAR(70),
	Idade INT,
	Nascimento DATE,
	Sexo VARCHAR(1),
	AnosCasa INT,
	Cargo VARCHAR(50)
)
AS
BEGIN

INSERT INTO @Retorno

	SELECT 
		P.FirstName + ' ' + isnull(P.MiddleName, '') + '. ' + P.LastName AS [NomeCompleto],
		DATEDIFF(YEAR, E.BirthDate, GETDATE()) AS Idade,
		E.BirthDate AS Nascimento,
		E.Gender AS Sexo,
		DATEDIFF(YEAR, E.HireDate, GETDATE()) AS AnosCasa,
		E.JobTitle AS Cargo
	FROM Person.Person AS P INNER JOIN HumanResources.Employee AS E
	ON P.BusinessEntityID = E.BusinessEntityID

	RETURN
END


--sp_helptext UDF_DadosCompletosFuncionarios
--SELECT * FROM AdventureWorks2017.dbo.UDF_DadosCompletosFuncionarios()
----------------------------------------------------------------

--Variáveis do cursor
DECLARE @FirstName VARCHAR(50),
		@MiddleName VARCHAR(50),
		@LastName VARCHAR(50);
		
-- Criando cursores
DECLARE cur_NomeCompleto CURSOR
FOR SELECT top 10 FirstName, MiddleName, LastName FROM Person.Person
--ORDER BY FirstName ASC

-- Abrindo o curso
OPEN cur_NomeCompleto

-- Selecionar os dados
FETCH NEXT FROM cur_NomeCompleto
INTO @FirstName, @MiddleName, @LastName;

--Iteração pelo dados retornados pelo cursor
WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @FirstName + ' ' + ISNULL(@MiddleName, '') + ' ' + @LastName
	
	--Pegar os próximos dados
	FETCH NEXT FROM cur_NomeCompleto
	INTO @FirstName, @MiddleName, @LastName;

END

--

SELECT @FirstName, @MiddleName, @LastName;

-- Fechando e desalocando o cursor da memória
CLOSE cur_NomeCompleto
DEALLOCATE cur_NomeCompleto

----------------------------------------------------------------

-- Índices --

----------------------------------------------------------------

--Verificar tempo de execução:
--SET STATISTICS TIME ON;

----------------------------------------------------------------

-- Forçar SQL a usar determinado índice

SELECT
      [PersonID]
  FROM [AdventureWorks2017].[Person].[BusinessEntityContact] WITH (index(IX_BusinessEntityContact_PersonID))

----------------------------------------------------------------

-- Criando índices antes da tabela possuir dados

/* CREATE TABLE tblTesteIndices(
	col1 INT,
	col2 INT
)*/

--Índice não clusterizado
--CREATE NONCLUSTERED INDEX IDX_1 ON tblTesteIndices(col1)

--Índice clusteriado
--CREATE CLUSTERED INDEX IDX_2 ON tblTesteIndices(col2)

-- Criando índices antes da tabela possuir dados

/*CREATE TABLE tblTesteIndices(
	col1 INT,
	col2 INT
)*/

----------------------------------------------------------------

--Índice não clusterizado
--CREATE NONCLUSTERED INDEX IDX_1 ON tblTesteIndices(col1)

--Índice clusteriado
--CREATE CLUSTERED INDEX IDX_2 ON tblTesteIndices(col2)

DECLARE @i INT
SET @i = 0
WHILE @i < 10000
BEGIN
	INSERT INTO tblTesteIndices (col1, col2) VALUES (ROUND(RAND() * 1000, 0), ROUND(RAND() * 1000, 0))
	SET @i = @i + 1
END

SELECT * FROM tblTesteIndices
--DELETE FROM tblTesteIndices

-- Criando índices depois da tabela possuir dados

-- Índice composto
-- Essa diferença entre uma chave composta clusteriza e não clusterizada
-- define a ordem dos valores das colunas, na outra define onde fica determinado dado para o SQL buscar mais rápido
CREATE INDEX IDX_1 ON tblTesteIndices(col1) INCLUDE (col2)

SELECT * FROM tblTesteIndices WHERE col2 = 50

CREATE CLUSTERED INDEX INX_2 ON tblTesteIndices (col1 ASC, col2 ASC)

----------------------------------------------------------------

-- Tabela variável

DECLARE @tabela TABLE (
	col1 INT INDEX IDX_1 CLUSTERED (col1 ASC, col2 ASC),
	col2 INT INDEX IDX_2 NONCLUSTERED (col1, col2)
)
-- não funciona na tabela variável: CREATE INDEX IDX_1 ON @tabela (col1)

-- Filegroups e Files no Management Studio

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DataRows](
	[ID] [INT] NOT NULL,
	[col1] [VARCHAR] (255) NULL,
	[col2] [VARCHAR] (255) NULL,
	[col3] [VARCHAR] (255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

----------------------------------------------------------------
-- SQL AVANÇADO --
----------------------------------------------------------------
/* Aula 1 - Armazenamento de base de dados

	# O SQL pode armazenar, em teoria, 32,767 base de dados
	# Cada base possui 1-n arquivos de log (.ldf) que armazena os dados para que possa ter uma
	# Cada base possui 1 arquivo primário (.mdf) e 0-n arquivos segundários (.ndf)
	# Todos os arquivos estão agrupados em filegroups (grupos de arquivos)
		* Um filegroup é uma unidade lógica para organizar os arquivos físicos da base de dados

MDF: A extensão de arquivo MDF (master data file) indica o arquivo de dados primário do banco de dados. 
NDF: A extensão de arquivo NDF (secondary data file) indica o arquivo de dados secundário do banco de dados. Este arquivo é opcional e pode ser definido pelo usuário para gerenciar o armazenamento de dados. 
LDF: A extensão de arquivo LDF (log data file) indica o arquivo de log de transações do banco de dados. O arquivo de log contém informações usadas para recuperar o banco de dados. 

*/

/*
	Aula 2 - Criando bases de dados (script)
*/

CREATE DATABASE SQLAvancado ON primary(
	name = N'SQLAvancado', filename = N'E:\Pythonestudo\SQL_backup\SQLAvancado.mdf'
), filegroup [PauloGuina] (
	name = N'PauloGuina', filename = N'E:\Pythonestudo\SQL_backup\PauloGuina.ndf'
), filegroup [Jailson] (
	name = N'Jailson', filename = N'E:\Pythonestudo\SQL_backup\Jailson.ndf'
), (
	name = N'QueDelicia', filename = N'E:\Pythonestudo\SQL_backup\QueDeliciaCara.ndf'
) log on (
	name = N'Jaja_Log', filename = 'E:\Pythonestudo\Sql_backup\SQL_log.ldf'
)

/*
	Aula 3 - Armazenamento de tabelas

	# Ao criar tabelas, elas serão armazenadas em seus respectivos filegroups
	# Se não for especificado o filegroup padrão, as tabelas serão criadas na PRIMARY

	Filegroups da base SQLAvancado:
		*[PauloGuina]
		*[Jailson]
*/


CREATE TABLE dbo.tblPrimary ( --Tabela que irá para o filegroup padrão (neste caso, o primary)
	coluna INT
)
CREATE TABLE dbo.tblPauloGuina (
	coluna INT
) ON [PauloGuina]
CREATE TABLE dbo.tblJailson (
	coluna INT
) ON [Jailson]

/*
	Aula 4 - Alterando o filegroup padrão de uma base de dados

	# Caso não seja alterado, as novas tabelas criadas irão para esse filegroup

	Filegroups da base SQLAvancado:
		*[PauloGuina]
		*[Jailson]
*/
-- Ao criar a base de dados

ALTER DATABASE SQLAvancado
MODIFY FILEGROUP Jailson DEFAULT;

-- No Wizard do SQL Server

/*
Aula 5 - Crescimento das tabelas (https://docs.microsoft.com/pt-br/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options)

	# Quando criamos os arquivos do banco de dados, o SQL cria com alguns padrões de tamanho inicial e crescimento (5MB e 10%)
	# Podemos configurar cada um de uma forma

	# Atributos:
		* SIZE = Tamanho inicial do arquivo
		* MAXSIZE = Tamanho máximo
		* FILEGROWTH = O quanto o arquivo cresce quando necessário
*/

-- Se existir a base, iremos removê-la

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'SQLAvancado') 
	DROP DATABASE SQLAvancado;

-- Recriando definindo o tamaho dos arquivos
CREATE DATABASE SQLAvancado ON primary (
	name = N'SQLAvancado', filename = N'c:\sql\SQLAvancado.mdf',
	SIZE = 5MB, FILEGROWTH = 10MB
), filegroup [PauloGuina] (
	name = N'PauloGuina', filename = N'c:\sql\PauloGuina.ndf'
), filegroup [Jailson] (
	name = N'Jailson', filename = N'c:\sql\Jailson.ndf'
), (
	name = N'QueDelicia', filename = N'f:\sql\QueDeliciaCara.ndf'
) log on (
	name = N'Jaja_Log', filename = 'c:\sql\Jaja_Log.ldf'
)

/*
	Aula 6 - Demonstrando o crescimento dos arquivos

	# Aula para demonstrar o crescimento entre arquivos.
	# Testaremos em duas tabelas: tblPauloguina (filegroup com 1 arquivo) e tblJailson (filegroup com 2 arquivos)s
*/

-- Tabela PauloGuina (Filegroup com 1 arquivo)
DECLARE @i int

set @i = 0

while @i < 1000000
begin

	INSERT INTO dbo.tblPauloGuina VALUES (@i)
	
	set @i = @i + 1;

end

-- Tabela tblJailson (Filegroup com 2 arquivos)

DECLARE @i int

set @i = 0

while @i < 1000000
begin

	INSERT INTO dbo.tblJailson VALUES (@i)
	
	set @i = @i + 1;

end

/*
	Aula 7 - Tipos de Armazenamento

	# De forma geral, existe três tipos de armazenamento e de índices: armazenamento em linha (rowstore), coluna (columnstore) e na memória (in-memory storage)
		* Também existem índices columstore
	# Rowstore - O "padrão" de armazenamento de tabelas relacionais
	# Columstore - É usado para tabelas de Data Warehouses (Tabelas de fatos e tabelas de dimensões)
		* https://logicalread.com/sql-server-columnstore-index-w02/#.WpxmHmrwbcc
		* https://www.mssqltips.com/sqlservertip/5225/sql-server-clustered-columnstore-index-examples-for-etl/
	# In-Memory OLTP 
		* https://www.youtube.com/watch?v=l5l5eophmK4 - Vídeo sobre a tecnologia
		* https://docs.microsoft.com/pt-br/sql/relational-databases/in-memory-oltp/in-memory-oltp-in-memory-optimization 

	# http://www.sqlservercentral.com/articles/ColumnStore+Index/125264/ - 
		Comparação entre as duas tecnologias (Índices de colunas x índices de linhas)
	# http://15721.courses.cs.cmu.edu/spring2017/papers/09-olapindexes/p1177-larson.pdf - Sobre o columnstore

*/

/*
	Aula 8 - Data Pages e Data Rows

	# Os espaços do Banco de Dados são divididos em páginas de 8kb cada;
	# As páginas são numeradas ordendamente começando pelo 0 (entra página = +1; sai página -1)
	# A página é composta por algumas partes: Page Header (96 bytes), data rows (onde os dados são armazenados),
	um espaço em branco e o	Slot Array;

	# O Header identifica os metadados da página (qual objeto pertence, quantidade de linhas, etcs);
	# Em seguida tem o espaço onde os dados das linhas são armazenados;
	# O Slot Array indica a ordem lógica dos dados na página
*/

/*
	Aula 9 - Tipos de dados do SQL Server e seu armazenamento

	# Os dados do SQL podem ser divididos em dois: Dados de tamanho fixo e de tamanho variável
	# Os de tamanho fixo ocupam um espaço fixo, independente se têm dados ou não;
	# Os de tamanho variável ocupam o espaço necessário, mais dois bytes;

	Entre os tipos estão:
		# Tamanho fixo: INT, DATETIME, CHAR...
		# Tamanho variável: VARCHAR, VARBINARY...

	* https://docs.microsoft.com/pt-br/sql/t-sql/data-types/data-types-transact-sql - Sobre tipos de dados
*/

/*
	Aula 10 - Armazenamento de dados na tabela (https://blogs.msdn.microsoft.com/fcatae/2016/04/26/dbcc-ind/)
	https://raresql.com/2013/01/24/sql-server-2012-sys-dm_db_database_page_allocations-dynamic-management-function/


	Funções de verificação
		sys.dm_db_database_page_allocations
		dbcc ind

	# Os dados são armazenados em páginas
	# Cada página possui N linhas de dados
	# Os campos são:
	•	PageFID – O id do arquivo da página;
	•	PagePID – o número da página no arquivo;
	•	IAMFID – O id do arquivo IAM (Index Allocation Map) que mapeia esta página (se o arquivo foi um IAM, o resultado será nulo, assim como o IAMFID da primeira linha da m (https://technet.microsoft.com/pt-br/library/ms187501(v=sql.105).aspx)
	•	IAMPID – o número da página que o arquivo IAM mapeia esta página;
	•	ObjectId – O ID que o índice desta página faz parte;
	•	PartitionNumber – O número da partição que esta página está;
	•	PartitionID – O ID interno da página ao qual o datarow está alocado;
	•	Iam_chain_type – o tipo da unidade de alocação (IN_ROW_DATA (para tabelas HEAP), LOB_DATA (Large Object) e ROW_OVERFLOW_DATA);
	•	PageType – Representa o tipo da página. As mais comuns são:
		o	1  - página de dados;
		o	2 – página de índice;
		o	3 e 4 – páginas de texto;
		o	8 – páginas GAM;
		o	9 – páginas SGAM;
		o	10 – página IAM;
		o	11 – página PFS;
	•	IndexLevel – Em qual nível a página está do índice (isso se estiver em algum índice). O número vai desde o 0 (página folha – mais na borda da árvore) até a página N, que é a raiz;
	•	NextPagaFID e NextPagePID – Próximas páginas;
	•	PrevPageFID e PrevPagePID – Páginas anteriores de acordo com o índice;
*/

create table tblJailson (
	col1 int NULL,
	col2 int
) on [Jailson]

insert into tblJailson values (1,2)


dbcc ind (
	'SQLAvancado', --banco de dados
	'dbo.tblJailson', --tabela
	-1 --tipo de exibição
)

--Para verificar como está armazenado na tabela:
dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	4, --File ID
	16, -- Page ID
	3 -- Tipo de display
)

select * from sys.dm_db_database_page_allocations(DB_ID(), OBJECT_ID('tblJailson'), null, null, 'DETAILED')

/*
	Aula 11 - Estrutura de um Data Row (http://aboutsqlserver.com/2013/10/15/sql-server-storage-engine-data-pages-and-data-rows/)	

	O DataRow é composto por algumas partes:
		* TagA e TagB (1 Byte cada) - Contém informações sobre o tipo de linha, se a linha foi apagada, se a linha tem valores NULL...
		* FSize (2 bytes) - Informa o tamanho dos dados de tamanho fixo
		* Fdata (N bytes) - Os dados da coluna de tamanho fixo
		* Ncol (2 bytes) - Informa a quantidade de colunas na linha
		* NullBits (N° colunas / 8 bytes) - Informa a quantidade de valores nulos
		-- Parte variável
		* VarCont (2 bytes) - Quantidade de colunas com dados de tamanho variável
		* VarOffset (2 * Varcount) bytes - Armazena 2 bytes x quantidade de colunas com valores variáveis, mesmo que a coluna tenha
		valores nulos
		* VarData (N bytes) - Os dados de valores variáveis
		* Tag de Versionamento (14 bytes) - Tag de versionamento para algumas operações	
*/


dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	4, --File ID
	16, -- Page ID
	3 -- Tipo de display
)

insert into tblJailson values (null, 1)

dbcc ind (
	'SQLAvancado',
	'dbo.tblJailson',
	-1
)

/*
	Insert 1

	select * from tblJailson
	* TagA  10
	* TagB  00
	* FSize 0c00
	* Fdata 
		- Col1 01000000
		- Col2 02000000
	* Ncol 020000
	* NullBits 00

*/
/*
	Aula 12 - Limites de espaço em uma página

	# Cada página só pode guardar até 8.060 bytes de dados de tamanho fixo
	# Demonstração das tabelas
*/

-- Tabela boa

use SQLAvancado

CREATE TABLE tbl_TabelaBoa(
	col1 CHAR(2000),
	col2 CHAR(2000)
)

dbcc ind(
	'SQLAvancado',
	'dbo.tbl_TabelaBoa', -- Nome da tabela
	1
)

insert into tbl_TabelaBoa values ('Churros', 'Pimenta')

dbcc traceon(3604);
dbcc page (
	'SQLAvancado', -- Base de dados
	1, -- FID
	121, -- PID
	3
)


-- Tabela Ruim
-- Falha na criação ou alteração da tabela 'tbl_TabelaRuim' porque o tamanho mínimo da linha seria 8067, incluindo 7 bytes de sobrecarga interna. Isso excede o tamanho máximo permitido de linha de tabela, que é 8060 bytes.

CREATE TABLE tbl_TabelaRuim (
	col1 CHAR(4000),
	col2 CHAR(4060)
)

CREATE TABLE tbl_TabelaRuim2 (
	col1 CHAR(2000),
	col2 CHAR(6060),
	col3 CHAR(30)
)
/*
	Aula 13 - Armazenamento Row Overflow

	# Existem dois tipos de armazenamento de dados:
		* Row Overflow Storage - Quando a página não excede 8.000 bytes
		* LOB Storage - Quando o objeto é grande (> 8kb)

	# Quanto maior a quandidade de colunas e dados, maior é a quantidade de páginas de Row Overflow

*/

create table tbl_RowOverflow (
	id int,
	col1 varchar(8000),
	col2 varchar(8000)
	--, col3 varchar(8000)
)

select * from tbl_RowOverflow

--insert into tbl_RowOverflow values (1, replicate('x', 800), replicate('y', 800)) --, replicate('z', 8000))

--insert into tbl_RowOverflow values (1, replicate('x', 8000), replicate('y', 8000)), replicate('z', 8000))

dbcc ind (
	'SQLAvancado',
	'dbo.tbl_RowOverflow',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	142,
	3
)
/*
	Aula 14 - Armazenamento LOB

	# Demonstração do LOB

	# Igual ao Row-Overflow, é uma página com ponteiro para outras folhas.

	# Caso a página não tenha espaço para o dado, será criada uma página nova
*/

CREATE TABLE tbl_TabelaLOB (
	id INT,
	texto VARCHAR(MAX)
)

INSERT INTO tbl_TabelaLOB VALUES (1, REPLICATE(CONVERT(VARCHAR(MAX), 'A'), 16000))


dbcc ind (
	'SQLAvancado',
	'dbo.tbl_TabelaLOB',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	156,
	3
)
/*
	Aula 15 - O problema do Select *

	# Graças a natureza do Select *, pode ser que ele selecione dados com várias páginas
*/
-- Korotkevitch, Dmitri. Pro SQL Server Internals (Locais do Kindle 1273-1279). Apress. Edição do Kindle. 

SET STATISTICS TIME ON

CREATE TABLE Employees
(
	EmployeeId int not null,
	Name varchar( 128) not null,
	Picture varbinary( max) null 
); 

;with N1( C) as 
(select 0 union all select 0) -- 2 rows 
,N2( C) as (select 0 from N1 as T1 cross join N1 as T2) -- 4 rows 
,N3( C) as (select 0 from N2 as T1 cross join N2 as T2) -- 16 rows 
,N4( C) as (select 0 from N3 as T1 cross join N3 as T2) -- 256 rows 
,N5( C) as (select 0 from N4 as T1 cross join N2 as T2) -- 1,024 rows 
,IDs( ID) as (select row_number() over (order by (select null)) from N5) 

insert into dbo.Employees( EmployeeId, Name, Picture)
select
	ID, 'Employee ' + convert( varchar( 5), ID),
	convert( varbinary( max), replicate( convert( varchar( max),' a'), 120000))         
from 
	Ids;


select EmployeeID, Name from dbo.Employees

SELECT * FROM Employees

/*
	Aula 16 - Extensões e Páginas de Alocação (https://technet.microsoft.com/en-us/library/ms190969(v=sql.105).aspx)

	# O SQL armazena em unidades de 8 páginas, totalizando 64kb chamadas extensões (extents)
	# As páginas podem estar de extensões mistas (mixed extends) ou de tipos iguais (uniform extends)
	# Por padrão a primeira extensão é mista. Depois ela é uniforme
	# As páginas são monitoradas através de mapas de alocação
	# O SQL possui arquivos de monitoramento chamados Mapas de Alocação (Allocation Maps)
		* IAM (Index Allocation Map) - Cuida das páginas de índices e de dados
		* GAM (Global Allocation Map) - Verifica se a páginas está alocada em qualquer objeto
		* SGAM (Shared Global Allocation Map) - Verifica se a página está alocada em uma extensão mista
			- GAM e SGAM podem cuidar de até 64.000 extensões (4GB)
*/

create table tbl_Teste(
	col1 char(5000)
)

INSERT INTO tbl_Teste values (replicate('x', 5000))

dbcc ind (
	'SQLAvancado',
	'dbo.tbl_Teste',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	32039,
	3
)

-- https://raresql.com/2013/01/24/sql-server-2012-sys-dm_db_database_page_allocations-dynamic-management-function/
select * from sys.dm_db_database_page_allocations(DB_ID(), OBJECT_ID('tbl_Teste'), NULL, NULL, 'DETAILED')

/*
	Aula 17 - Monitoramento de tamanho de páginas - PFS

	# O SQL monitora o tamanho de cada página através do Page Free Space
	# O monitoramento é feito por classes:
		* Vazio
		* 1-50%
		* 51-80%
		* 81-95%
		* 96-100%
	# Caso o SQL verifique que o tamanho dos dados extrapolará os 8k, será criada uma nova página
	# Cuidado ao criar tabelas com dados de tamanho fixo, pois pode acarretar em espaços sem uso

	- m_slotCnt = Quantidade de registros na página
	- m_freeCnt = Quantidade de bytes livres

	* Lembremos que existem outros dados além das informações das colunas
*/
-- DROP TABLE tbl_PFS

USE SQLAvancado

CREATE TABLE tbl_PFS (
	coluna INT -- INT = 4 bytes
)

-- 8.083
INSERT INTO tbl_PFS VALUES (1)

dbcc ind (
	'SQLAvancado',
	'dbo.tbl_PFS',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	32029,
	3
)

DECLARE @i int;
SET @i = 0
while @i < 500
begin	
	INSERT INTO tbl_PFS values (1);
	SET @i = @i + 1;
end

-- Tamanho variável

-- DROP TABLE tbl_PFS_Var 

create table tbl_PFS_Var (
	letra VARCHAR(4000)
)

INSERT INTO tbl_PFS_Var VALUES (replicate('x', 20))

dbcc ind (
	'SQLAvancado',
	'dbo.tbl_PFS_Var',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	32040,
	3
)

-- Tabela desperdício
-- DROP TABLE tbl_PFS_PerdeEspacoPraCaceteQueVoceVaiTerIdeiaAgora

CREATE TABLE tbl_PFS_PerdeEspacoPraCaceteQueVoceVaiTerIdeiaAgora (
	desperdicandoPraCacete CHAR(3500)
)

INSERT INTO tbl_PFS_PerdeEspacoPraCaceteQueVoceVaiTerIdeiaAgora VALUES ('A'), ('B'), ('C')

dbcc ind (
	'SQLAvancado',
	'dbo.tbl_PFS_PerdeEspacoPraCaceteQueVoceVaiTerIdeiaAgora',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	32029,
	3
)

-- Sigla CHAR(2)

/*
	Aula 18 - Alteração de data

	# Quando há uma alteração, o SQL realiza o seguinte processo
		* Lê a página a ser modificada e a coloca na memória (buffer pool)
		* Cria um log transação síncrono e depois atualiza a página no buffer
		* O banco de dados atualiza a página no disco assincronamente

	# Este processo é similar para as outras operações de manipulação de data (DML - INSERT, UPDATE, DELETE, SELECT e MERGE)

*/

/*
	Aula 19 - Sobre o tamanho dos dados e suas leituras (https://technet.microsoft.com/en-us/library/ms172424(v=sql.110).aspx)

	# O SQL é um aplicativo com muito uso de entrada e saída de disco (I/O)
	# Quanto maior a quantidade de páginas aos quais o dado está, mais I/O será demandada
	# Temos que verificar qual é o tamanho dos dados na hora de criarmos as tabelas
	# Dependendo do tipo de dado usado, pode haver uma grande economia de disco a longo prazo.

*/
USE SQLAvancado

CREATE TABLE tbl_Colunao (
	id int,
	colunao char(2000)
);

create table tbl_Coluninha (
	id int,
	coluninha varchar(2000)
)
-- Korotkevitch, Dmitri. Pro SQL Server Internals (Locais do Kindle 1408). Apress. Edição do Kindle. 
;with N1(C) as (select 0 union all select 0),
N2(C) as (Select 0 from N1 CROSS JOIN N1 as T2),
N3(C) as (Select 0 from N2 as T1 CROSS JOIN N2 as T2),
N4(C) as (Select 0 from N3 as T1 CROSS JOIN N3 as T2),
N5(C) as (Select 0 from N4 AS T1 CROSS JOIN N4 as T2),
IDs(ID) as (select row_number() over (order by (select null)) from N5)

INSERT INTO tbl_Colunao
SELECT ID, 'D' from IDs;


;with N1(C) as (select 0 union all select 0),
N2(C) as (Select 0 from N1 CROSS JOIN N1 as T2),
N3(C) as (Select 0 from N2 as T1 CROSS JOIN N2 as T2),
N4(C) as (Select 0 from N3 as T1 CROSS JOIN N3 as T2),
N5(C) as (Select 0 from N4 AS T1 CROSS JOIN N4 as T2),
IDs(ID) as (select row_number() over (order by (select null)) from N5)

INSERT INTO tbl_Coluninha
SELECT ID, 'D' from IDs;

dbcc ind (
	'SQLAvancado',
	'dbo.tbl_Coluninha',
	-1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	32029,
	3
)

/*

SET STATISTICS TIME ON

SELECT * FROM tbl_Coluninha
SELECT * FROM tbl_Colunao

DROP TABLE tbl_Coluninha
DROP TABLE tbl_Colunao

*/

/*
	Aula 20 - Alteração de tabelas

	# Ao alterar uma tabela (ALTER TABLE), o SQL pode proceder de três maneiras:
		* Só altera a metadata (drop de coluna ou alterar uma colona NOT NULL para NULL, por exemplo)
		* Altera a metadata, mas precisa de um table scan (de NULL para NOT NULL)
		* Altera o tipo da coluna e tem que haver a verificação de todas as linhas (de char para int)
*/

USE SQLAvancado

-- Criação da tabela de exemplo
CREATE TABLE tbl_ExemploAlteracao (
	InteiroNaoNull INT NOT NULL,
	InteiroNull INT NULL,
	BigInteiro BIGINT,
	Caractere CHAR(10),
	InteiroPequeno TINYINT
)

-- Primeiro caso
INSERT INTO tbl_ExemploAlteracao VALUES (1, 1, 50, 'Churros', 1)

ALTER TABLE tbl_ExemploAlteracao 
ALTER COLUMN InteiroNaoNull INT NULL

-- Segundo caso
DELETE FROM tbl_ExemploAlteracao;

INSERT INTO tbl_ExemploAlteracao VALUES (1, NULL, 50, 'Churros', 1)

ALTER TABLE tbl_ExemploAlteracao 
ALTER COLUMN InteiroNull INT NOT NULL

UPDATE tbl_ExemploAlteracao SET InteiroNull = 0 WHERE InteiroNull is NULL

-- Terceiro caso
DELETE FROM tbl_ExemploAlteracao;

INSERT INTO tbl_ExemploAlteracao VALUES (1, 1, 50, '1', 1)
INSERT INTO tbl_ExemploAlteracao VALUES (1, 1, 50, 'Jhonsons', 1)

ALTER TABLE tbl_ExemploAlteracao 
ALTER COLUMN Caractere INT 

INSERT INTO tbl_ExemploAlteracao VALUES (1, 1, 9223372036854775000, '1', 1)

ALTER TABLE tbl_ExemploAlteracao 
ALTER COLUMN BigInteiro INT 


dbcc ind (
	'SQLAvancado',
	'dbo.tbl_ExemploAlteracao',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	32019,
	3
)

/*
	Aula 21 - Resquícios das alterações de tabelas

	# Quando você diminui o tamanho ou dropa uma coluna, o SQL não retorna o tamanho "excedente"
	# Se você alterar o tamanho de uma coluna para outra maior (int para bigint), o SQL cria uma coluna
	com o espaço maior e copia os dados da coluna menor para a maior, ainda ocupando o espaço da coluna menor
	# ALTER REBUILD ajuda a resgatar o espaço perdido
*/

USE SQLAvancado

-- Criação da tabela de exemplo
-- DROP TABLE tbl_DadosPerdidos

CREATE TABLE tbl_DadosPerdidos (
	inteiro INT,
	tamanhoFixo CHAR(10),
	colunaGrande CHAR(500),
	numerinho TINYINT
)

-- Verificano o tamanho
-- Script do livro Korotkevitch, Dmitri. Pro SQL Server Internals (Locais do Kindle 1477-1481). Apress. Edição do Kindle. 
select
	c.column_id, 
	c.Name, 
	ipc.leaf_offset as [Offset in Row], 
	ipc.max_inrow_length as [Max Length], 
	ipc.system_type_id as [Column Type] 
from
	sys.system_internals_partition_columns ipc join sys.partitions p on ipc.partition_id = p.partition_id         
	join sys.columns c on c.column_id = ipc.partition_column_id and c.object_id = p.object_id 
where 
	p.object_id = object_id( N'dbo.tbl_DadosPerdidos') order by c.column_id;

-- Aumento de tamanho
ALTER TABLE tbl_DadosPerdidos
ALTER COLUMN numerinho BIGINT

-- 7.564
INSERT INTO tbl_DadosPerdidos VALUES (1, 2, 4)

-- Drop de coluna
ALTER TABLE tbl_DadosPerdidos
DROP COLUMN colunaGrande

dbcc ind (
	'SQLAvancado',
	'dbo.tbl_DadosPerdidos',
	1
)

dbcc traceon(3604)
dbcc page (
	'SQLAvancado',
	1,
	32008,
	3
)

-- O Rebuild irá criar uma nova página com outra numeração
ALTER TABLE tbl_DadosPerdidos REBUILD
