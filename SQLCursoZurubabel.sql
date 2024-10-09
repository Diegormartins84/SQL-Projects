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

*/