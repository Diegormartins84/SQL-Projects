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
	sexo (n�mero)
	endere�o
		Rua(texto)
		cidade(texto)
		estado(texto)
	Telefones(texto)

* Dados das Vendas:
	N�mero da venda(n�mero)
	cliente que comprou(texto)
	pre�o total(n�mero)

* Dados do produto:
	Nome(texto)
	Pre�o(n�mero)
*/


/*
Truncar - Diminui o tamanho do texto/dado

nmProduto VARCHAR(3);

"coxinha" (7 letras) -> Cox
*/

-- Aula 4 - Criando Base de Dados (parte 1)

CREATE TABLE tb_Produtos(
	cdProduto INT PRIMARY KEY IDENTITY(1,1),
	nmProduto VARCHAR(50) NOT NULL , --Obrigat�rio
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
-- Inser��es das tabelas
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
	'S�o Paulo',
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

-- Sele��o dos dados com valores

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
-- Sele��o dos dados com valores
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
--Tem que ser a primeira fun��o do lote
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
INSERT INTO tb_Clientes VALUES ('Jos� Penha', '1977-05-07', 'M', 'Rua da Mecanica, 33', 'Campinas', 'S�o Paulo', '11 1233-4434', '11 99283-9099')
INSERT INTO tb_Clientes VALUES ('Zequinha Muri�oca', '1988-05-07', 'M', 'Rua Jambira, 13', 'Campinas', 'S�o Paulo', '11 1584-2214', '')
INSERT INTO tb_Clientes VALUES ('Mariazinha de L�', '1981-05-07', 'F', 'Rua Jambira, 13', 'Campinas', 'S�o Paulo', '11 1584-2214', '')
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


-- Iniciar a transa��o
-- BEGIN TRAN para fazer todas as altera��es necess�rias, confirmar se est� OK e depois dar commit
BEGIN TRAN

CREATE TABLE #tmp_Estados (
	cdEstado INT IDENTITY(1,1),
	nmEstado VARCHAR(30),
	nmSigla VARCHAR(2)
)

-- Insedir dados dos estados na tabela tempor�ria
INSERT INTO #tmp_Estados (nmEstado)
SELECT DISTINCT nmEstado FROM tb_Clientes ORDER BY nmEstado;

-- Update na Sigla
UPDATE #tmp_Estados SET nmSigla = 'SP' WHERE nmEstado = 'S�o Paulo'

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

BEGIN TRAN; -- iniciar a transa��o

CREATE TABLE #tmp_Cidades(
	cdCidade INT IDENTITY (1,1),
	nmCidade VARCHAR(50),
	cdEstado INT
);

SET IDENTITY_INSERT #tmp_Cidades ON; --insere na coluna de identity


-- Inserir os dados das cidades na tabela tempor�ria

INSERT INTO #tmp_Cidades (cdCidade)
SELECT DISTINCT nmCidade FROM tb_Clientes
ORDER BY nmCidade

-- Tratamento de dados

-- Update do c�digo do estado

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

BEGIN TRAN; -- iniciar a transa��o

CREATE TABLE #tmp_Cidades(
	cdCidade INT IDENTITY (1,1),
	nmCidade VARCHAR(50),
	nmEstado VARCHAR(30),
	cdEstado INT
);

--DROP TABLE #tmp_Cidades
--SET IDENTITY_INSERT #tmp_Cidades ON; --insere na coluna de identity

-- Inserir os dados das cidades na tabela tempor�ria

INSERT INTO #tmp_Cidades (nmCidade, nmEstado)
SELECT DISTINCT nmCidade, nmEstado FROM tb_Clientes
ORDER BY nmCidade

-- Tratamento de dados

-- Update do c�digo do estado

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

-- Fun��es de tempo

-- Diferen�a entre DATE e DATETIME
-- GETDATE()
-- DATEDIFF()
-- DATEADD()
-- DATEPART()
-- BETWEEN
-- FORMAT

-- Fun��es de tempo

-- Diferen�a entre DATE e DATETIME
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

-- Tabela tempor�ria

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
  ('AP', 'Amap�'),
  ('AM', 'Amazonas'),
  ('BA', 'Bahia'),
  ('CE', 'Cear�'),
  ('DF', 'Distrito Federal'),
  ('ES', 'Esp�rito Santo'),
  ('GO', 'Goi�s'),
  ('MA', 'Maranh�o'),
  ('MT', 'Mato Grosso'),
  ('MS', 'Mato Grosso do Sul'),
  ('MG', 'Minas Gerais'),
  ('PA', 'Par�'),
  ('PE', 'Pernambuco'),
  ('PI', 'Piau�'),
  ('RJ', 'Rio de Janeiro'),
  ('RN', 'Rio Grande do Norte'),
  ('RS', 'Rio Grande do Sul'),
  ('RO', 'Rond�nia'),
  ('RR', 'Roraima'),
  ('SC', 'Santa Catarina'),
  ('SP', 'S�o Paulo'),
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
  ('Ai, que del�cia!', 9.90),
  ('X-Paulo Guina', 5.5),
  ('Por��o de Pe�a que Voc� Queria', 15.0),
  ('Sorvete Sweet Dreams', 20.0),
  ('Refrigerante Lata', 4.5),
  ('P�um de Batatah', 6.0),
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

SELECT STDEV(vlProduto) FROM tb_Produtos --Desvio padr�o

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

-- Vari�veis
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
< menor
<= menor ou igual
*/

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
 -- WHERE JobTitle LIKE '%Engineer'
  WHERE JobTitle LIKE '%Engineer%'

----------------------------------------------------------------
